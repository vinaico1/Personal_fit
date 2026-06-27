import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

const cache = new Map<string, string | null>();

// Extrai o video ID de uma URL youtube.com/watch?v=XXXX
function extrairVideoId(url: string | null | undefined): string | null {
  if (!url) return null;
  const match = url.match(/[?&]v=([a-zA-Z0-9_-]{11})/);
  return match?.[1] ?? null;
}

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
    const searchRes = await fetch(
      `https://wger.de/api/v2/exercise/search/?term=${encodeURIComponent(termo)}&language=english&format=json`,
      { signal: AbortSignal.timeout(5000) }
    );
    if (!searchRes.ok) { cache.set(termo, null); return null; }

    const searchData = await searchRes.json();
    const baseId = searchData?.suggestions?.[0]?.data?.base_id;
    if (!baseId) { cache.set(termo, null); return null; }

    // Tenta com is_main=true, depois sem filtro
    for (const params of ["&is_main=true", ""]) {
      const imgRes = await fetch(
        `https://wger.de/api/v2/exerciseimage/?exercise_base=${baseId}&format=json${params}`,
        { signal: AbortSignal.timeout(5000) }
      );
      if (!imgRes.ok) continue;

      const imgData = await imgRes.json();
      const rawUrl: string | null = imgData?.results?.[0]?.image ?? null;
      if (!rawUrl) continue;

      // Garante URL absoluta
      const imgUrl = rawUrl.startsWith("http") ? rawUrl : `https://wger.de${rawUrl}`;
      cache.set(termo, imgUrl);
      return imgUrl;
    }

    cache.set(termo, null);
    return null;
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

  if (id) {
    const supabase = await createClient();
    const { data } = await supabase
      .from("exercicios")
      .select("nome, gif_url, video_url")
      .eq("id", id)
      .single();

    // 1. Imagem já cacheada no banco
    if (data?.gif_url) {
      return NextResponse.json({ url: data.gif_url, source: "db" });
    }

    // 2. Thumbnail do YouTube (video_url com watch?v=ID específico)
    const videoId = extrairVideoId(data?.video_url);
    if (videoId) {
      const thumbUrl = `https://img.youtube.com/vi/${videoId}/hqdefault.jpg`;
      // Salva no banco para cache futuro
      await supabase.from("exercicios").update({ gif_url: thumbUrl }).eq("id", id);
      return NextResponse.json({ url: thumbUrl, source: "youtube" });
    }

    // 3. Wger.de como último recurso
    const nomeExercicio = nome ?? data?.nome ?? "";
    const imgUrl = await buscarImagemWger(nomeExercicio);
    if (imgUrl) {
      await supabase.from("exercicios").update({ gif_url: imgUrl }).eq("id", id);
    }
    return NextResponse.json({ url: imgUrl, source: "wger" });
  }

  const imgUrl = await buscarImagemWger(nome!);
  return NextResponse.json({ url: imgUrl, source: "wger" });
}
