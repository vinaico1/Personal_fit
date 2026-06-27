"use client";

import { useState, useEffect } from "react";
import Image from "next/image";
import { Dumbbell } from "lucide-react";

const CORES_GRUPO: Record<string, { bg: string; text: string; border: string }> = {
  Peito:   { bg: "bg-red-500/20",    text: "text-red-400",    border: "border-red-500/30" },
  Costas:  { bg: "bg-blue-500/20",   text: "text-blue-400",   border: "border-blue-500/30" },
  Ombros:  { bg: "bg-yellow-500/20", text: "text-yellow-400", border: "border-yellow-500/30" },
  Bíceps:  { bg: "bg-orange-500/20", text: "text-orange-400", border: "border-orange-500/30" },
  Tríceps: { bg: "bg-purple-500/20", text: "text-purple-400", border: "border-purple-500/30" },
  Pernas:  { bg: "bg-green-500/20",  text: "text-green-400",  border: "border-green-500/30" },
  Glúteos: { bg: "bg-pink-500/20",   text: "text-pink-400",   border: "border-pink-500/30" },
  Core:    { bg: "bg-cyan-500/20",   text: "text-cyan-400",   border: "border-cyan-500/30" },
  Cardio:  { bg: "bg-brand-500/20",  text: "text-brand-400",  border: "border-brand-500/30" },
};

function extrairVideoId(url: string | null | undefined): string | null {
  if (!url) return null;
  const match = url.match(/[?&]v=([a-zA-Z0-9_-]{11})/);
  return match?.[1] ?? null;
}

interface Props {
  exercicioId: string;
  exercicioNome: string;
  gifUrl?: string | null;
  grupoMuscular: string;
  videoUrl?: string | null;
}

export function ExercicioImagem({ exercicioId, exercicioNome, gifUrl: gifUrlInicial, grupoMuscular, videoUrl }: Props) {
  const [imgUrl, setImgUrl] = useState<string | null>(gifUrlInicial ?? null);
  const [carregando, setCarregando] = useState(!gifUrlInicial);
  const [erro, setErro] = useState(false);

  const cores = CORES_GRUPO[grupoMuscular] ?? { bg: "bg-slate-700/30", text: "text-slate-400", border: "border-slate-600/30" };
  const videoId = extrairVideoId(videoUrl);

  useEffect(() => {
    if (gifUrlInicial || erro) return;

    setCarregando(true);
    fetch(`/api/exercicio/imagem?id=${exercicioId}&nome=${encodeURIComponent(exercicioNome)}`)
      .then((r) => r.json())
      .then((data) => {
        setImgUrl(data.url ?? null);
        if (!data.url) setErro(true);
      })
      .catch(() => setErro(true))
      .finally(() => setCarregando(false));
  }, [exercicioId, exercicioNome, gifUrlInicial, erro]);

  // 1. Se tiver video ID → embed YouTube com player completo
  if (videoId) {
    return (
      <div className={`w-full rounded-xl overflow-hidden border ${cores.border} relative bg-black`} style={{ aspectRatio: "16/9" }}>
        <iframe
          src={`https://www.youtube.com/embed/${videoId}?rel=0&modestbranding=1`}
          title={`Demonstração: ${exercicioNome}`}
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowFullScreen
          className="absolute inset-0 w-full h-full"
        />
      </div>
    );
  }

  // 2. Loading
  if (carregando) {
    return (
      <div className={`w-full h-44 rounded-xl ${cores.bg} border ${cores.border} flex items-center justify-center`}>
        <div className="w-6 h-6 border-2 border-current border-t-transparent rounded-full animate-spin opacity-40" />
      </div>
    );
  }

  // 3. GIF/imagem da API (Wger ou thumbnail)
  if (imgUrl && !erro) {
    return (
      <div className={`w-full h-44 rounded-xl overflow-hidden border ${cores.border} relative bg-slate-900`}>
        <Image
          src={imgUrl}
          alt={`Demonstração: ${exercicioNome}`}
          fill
          className="object-cover"
          unoptimized
          onError={() => { setImgUrl(null); setErro(true); }}
        />
      </div>
    );
  }

  // 4. Placeholder
  return (
    <div className={`w-full h-44 rounded-xl ${cores.bg} border ${cores.border} flex flex-col items-center justify-center gap-2`}>
      <Dumbbell className={`w-10 h-10 ${cores.text} opacity-40`} />
      <span className={`text-xs ${cores.text} opacity-60`}>{grupoMuscular}</span>
    </div>
  );
}
