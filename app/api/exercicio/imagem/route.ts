import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

const cache = new Map<string, string | null>();

// Mapa: nome PT-BR → slug da página no fitnessprogramer.com
const FITNESSPROGRAMER_SLUGS: Record<string, string> = {
  "Supino Reto com Barra":              "bench-press",
  "Supino Inclinado com Halteres":      "incline-dumbbell-press",
  "Flexão de Braço":                    "push-up",
  "Crucifixo com Halteres":             "dumbbell-fly",
  "Puxada Frontal com Barra":           "lat-pulldown",
  "Remada Curvada com Barra":           "barbell-bent-over-row",
  "Barra Fixa":                         "pull-up",
  "Remada Unilateral com Halter":       "dumbbell-row",
  "Desenvolvimento com Halteres":       "dumbbell-shoulder-press",
  "Elevação Lateral":                   "dumbbell-lateral-raise",
  "Elevação Frontal":                   "dumbbell-front-raise",
  "Desenvolvimento Arnold":             "arnold-press",
  "Rosca Direta com Barra":             "barbell-curl",
  "Rosca Martelo":                      "hammer-curl",
  "Rosca Concentrada":                  "concentration-curl",
  "Tríceps Pulley":                     "triceps-pushdown",
  "Supino Fechado":                     "close-grip-bench-press",
  "Mergulho em Banco (Tricep Dip)":    "triceps-dips",
  "Agachamento com Barra":              "barbell-squat",
  "Leg Press 45°":                      "leg-press",
  "Stiff (Romanian Deadlift)":          "romanian-deadlift",
  "Extensora (Leg Extension)":          "leg-extension",
  "Flexora (Leg Curl)":                 "leg-curl",
  "Agachamento Búlgaro":                "dumbbell-bulgarian-split-squat",
  "Panturrilha em Pé":                  "standing-calf-raise",
  "Hip Thrust com Barra":               "barbell-hip-thrust",
  "Elevação Pélvica (Glute Bridge)":    "glute-bridge",
  "Prancha Isométrica":                 "plank",
  "Crunch Abdominal":                   "crunch",
  "Abdominal Bicicleta":                "bicycle-crunch",
};

async function buscarGifFitnessprogramer(nomeExercicio: string): Promise<string | null> {
  const slug = FITNESSPROGRAMER_SLUGS[nomeExercicio];
  if (!slug) return null;

  const cacheKey = `fp:${slug}`;
  if (cache.has(cacheKey)) return cache.get(cacheKey) ?? null;

  try {
    const res = await fetch(
      `https://fitnessprogramer.com/exercise/${slug}/`,
      { signal: AbortSignal.timeout(8000), next: { revalidate: 86400 } }
    );
    if (!res.ok) { cache.set(cacheKey, null); return null; }

    const html = await res.text();
    const match = html.match(/https:\/\/fitnessprogramer\.com\/wp-content\/uploads\/[^"']+\.gif/i);
    const url = match?.[0] ?? null;
    cache.set(cacheKey, url);
    return url;
  } catch {
    cache.set(cacheKey, null);
    return null;
  }
}

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const nome = searchParams.get("nome") ?? "";
  const id   = searchParams.get("id") ?? "";

  if (!nome && !id) {
    return NextResponse.json({ error: "Parâmetro 'nome' ou 'id' obrigatório" }, { status: 400 });
  }

  const supabase = await createClient();

  // 1. gif_url já salvo no banco
  if (id) {
    const { data } = await supabase
      .from("exercicios")
      .select("nome, gif_url")
      .eq("id", id)
      .single();

    if (data?.gif_url) {
      return NextResponse.json({ url: data.gif_url, source: "db" });
    }

    // 2. Busca no fitnessprogramer e persiste no banco
    const nomeExercicio = nome || data?.nome || "";
    const gifUrl = await buscarGifFitnessprogramer(nomeExercicio);
    if (gifUrl) {
      await supabase.from("exercicios").update({ gif_url: gifUrl }).eq("id", id);
      return NextResponse.json({ url: gifUrl, source: "fitnessprogramer" });
    }

    return NextResponse.json({ url: null });
  }

  // Busca por nome sem ID (usado em buscas avulsas)
  const gifUrl = await buscarGifFitnessprogramer(nome);
  return NextResponse.json({ url: gifUrl, source: gifUrl ? "fitnessprogramer" : null });
}
