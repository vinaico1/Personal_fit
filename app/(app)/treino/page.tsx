import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import { nomeDiaSemana, dataHoje } from "@/lib/utils";
import { ExercicioCard } from "@/components/treino/exercicio-card";
import { MarcarTreinoBtn } from "@/components/treino/marcar-treino-btn";
import { SelecionarModeloTreino } from "@/components/treino/selecionar-modelo";
import { Dumbbell, Calendar, ChevronRight, Trophy, RefreshCw } from "lucide-react";
import Link from "next/link";

export default async function TreinoPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  const { data: anamnese } = await supabase.from("anamneses").select("*").eq("user_id", user!.id).maybeSingle();
  if (!anamnese) redirect("/anamnese");

  const { data: plano } = await supabase
    .from("planos_treino")
    .select("*, dias_treino(*, dia_exercicios(*, exercicios(*)))")
    .eq("user_id", user!.id)
    .eq("ativo", true)
    .maybeSingle();

  const hoje = dataHoje();
  const diaSemanaHoje = new Date().getDay();

  const { data: logsSemanais } = await supabase
    .from("logs_treino")
    .select("data, concluido, dia_id")
    .eq("user_id", user!.id)
    .gte("data", getSegundaFeira())
    .lte("data", hoje);

  const treinosConcluidosSemana = (logsSemanais ?? []).filter(l => l.concluido).length;

  const { data: treinoHoje } = await supabase
    .from("logs_treino")
    .select("*")
    .eq("user_id", user!.id)
    .eq("data", hoje)
    .maybeSingle();

  const dias = plano?.dias_treino
    ? [...plano.dias_treino].sort((a, b) => a.ordem - b.ordem)
    : [];

  const diaHoje = dias.find(d => d.dia_semana === diaSemanaHoje) ?? dias[0];

  return (
    <div className="max-w-lg mx-auto px-4 pt-6 pb-4">
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold">Treino</h1>
        {plano && (
          <div className="flex items-center gap-1 bg-purple-500/20 text-purple-400 text-xs font-medium px-3 py-1.5 rounded-full">
            <Trophy className="w-3.5 h-3.5" />
            {treinosConcluidosSemana}/{anamnese.dias_treino_semana} esta semana
          </div>
        )}
      </div>

      {!plano && (
        <SelecionarModeloTreino />
      )}

      {plano && (
        <>
          {/* Info do plano */}
          <div className="glass-card rounded-2xl p-4 mb-4">
            <div className="flex justify-between items-center mb-3">
              <div>
                <p className="text-slate-400 text-xs uppercase tracking-wider">Split</p>
                <p className="font-bold">{plano.tipo}</p>
              </div>
              <div className="text-right">
                <p className="text-slate-400 text-xs uppercase tracking-wider">Frequência</p>
                <p className="font-bold">{plano.dias_semana}x / semana</p>
              </div>
            </div>
            <Link
              href="/treino/modelos"
              className="flex items-center justify-center gap-1.5 w-full py-2 rounded-xl bg-slate-800 text-slate-400 hover:text-slate-200 hover:bg-slate-700 transition-colors text-xs font-medium"
            >
              <RefreshCw className="w-3.5 h-3.5" />
              Trocar programa
            </Link>
          </div>

          {/* Treino de hoje */}
          {diaHoje && (
            <div className="mb-6">
              <div className="flex items-center gap-2 mb-3">
                <Calendar className="w-5 h-5 text-brand-400" />
                <h2 className="font-bold text-lg">Treino de Hoje</h2>
                {treinoHoje?.concluido && (
                  <span className="ml-auto text-xs bg-brand-500/20 text-brand-400 px-2 py-0.5 rounded-full font-medium">✓ Concluído</span>
                )}
              </div>

              <div className="glass-card rounded-2xl p-4 mb-3">
                <div className="flex justify-between items-start mb-4">
                  <div>
                    <h3 className="font-bold text-lg">{diaHoje.nome}</h3>
                    <p className="text-brand-400 text-sm">{diaHoje.grupo_foco}</p>
                  </div>
                  <span className="text-slate-500 text-xs bg-slate-800 px-2 py-1 rounded-lg">
                    {diaHoje.dia_exercicios?.length ?? 0} exercícios
                  </span>
                </div>

                <div className="space-y-3">
                  {(diaHoje.dia_exercicios ?? [])
                    .sort((a: { ordem: number }, b: { ordem: number }) => a.ordem - b.ordem)
                    .map((de: { id: string; series: number; repeticoes: string; descanso_segundos: number; carga_sugerida_kg?: number; exercicios: Parameters<typeof ExercicioCard>[0]["exercicio"] }) => (
                    <ExercicioCard
                      key={de.id}
                      exercicio={de.exercicios}
                      series={de.series}
                      repeticoes={de.repeticoes}
                      descanso={de.descanso_segundos}
                      carga={de.carga_sugerida_kg}
                    />
                  ))}
                </div>

                {!treinoHoje?.concluido && (
                  <MarcarTreinoBtn diaId={diaHoje.id} />
                )}
              </div>
            </div>
          )}

          {/* Todos os dias do plano */}
          <div>
            <h2 className="font-bold text-lg mb-3">Todos os Treinos</h2>
            <div className="space-y-2">
              {dias.map((dia) => {
                const logDia = (logsSemanais ?? []).find(l => l.dia_id === dia.id);
                const concluido = logDia?.concluido;
                return (
                  <div key={dia.id} className={`glass-card rounded-xl p-4 flex items-center justify-between ${dia.id === diaHoje?.id ? "border-brand-500/40" : ""}`}>
                    <div className="flex items-center gap-3">
                      <div className={`w-8 h-8 rounded-lg flex items-center justify-center text-xs font-bold ${
                        concluido ? "bg-brand-500/20 text-brand-400" : "bg-slate-800 text-slate-400"
                      }`}>
                        {nomeDiaSemana(dia.dia_semana)}
                      </div>
                      <div>
                        <p className="font-medium text-sm">{dia.nome}</p>
                        <p className="text-slate-500 text-xs">{dia.grupo_foco}</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-2">
                      {concluido && <span className="text-brand-400 text-lg">✓</span>}
                      <ChevronRight className="w-4 h-4 text-slate-600" />
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        </>
      )}
    </div>
  );
}

function getSegundaFeira(): string {
  const hoje = new Date();
  const dia = hoje.getDay();
  const diff = dia === 0 ? -6 : 1 - dia;
  const segunda = new Date(hoje);
  segunda.setDate(hoje.getDate() + diff);
  return segunda.toISOString().split("T")[0]!;
}
