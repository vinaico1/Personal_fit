"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Dumbbell, RefreshCw, CheckCircle, ChevronDown, ChevronUp } from "lucide-react";
import { toast } from "sonner";

const MODELOS = [
  {
    id: "fullbody",
    nome: "Full Body 3×",
    subtitulo: "Iniciante · 3 dias/semana",
    nivel: "iniciante" as const,
    dias: 3,
    frequencia: "Seg · Qua · Sex",
    objetivo: "Hipertrofia e condicionamento geral",
    descricao: "Treino completo em cada sessão — ideal para quem está começando ou tem pouco tempo. Cobre todos os grupos musculares 3× por semana com exercícios compostos.",
    split: [
      { dia: "Seg/Qua/Sex", foco: "Full Body", exercicios: ["Agachamento", "Supino", "Remada", "Desenvolvimento", "Rosca", "Tríceps", "Prancha"] },
    ],
    cor: "from-brand-500 to-brand-600",
    badge: "bg-brand-500/20 text-brand-400",
  },
  {
    id: "ppl",
    nome: "Push Pull Legs 6×",
    subtitulo: "Intermediário · 6 dias/semana",
    nivel: "intermediario" as const,
    dias: 6,
    frequencia: "Seg a Sáb · Dom descanso",
    objetivo: "Máxima hipertrofia muscular",
    descricao: "Divisão Push/Pull/Legs repetida 2× por semana — o split mais eficiente para ganho de massa. Cada grupo muscular é treinado com alta frequência e volume controlado.",
    split: [
      { dia: "Segunda", foco: "Push A", exercicios: ["Supino Reto", "Supino Inclinado", "Crucifixo", "Desenvolvimento", "Elevação Lateral", "Tríceps"] },
      { dia: "Terça",   foco: "Pull A", exercicios: ["Barra Fixa", "Remada", "Puxada", "Remada Unilateral", "Rosca Direta", "Rosca Martelo"] },
      { dia: "Quarta",  foco: "Legs A", exercicios: ["Agachamento", "Leg Press", "Stiff", "Hip Thrust", "Extensora", "Flexora", "Panturrilha"] },
      { dia: "Quinta",  foco: "Push B", exercicios: ["Supino Inclinado", "Supino", "Crucifixo", "Arnold Press", "Elevação Frontal", "Dip", "Supino Fechado"] },
      { dia: "Sexta",   foco: "Pull B", exercicios: ["Remada", "Puxada", "Remada Unilateral", "Barra Fixa", "Rosca Concentrada", "Rosca Martelo"] },
      { dia: "Sábado",  foco: "Legs B", exercicios: ["Leg Press", "Búlgaro", "Stiff", "Hip Thrust", "Flexora", "Extensora", "Panturrilha"] },
    ],
    cor: "from-purple-500 to-purple-700",
    badge: "bg-purple-500/20 text-purple-400",
  },
  {
    id: "abc",
    nome: "Divisão ABC 3×",
    subtitulo: "Intermediário · 3 dias/semana",
    nivel: "intermediario" as const,
    dias: 3,
    frequencia: "Seg · Qua · Sex",
    objetivo: "Hipertrofia com alta intensidade",
    descricao: "Cada treino foca em grupos musculares específicos com volume alto — permite máxima intensidade por grupo. Perfeito para intermediários que treinam 3× por semana.",
    split: [
      { dia: "Segunda", foco: "Dia A — Peito + Ombros + Tríceps", exercicios: ["Supino", "Supino Inclinado", "Crucifixo", "Desenvolvimento", "Elevação Lateral", "Tríceps Pulley", "Dip"] },
      { dia: "Quarta",  foco: "Dia B — Costas + Bíceps",          exercicios: ["Barra Fixa", "Remada", "Puxada", "Remada Unilateral", "Rosca Direta", "Rosca Martelo", "Rosca Concentrada"] },
      { dia: "Sexta",   foco: "Dia C — Pernas + Glúteos + Core",  exercicios: ["Agachamento", "Leg Press", "Stiff", "Hip Thrust", "Búlgaro", "Panturrilha", "Prancha"] },
    ],
    cor: "from-orange-500 to-orange-700",
    badge: "bg-orange-500/20 text-orange-400",
  },
] as const;

const COR_NIVEL: Record<string, string> = {
  iniciante:    "bg-brand-500/20 text-brand-400",
  intermediario:"bg-yellow-500/20 text-yellow-400",
  avancado:     "bg-red-500/20 text-red-400",
};

interface Props {
  modoTrocar?: boolean;
}

export function SelecionarModeloTreino({ modoTrocar = false }: Props) {
  const router = useRouter();
  const [selecionado, setSelecionado] = useState<string | null>(null);
  const [expandido, setExpandido] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function aplicar(modeloId: string) {
    setSelecionado(modeloId);
    setLoading(true);

    try {
      const res = await fetch("/api/treino/aplicar-modelo", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ modelo: modeloId }),
      });

      if (!res.ok) {
        const err = await res.json();
        throw new Error(err.error ?? "Erro ao aplicar programa");
      }

      const modelo = MODELOS.find(m => m.id === modeloId);
      toast.success(`Programa "${modelo?.nome}" aplicado com sucesso!`);
      router.refresh();
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Erro ao aplicar programa");
      setSelecionado(null);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div>
      {!modoTrocar && (
        <div className="text-center mb-6">
          <Dumbbell className="w-12 h-12 text-slate-600 mx-auto mb-3" />
          <h2 className="text-xl font-bold mb-1">Escolha seu programa</h2>
          <p className="text-slate-400 text-sm">Programas baseados em metodologias profissionais de musculação</p>
        </div>
      )}

      <div className="space-y-4">
        {MODELOS.map((modelo) => {
          const aberto = expandido === modelo.id;
          const aplicando = loading && selecionado === modelo.id;

          return (
            <div key={modelo.id} className="glass-card rounded-2xl overflow-hidden border border-slate-700/50 hover:border-slate-600/50 transition-all">
              {/* Header do card */}
              <div className="p-4">
                <div className="flex items-start justify-between gap-3 mb-3">
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1 flex-wrap">
                      <h3 className="font-bold text-base">{modelo.nome}</h3>
                      <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${COR_NIVEL[modelo.nivel]}`}>
                        {modelo.nivel}
                      </span>
                    </div>
                    <p className="text-slate-400 text-xs">{modelo.subtitulo}</p>
                  </div>
                  <div className="text-right shrink-0">
                    <p className="text-2xl font-black">{modelo.dias}<span className="text-sm font-normal text-slate-400">×</span></p>
                    <p className="text-xs text-slate-500">por semana</p>
                  </div>
                </div>

                <p className="text-slate-300 text-sm mb-4 leading-relaxed">{modelo.descricao}</p>

                <div className="flex gap-2">
                  <button
                    onClick={() => aplicar(modelo.id)}
                    disabled={loading}
                    className={`flex-1 flex items-center justify-center gap-2 py-2.5 rounded-xl font-semibold text-sm transition-all disabled:opacity-60 bg-gradient-to-r ${modelo.cor} text-white hover:opacity-90`}
                  >
                    {aplicando
                      ? <><RefreshCw className="w-4 h-4 animate-spin" /> Aplicando...</>
                      : <><CheckCircle className="w-4 h-4" /> {modoTrocar ? "Trocar para este" : "Usar este programa"}</>
                    }
                  </button>
                  <button
                    onClick={() => setExpandido(aberto ? null : modelo.id)}
                    className="px-3 py-2.5 rounded-xl bg-slate-800 text-slate-400 hover:text-white hover:bg-slate-700 transition-all"
                  >
                    {aberto ? <ChevronUp className="w-4 h-4" /> : <ChevronDown className="w-4 h-4" />}
                  </button>
                </div>
              </div>

              {/* Detalhes do split */}
              {aberto && (
                <div className="border-t border-slate-700/50 bg-slate-900/40 p-4 space-y-3">
                  <p className="text-xs text-slate-500 uppercase tracking-wider font-medium mb-2">Estrutura dos treinos</p>
                  {modelo.split.map((dia, i) => (
                    <div key={i} className="flex gap-3">
                      <div className="w-20 shrink-0">
                        <p className="text-xs font-semibold text-slate-300">{dia.dia}</p>
                      </div>
                      <div className="flex-1">
                        <p className="text-xs font-semibold text-brand-400 mb-1">{dia.foco}</p>
                        <div className="flex flex-wrap gap-1">
                          {dia.exercicios.map((ex) => (
                            <span key={ex} className="text-xs bg-slate-800 text-slate-400 px-2 py-0.5 rounded-full">
                              {ex}
                            </span>
                          ))}
                        </div>
                      </div>
                    </div>
                  ))}
                  <p className="text-xs text-slate-600 pt-1 border-t border-slate-800">
                    Frequência: {modelo.frequencia}
                  </p>
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
