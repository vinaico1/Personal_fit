"use client";

import { useState, useEffect } from "react";
import Image from "next/image";
import { Dumbbell, Play } from "lucide-react";

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

interface Props {
  exercicioId: string;
  exercicioNome: string;
  gifUrl?: string | null;
  grupoMuscular: string;
  videoUrl?: string | null;
}

export function ExercicioImagem({ exercicioId, exercicioNome, gifUrl: gifUrlInicial, grupoMuscular, videoUrl }: Props) {
  const [imgUrl, setImgUrl] = useState<string | null>(gifUrlInicial ?? null);
  const [source, setSource] = useState<string | null>(gifUrlInicial ? "db" : null);
  const [carregando, setCarregando] = useState(!gifUrlInicial);
  const [erro, setErro] = useState(false);

  const cores = CORES_GRUPO[grupoMuscular] ?? { bg: "bg-slate-700/30", text: "text-slate-400", border: "border-slate-600/30" };

  useEffect(() => {
    if (gifUrlInicial || erro) return;

    setCarregando(true);
    fetch(`/api/exercicio/imagem?id=${exercicioId}&nome=${encodeURIComponent(exercicioNome)}`)
      .then((r) => r.json())
      .then((data) => {
        setImgUrl(data.url ?? null);
        setSource(data.source ?? null);
        if (!data.url) setErro(true);
      })
      .catch(() => setErro(true))
      .finally(() => setCarregando(false));
  }, [exercicioId, exercicioNome, gifUrlInicial, erro]);

  if (carregando) {
    return (
      <div className={`w-full h-44 rounded-xl ${cores.bg} border ${cores.border} flex items-center justify-center`}>
        <div className="w-6 h-6 border-2 border-current border-t-transparent rounded-full animate-spin opacity-40" />
      </div>
    );
  }

  if (!imgUrl || erro) {
    return (
      <div className={`w-full h-44 rounded-xl ${cores.bg} border ${cores.border} flex flex-col items-center justify-center gap-2`}>
        <Dumbbell className={`w-10 h-10 ${cores.text} opacity-40`} />
        <span className={`text-xs ${cores.text} opacity-60`}>{grupoMuscular}</span>
      </div>
    );
  }

  const isYoutube = source === "youtube" || imgUrl.includes("ytimg.com") || imgUrl.includes("img.youtube.com");

  return (
    <a
      href={videoUrl ?? `https://www.youtube.com/results?search_query=${encodeURIComponent(exercicioNome)}`}
      target="_blank"
      rel="noopener noreferrer"
      className={`w-full h-44 rounded-xl overflow-hidden border ${cores.border} relative bg-slate-900 block`}
    >
      <Image
        src={imgUrl}
        alt={`Demonstração: ${exercicioNome}`}
        fill
        className="object-cover"
        unoptimized
        onError={() => { setImgUrl(null); setErro(true); }}
      />
      {/* Overlay com botão de play para thumbnails do YouTube */}
      {isYoutube && (
        <div className="absolute inset-0 flex flex-col items-center justify-center bg-black/30 hover:bg-black/10 transition-colors">
          <div className="w-12 h-12 rounded-full bg-red-600/90 flex items-center justify-center shadow-lg">
            <Play className="w-5 h-5 text-white fill-white ml-0.5" />
          </div>
          <span className="text-white text-xs mt-2 font-medium drop-shadow">Ver demonstração</span>
        </div>
      )}
    </a>
  );
}
