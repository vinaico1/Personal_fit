"use client";

import { useState } from "react";
import { ChevronDown, ChevronUp, Timer, BarChart3 } from "lucide-react";
import type { Exercicio } from "@/types";

interface Props {
  exercicio: Exercicio;
  series: number;
  repeticoes: string;
  descanso: number;
  carga?: number;
}

export function ExercicioCard({ exercicio, series, repeticoes, descanso, carga }: Props) {
  const [expanded, setExpanded] = useState(false);
  const [seriesFeitas, setSeriesFeitas] = useState(0);

  function toggleSerie(idx: number) {
    setSeriesFeitas(prev => prev === idx + 1 ? idx : idx + 1);
  }

  return (
    <div className="bg-slate-800/60 border border-slate-700/50 rounded-xl overflow-hidden">
      <button
        onClick={() => setExpanded(!expanded)}
        className="w-full p-3 flex items-center justify-between text-left"
      >
        <div className="flex items-center gap-3">
          <div className="w-9 h-9 bg-purple-500/20 rounded-lg flex items-center justify-center shrink-0">
            <BarChart3 className="w-4 h-4 text-purple-400" />
          </div>
          <div>
            <p className="font-medium text-sm leading-tight">{exercicio.nome}</p>
            <p className="text-slate-500 text-xs">{exercicio.musculo_primario}</p>
          </div>
        </div>
        <div className="flex items-center gap-3">
          <div className="text-right">
            <p className="text-xs font-bold text-slate-300">{series}×{repeticoes}</p>
            {carga && <p className="text-xs text-slate-500">{carga}kg</p>}
          </div>
          {expanded ? <ChevronUp className="w-4 h-4 text-slate-500" /> : <ChevronDown className="w-4 h-4 text-slate-500" />}
        </div>
      </button>

      {expanded && (
        <div className="px-3 pb-3 border-t border-slate-700/50 pt-3">
          {/* Séries para marcar */}
          <div className="flex gap-2 mb-3">
            <span className="text-xs text-slate-500 self-center">Séries:</span>
            {Array.from({ length: series }).map((_, i) => (
              <button
                key={i}
                onClick={() => toggleSerie(i)}
                className={`w-8 h-8 rounded-lg text-xs font-bold transition-all ${
                  i < seriesFeitas
                    ? "bg-brand-500 text-white"
                    : "bg-slate-700 text-slate-400 hover:bg-slate-600"
                }`}
              >
                {i + 1}
              </button>
            ))}
            <div className="ml-auto flex items-center gap-1 text-xs text-slate-500">
              <Timer className="w-3.5 h-3.5" />
              {descanso}s
            </div>
          </div>

          {/* Instruções */}
          <div className="bg-slate-900/50 rounded-xl p-3">
            <p className="text-xs font-semibold text-slate-300 mb-1.5">Como executar:</p>
            <p className="text-xs text-slate-400 leading-relaxed whitespace-pre-line">
              {exercicio.instrucoes}
            </p>
            {exercicio.dicas && (
              <div className="mt-2 pt-2 border-t border-slate-700/50">
                <p className="text-xs font-semibold text-brand-400 mb-1">Dica:</p>
                <p className="text-xs text-slate-400">{exercicio.dicas}</p>
              </div>
            )}
          </div>

          {/* Equipamento e músculo */}
          <div className="flex gap-2 mt-2">
            {exercicio.equipamento && (
              <span className="text-xs bg-slate-700 text-slate-300 px-2 py-0.5 rounded-full">
                {exercicio.equipamento}
              </span>
            )}
            <span className={`text-xs px-2 py-0.5 rounded-full ${
              exercicio.dificuldade === "iniciante" ? "bg-brand-500/20 text-brand-400" :
              exercicio.dificuldade === "intermediario" ? "bg-yellow-500/20 text-yellow-400" :
              "bg-red-500/20 text-red-400"
            }`}>
              {exercicio.dificuldade}
            </span>
          </div>
        </div>
      )}
    </div>
  );
}
