"use client";

import { useState } from "react";
import { ChevronDown, ChevronUp, Timer, CheckCircle, Circle } from "lucide-react";
import { ExercicioImagem } from "./exercicio-imagem";
import type { Exercicio } from "@/types";

const CORES_DIFICULDADE: Record<string, string> = {
  iniciante:     "bg-brand-500/20 text-brand-400",
  intermediario: "bg-yellow-500/20 text-yellow-400",
  avancado:      "bg-red-500/20 text-red-400",
};

interface Props {
  exercicio: Exercicio;
  series: number;
  repeticoes: string;
  descanso: number;
  carga?: number;
}

export function ExercicioCard({ exercicio, series, repeticoes, descanso, carga }: Props) {
  const [expanded, setExpanded] = useState(false);
  const [seriesFeitas, setSeriesFeitas] = useState<boolean[]>(Array(series).fill(false));

  const totalFeitas = seriesFeitas.filter(Boolean).length;
  const concluido = totalFeitas === series;

  function toggleSerie(idx: number) {
    setSeriesFeitas((prev) => prev.map((v, i) => (i === idx ? !v : v)));
  }


  return (
    <div className={`rounded-xl border overflow-hidden transition-all ${
      concluido ? "border-brand-500/50 bg-brand-500/5" : "border-slate-700/50 bg-slate-800/40"
    }`}>
      {/* Header — sempre visível */}
      <button
        onClick={() => setExpanded(!expanded)}
        className="w-full p-3.5 flex items-center gap-3 text-left"
      >
        {/* Indicador de séries */}
        <div className={`w-10 h-10 rounded-xl flex items-center justify-center shrink-0 font-bold text-sm transition-colors ${
          concluido ? "bg-brand-500 text-white" : "bg-slate-700 text-slate-300"
        }`}>
          {concluido ? "✓" : `${totalFeitas}/${series}`}
        </div>

        <div className="flex-1 min-w-0">
          <p className="font-semibold text-sm truncate">{exercicio.nome}</p>
          <p className="text-slate-500 text-xs">{exercicio.musculo_primario}</p>
        </div>

        <div className="flex items-center gap-2 shrink-0">
          <div className="text-right">
            <p className="text-xs font-bold text-slate-200">{series}×{repeticoes}</p>
            {carga && <p className="text-xs text-slate-500">{carga}kg</p>}
          </div>
          {expanded
            ? <ChevronUp className="w-4 h-4 text-slate-500" />
            : <ChevronDown className="w-4 h-4 text-slate-500" />
          }
        </div>
      </button>

      {/* Conteúdo expandido */}
      {expanded && (
        <div className="border-t border-slate-700/50">
          {/* Imagem de demonstração */}
          <div className="p-3 pb-0">
            <ExercicioImagem
              exercicioId={exercicio.id}
              exercicioNome={exercicio.nome}
              gifUrl={exercicio.gif_url}
              grupoMuscular={exercicio.grupo_muscular}
            />
          </div>

          <div className="p-3 space-y-3">
            {/* Badges */}
            <div className="flex gap-2 flex-wrap">
              <span className={`text-xs px-2.5 py-1 rounded-full font-medium ${CORES_DIFICULDADE[exercicio.dificuldade] ?? "bg-slate-700 text-slate-400"}`}>
                {exercicio.dificuldade}
              </span>
              {exercicio.equipamento && (
                <span className="text-xs px-2.5 py-1 rounded-full bg-slate-700 text-slate-300">
                  {exercicio.equipamento}
                </span>
              )}
              <span className="flex items-center gap-1 text-xs px-2.5 py-1 rounded-full bg-slate-700 text-slate-300">
                <Timer className="w-3 h-3" /> {descanso}s descanso
              </span>
            </div>

            {/* Marcador de séries */}
            <div>
              <p className="text-xs text-slate-500 mb-2">Marcar séries concluídas:</p>
              <div className="flex gap-2">
                {seriesFeitas.map((feita, i) => (
                  <button
                    key={i}
                    onClick={() => toggleSerie(i)}
                    className={`flex-1 flex flex-col items-center gap-1 py-2 rounded-xl border transition-all ${
                      feita
                        ? "border-brand-500 bg-brand-500/20 text-brand-400"
                        : "border-slate-600 bg-slate-800 text-slate-500 hover:border-slate-500"
                    }`}
                  >
                    {feita
                      ? <CheckCircle className="w-4 h-4" />
                      : <Circle className="w-4 h-4" />
                    }
                    <span className="text-xs font-medium">{i + 1}ª</span>
                    <span className="text-xs opacity-70">{repeticoes}</span>
                  </button>
                ))}
              </div>
            </div>

            {/* Instruções */}
            <div className="bg-slate-900/60 rounded-xl p-3">
              <p className="text-xs font-semibold text-slate-300 mb-2">Como executar:</p>
              <p className="text-xs text-slate-400 leading-relaxed whitespace-pre-line">
                {exercicio.instrucoes}
              </p>
              {exercicio.dicas && (
                <div className="mt-2.5 pt-2.5 border-t border-slate-700/50">
                  <p className="text-xs font-semibold text-brand-400 mb-1">💡 Dica:</p>
                  <p className="text-xs text-slate-400 leading-relaxed">{exercicio.dicas}</p>
                </div>
              )}
            </div>

            {/* Músculos secundários */}
            {exercicio.musculos_secundarios && exercicio.musculos_secundarios.length > 0 && (
              <div>
                <p className="text-xs text-slate-500 mb-1.5">Músculos secundários:</p>
                <div className="flex flex-wrap gap-1.5">
                  {exercicio.musculos_secundarios.map((m) => (
                    <span key={m} className="text-xs px-2 py-0.5 rounded-full bg-slate-700/60 text-slate-400">
                      {m}
                    </span>
                  ))}
                </div>
              </div>
            )}

          </div>
        </div>
      )}
    </div>
  );
}
