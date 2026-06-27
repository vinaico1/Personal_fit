import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

// Cache em memória para evitar chamadas repetidas ao Wger
const cache = new Map<string, string | null>();

// Mapeamento de nomes PT-BR → termos de busca em inglês para o Wger
const TRADUCOES: Record<string, string> = {
  "Supino Reto com Barra": "barbell bench press",
  "Supino Inclinado com Halteres": "incline dumbbell press",
  "Flexão de Braço": "push-up",
  "Crucifixo com Halteres": "dumbbell flyes",
  "Puxada Frontal com Barra": "lat pulldown",
  "Remada Curvada com Barra": "barbell row",
  "Barra Fixa": "pull-up",
  "Remada Unilateral com Halter": "one arm dumbbell row",
  "Desenvolvimento com Halteres": "dumbbell shoulder press",
  "Elevação Lateral": "lateral raise",
  "Elevação Frontal": "front raise",
  "Desenvolvimento Arnold": "arnold press",
  "Rosca Direta com Barra": "barbell curl",
  "Rosca Martelo": "hammer curl",
  "Rosca Concentrada": "concentration curl",
  "Tríceps Pulley": "triceps pushdown",
  "Supino Fechado": "close grip bench press",
  "Mergulho em Banco (Tricep Dip)": "triceps dip",
  "Agachamento com Barra": "barbell squat",
  "Leg Press 45°": "leg press",
  "Stiff (Romanian Deadlift)": "romanian deadlift",
  "Extensora (Leg Extension)": "leg extension",
  "Flexora (Leg Curl)": "leg curl",
  "Agachamento Búlgaro": "bulgarian split squat",
  "Panturrilha em Pé": "calf raise",
  "Hip Thrust com Barra": "barbell hip thrust",
  "Elevação Pélvica (Glute Bridge)": "glute bridge",
  "Prancha Isométrica": "plank",
  "Crunch Abdominal": "crunch",
  "Abdominal Bicicleta": "bicycle crunch",
};

async function buscarImagemWger(nomeExercicio: string): Promise<string | null> {
  const termo = TRADUCOES[nomeExercicio] ?? nomeExercicio;

  if (cache.has(termo)) return cache.get(termo) ?? null;

  try {
    // Buscar exercício pelo nome em inglês
    const searchRes = await fetch(
      `https://wger.de/api/v2/exercise/search/?term=${encodeURIComponent(termo)}&language=english&format=json`,
      { next: { revalidate: 86400 } }
    );

    if (!searchRes.ok) { cache.set(termo, null); return null; }

    const searchData = await searchRes.json();
    const sugestao = searchData?.suggestions?.[0];
    if (!sugestao?.data?.base_id) { cache.set(termo, null); return null; }

    const baseId = sugestao.data.base_id;

    // Buscar imagens deste exercício
    const imgRes = await fetch(
      `https://wger.de/api/v2/exerciseimage/?exercise_base=${baseId}&format=json&is_main=true`,
      { next: { revalidate: 86400 } }
    );

    if (!imgRes.ok) { cache.set(termo, null); return null; }

    const imgData = await imgRes.json();
    const imgUrl: string | null = imgData?.results?.[0]?.image ?? null;

    cache.set(termo, imgUrl);
    return imgUrl;
  } catch {
    cache.set(termo, null);
    return null;
  }
}

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const nome = searchParams.get("nome");
  const id = searchParams.get("id");

  if (!nome && !id) {
    return NextResponse.json({ error: "Parâmetro 'nome' ou 'id' obrigatório" }, { status: 400 });
  }

  // Se tiver ID, buscar gif_url salvo no banco primeiro
  if (id) {
    const supabase = await createClient();
    const { data } = await supabase
      .from("exercicios")
      .select("nome, gif_url, video_url")
      .eq("id", id)
      .single();

    if (data?.gif_url) {
      return NextResponse.json({ url: data.gif_url, source: "db" });
    }

    // Buscar no Wger pelo nome
    const nomeExercicio = nome ?? data?.nome ?? "";
    const imgUrl = await buscarImagemWger(nomeExercicio);

    // Salvar no banco para próximas chamadas
    if (imgUrl) {
      await supabase.from("exercicios").update({ gif_url: imgUrl }).eq("id", id);
    }

    return NextResponse.json({ url: imgUrl, source: "wger" });
  }

  const imgUrl = await buscarImagemWger(nome!);
  return NextResponse.json({ url: imgUrl, source: "wger" });
}
