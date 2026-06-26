"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { calcularMacros, gerarEstrutraRefeicoes, gerarSplitTreino, seriesPorObjetivo } from "@/lib/calculations";
import { calcularIdade } from "@/lib/utils";
import { toast } from "sonner";
import { ChevronLeft, ChevronRight, Loader2, CheckCircle2 } from "lucide-react";
import type { Objetivo, NivelAtividade, Sexo } from "@/types";

const STEPS = [
  "Dados Pessoais",
  "Medidas Corporais",
  "Objetivo",
  "Nível de Atividade",
  "Disponibilidade",
  "Confirmação",
];

const OBJETIVOS: { value: Objetivo; label: string; desc: string; emoji: string }[] = [
  { value: "perder_gordura", label: "Perder Gordura", desc: "Reduzir percentual de gordura mantendo massa muscular", emoji: "🔥" },
  { value: "ganhar_peso", label: "Ganhar Massa", desc: "Aumentar massa muscular com superávit calórico controlado", emoji: "💪" },
  { value: "manter_peso", label: "Manter Peso", desc: "Manter o peso atual com composição corporal equilibrada", emoji: "⚖️" },
];

const ATIVIDADES: { value: NivelAtividade; label: string; desc: string }[] = [
  { value: "sedentario", label: "Sedentário", desc: "Trabalho de escritório, pouca ou nenhuma atividade física" },
  { value: "levemente_ativo", label: "Levemente Ativo", desc: "Exercício leve 1-3x por semana" },
  { value: "moderadamente_ativo", label: "Moderadamente Ativo", desc: "Exercício moderado 3-5x por semana" },
  { value: "muito_ativo", label: "Muito Ativo", desc: "Exercício intenso 6-7x por semana" },
  { value: "extremamente_ativo", label: "Extremamente Ativo", desc: "Atleta, trabalho físico intenso diário" },
];

export default function AnamnesePage() {
  const router = useRouter();
  const [step, setStep] = useState(0);
  const [loading, setLoading] = useState(false);

  const [form, setForm] = useState({
    nome: "",
    data_nascimento: "",
    sexo: "" as Sexo | "",
    altura_cm: "",
    peso_kg: "",
    objetivo: "" as Objetivo | "",
    nivel_atividade: "" as NivelAtividade | "",
    dias_treino: "3",
  });

  function set(field: string, value: string) {
    setForm((prev) => ({ ...prev, [field]: value }));
  }

  function canNext(): boolean {
    switch (step) {
      case 0: return !!(form.nome && form.data_nascimento && form.sexo);
      case 1: return !!(form.altura_cm && form.peso_kg && Number(form.altura_cm) > 0 && Number(form.peso_kg) > 0);
      case 2: return !!form.objetivo;
      case 3: return !!form.nivel_atividade;
      case 4: return Number(form.dias_treino) >= 1;
      default: return true;
    }
  }

  async function handleSubmit() {
    setLoading(true);
    const supabase = createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) { router.push("/login"); return; }

    const idade = calcularIdade(form.data_nascimento);
    const macros = calcularMacros(
      form.sexo as Sexo,
      Number(form.peso_kg),
      Number(form.altura_cm),
      idade,
      form.nivel_atividade as NivelAtividade,
      form.objetivo as Objetivo
    );

    const { error: errAnamnese } = await supabase.from("anamneses").upsert({
      user_id: user.id,
      data_nascimento: form.data_nascimento,
      sexo: form.sexo,
      altura_cm: Number(form.altura_cm),
      peso_kg: Number(form.peso_kg),
      objetivo: form.objetivo,
      nivel_atividade: form.nivel_atividade,
      dias_treino_semana: Number(form.dias_treino),
      tmb: macros.tmb,
      get: macros.get,
      meta_calorias: macros.metaCalorias,
      meta_proteina_g: macros.metaProteina_g,
      meta_carboidrato_g: macros.metaCarboidrato_g,
      meta_gordura_g: macros.metaGordura_g,
    });

    if (errAnamnese) {
      toast.error("Erro ao salvar avaliação.");
      setLoading(false);
      return;
    }

    const { data: plano } = await supabase.from("planos_nutricionais").insert({
      user_id: user.id,
      nome: "Meu Plano Nutricional",
      meta_calorias: macros.metaCalorias,
      meta_proteina_g: macros.metaProteina_g,
      meta_carboidrato_g: macros.metaCarboidrato_g,
      meta_gordura_g: macros.metaGordura_g,
    }).select().single();

    if (plano) {
      const refeicoes = gerarEstrutraRefeicoes(
        macros.metaCalorias, macros.metaProteina_g, macros.metaCarboidrato_g, macros.metaGordura_g
      );
      await supabase.from("refeicoes").insert(
        refeicoes.map((r, i) => ({
          plano_id: plano.id,
          user_id: user.id,
          nome: r.nome,
          horario_sugerido: r.horario_sugerido,
          ordem: i,
          meta_calorias: r.meta_calorias,
          meta_proteina_g: r.meta_proteina_g,
          meta_carboidrato_g: r.meta_carboidrato_g,
          meta_gordura_g: r.meta_gordura_g,
        }))
      );
    }

    const split = gerarSplitTreino(Number(form.dias_treino), form.objetivo as Objetivo);
    const { data: planoTreino } = await supabase.from("planos_treino").insert({
      user_id: user.id,
      nome: `Treino ${split.tipo}`,
      tipo: split.tipo,
      dias_semana: Number(form.dias_treino),
      objetivo: form.objetivo,
    }).select().single();

    if (planoTreino) {
      const diasSemanaDisp = [1, 2, 3, 4, 5, 6, 0];
      const params = seriesPorObjetivo(form.objetivo as Objetivo);

      for (let i = 0; i < split.dias.length; i++) {
        const diaConfig = split.dias[i]!;
        const { data: diaTreino } = await supabase.from("dias_treino").insert({
          plano_id: planoTreino.id,
          user_id: user.id,
          dia_semana: diasSemanaDisp[i] ?? i,
          nome: diaConfig.nome,
          grupo_foco: diaConfig.grupo_foco,
          ordem: i,
        }).select().single();

        if (diaTreino) {
          const { data: exercicios } = await supabase
            .from("exercicios")
            .select("id, grupo_muscular")
            .in("grupo_muscular", diaConfig.gruposMusculares)
            .in("tipo", ["composto", "isolamento"])
            .limit(20);

          if (exercicios && exercicios.length > 0) {
            const selecionados = selecionarExercicios(exercicios, diaConfig.gruposMusculares, 5);
            await supabase.from("dia_exercicios").insert(
              selecionados.map((ex, idx) => ({
                dia_id: diaTreino.id,
                user_id: user.id,
                exercicio_id: ex.id,
                series: params.series,
                repeticoes: params.repeticoes,
                descanso_segundos: params.descanso,
                ordem: idx,
              }))
            );
          }
        }
      }
    }

    toast.success("Plano criado com sucesso!");
    router.push("/dashboard");
    router.refresh();
  }

  const macrosPreview = form.objetivo && form.nivel_atividade && form.sexo && form.peso_kg && form.altura_cm && form.data_nascimento
    ? calcularMacros(
        form.sexo as Sexo, Number(form.peso_kg), Number(form.altura_cm),
        calcularIdade(form.data_nascimento), form.nivel_atividade as NivelAtividade, form.objetivo as Objetivo
      )
    : null;

  return (
    <div className="min-h-screen bg-slate-950">
      {/* Barra de progresso */}
      <div className="fixed top-0 inset-x-0 z-10 bg-slate-950/95 backdrop-blur border-b border-slate-800">
        <div className="max-w-lg mx-auto px-4 py-3">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-slate-400">Passo {step + 1} de {STEPS.length}</span>
            <span className="text-sm font-medium">{STEPS[step]}</span>
          </div>
          <div className="h-1.5 bg-slate-800 rounded-full">
            <div
              className="h-full brand-gradient rounded-full transition-all duration-300"
              style={{ width: `${((step + 1) / STEPS.length) * 100}%` }}
            />
          </div>
        </div>
      </div>

      {/* Conteúdo com scroll — padding-bottom garante espaço acima do botão fixo */}
      <div className="max-w-lg mx-auto px-4 pt-20 pb-28">

        {/* Step 0 */}
        {step === 0 && (
          <div className="animate-fade-in-up space-y-6">
            <div>
              <h2 className="text-2xl font-bold mb-1">Vamos começar!</h2>
              <p className="text-slate-400">Precisamos de alguns dados básicos sobre você.</p>
            </div>
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-slate-300 mb-1.5">Como você se chama?</label>
                <input value={form.nome} onChange={(e) => set("nome", e.target.value)}
                  placeholder="Seu nome completo"
                  className="w-full bg-slate-800 border border-slate-700 rounded-xl px-4 py-3 text-slate-100 placeholder-slate-500 focus:outline-none focus:border-brand-500 transition-colors" />
              </div>
              <div>
                <label className="block text-sm font-medium text-slate-300 mb-1.5">Data de nascimento</label>
                <input type="date" value={form.data_nascimento} onChange={(e) => set("data_nascimento", e.target.value)}
                  max={new Date().toISOString().split("T")[0]}
                  className="w-full bg-slate-800 border border-slate-700 rounded-xl px-4 py-3 text-slate-100 focus:outline-none focus:border-brand-500 transition-colors" />
              </div>
              <div>
                <label className="block text-sm font-medium text-slate-300 mb-2">Sexo biológico</label>
                <div className="grid grid-cols-2 gap-3">
                  {(["masculino", "feminino"] as Sexo[]).map((s) => (
                    <button key={s} onClick={() => set("sexo", s)}
                      className={`py-3 rounded-xl border-2 font-medium transition-all ${
                        form.sexo === s ? "border-brand-500 bg-brand-500/10 text-brand-400" : "border-slate-700 text-slate-400 hover:border-slate-500"
                      }`}>
                      {s === "masculino" ? "♂ Masculino" : "♀ Feminino"}
                    </button>
                  ))}
                </div>
              </div>
            </div>
          </div>
        )}

        {/* Step 1 */}
        {step === 1 && (
          <div className="animate-fade-in-up space-y-6">
            <div>
              <h2 className="text-2xl font-bold mb-1">Suas medidas</h2>
              <p className="text-slate-400">Usadas para calcular seu metabolismo com precisão.</p>
            </div>
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-slate-300 mb-1.5">Altura (cm)</label>
                <input type="number" value={form.altura_cm} onChange={(e) => set("altura_cm", e.target.value)}
                  placeholder="Ex: 175" min={100} max={250}
                  className="w-full bg-slate-800 border border-slate-700 rounded-xl px-4 py-3 text-slate-100 placeholder-slate-500 focus:outline-none focus:border-brand-500 transition-colors" />
              </div>
              <div>
                <label className="block text-sm font-medium text-slate-300 mb-1.5">Peso atual (kg)</label>
                <input type="number" value={form.peso_kg} onChange={(e) => set("peso_kg", e.target.value)}
                  placeholder="Ex: 75.5" min={30} max={300} step={0.5}
                  className="w-full bg-slate-800 border border-slate-700 rounded-xl px-4 py-3 text-slate-100 placeholder-slate-500 focus:outline-none focus:border-brand-500 transition-colors" />
              </div>
              {form.altura_cm && form.peso_kg && (
                <div className="glass-card rounded-xl p-4">
                  {(() => {
                    const h = Number(form.altura_cm) / 100;
                    const imc = Number(form.peso_kg) / (h * h);
                    const cat = imc < 18.5 ? "Abaixo do peso" : imc < 25 ? "Peso normal ✓" : imc < 30 ? "Sobrepeso" : "Obesidade";
                    return (
                      <div className="flex justify-between items-center">
                        <span className="text-slate-400 text-sm">IMC calculado</span>
                        <div className="text-right">
                          <span className="font-bold text-lg">{imc.toFixed(1)}</span>
                          <p className="text-xs text-slate-400">{cat}</p>
                        </div>
                      </div>
                    );
                  })()}
                </div>
              )}
            </div>
          </div>
        )}

        {/* Step 2 */}
        {step === 2 && (
          <div className="animate-fade-in-up space-y-6">
            <div>
              <h2 className="text-2xl font-bold mb-1">Qual é o seu objetivo?</h2>
              <p className="text-slate-400">Isso define seu déficit ou superávit calórico.</p>
            </div>
            <div className="space-y-3">
              {OBJETIVOS.map((o) => (
                <button key={o.value} onClick={() => set("objetivo", o.value)}
                  className={`w-full p-4 rounded-2xl border-2 text-left transition-all ${
                    form.objetivo === o.value ? "border-brand-500 bg-brand-500/10" : "border-slate-700 hover:border-slate-600"
                  }`}>
                  <div className="flex items-center gap-3">
                    <span className="text-2xl">{o.emoji}</span>
                    <div>
                      <p className="font-bold">{o.label}</p>
                      <p className="text-slate-400 text-sm">{o.desc}</p>
                    </div>
                    {form.objetivo === o.value && <CheckCircle2 className="w-5 h-5 text-brand-400 ml-auto" />}
                  </div>
                </button>
              ))}
            </div>
          </div>
        )}

        {/* Step 3 */}
        {step === 3 && (
          <div className="animate-fade-in-up space-y-6">
            <div>
              <h2 className="text-2xl font-bold mb-1">Nível de atividade</h2>
              <p className="text-slate-400">Considera seu trabalho e rotina fora da academia.</p>
            </div>
            <div className="space-y-3">
              {ATIVIDADES.map((a) => (
                <button key={a.value} onClick={() => set("nivel_atividade", a.value)}
                  className={`w-full p-4 rounded-2xl border-2 text-left transition-all ${
                    form.nivel_atividade === a.value ? "border-brand-500 bg-brand-500/10" : "border-slate-700 hover:border-slate-600"
                  }`}>
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="font-bold">{a.label}</p>
                      <p className="text-slate-400 text-sm">{a.desc}</p>
                    </div>
                    {form.nivel_atividade === a.value && <CheckCircle2 className="w-5 h-5 text-brand-400" />}
                  </div>
                </button>
              ))}
            </div>
          </div>
        )}

        {/* Step 4 */}
        {step === 4 && (
          <div className="animate-fade-in-up space-y-6">
            <div>
              <h2 className="text-2xl font-bold mb-1">Disponibilidade para treinar</h2>
              <p className="text-slate-400">Quantos dias por semana você pode ir à academia?</p>
            </div>
            <div className="glass-card rounded-2xl p-6">
              <div className="text-center mb-6">
                <span className="text-6xl font-extrabold brand-text-gradient">{form.dias_treino}</span>
                <p className="text-slate-400 mt-1">dias por semana</p>
              </div>
              <input type="range" min={1} max={6} value={form.dias_treino}
                onChange={(e) => set("dias_treino", e.target.value)}
                className="w-full h-2 accent-brand-500" />
              <div className="flex justify-between text-xs text-slate-500 mt-1">
                <span>1 dia</span><span>6 dias</span>
              </div>
            </div>
            <div className="glass-card rounded-xl p-4">
              <p className="text-sm text-slate-400 mb-1">Split sugerido para {form.dias_treino} dias:</p>
              <p className="font-semibold text-brand-400">
                {gerarSplitTreino(Number(form.dias_treino), form.objetivo as Objetivo || "manter_peso").tipo}
              </p>
            </div>
          </div>
        )}

        {/* Step 5 */}
        {step === 5 && macrosPreview && (
          <div className="animate-fade-in-up space-y-4">
            <div>
              <h2 className="text-2xl font-bold mb-1">Seu plano está pronto!</h2>
              <p className="text-slate-400">Revise os dados e confirme para criar seu plano.</p>
            </div>
            <div className="glass-card rounded-2xl p-5">
              <h3 className="font-bold mb-3 text-brand-400">Metabolismo calculado</h3>
              <div className="space-y-2 text-sm">
                <div className="flex justify-between"><span className="text-slate-400">TMB (Taxa Metabólica Basal)</span><span className="font-medium">{macrosPreview.tmb} kcal</span></div>
                <div className="flex justify-between"><span className="text-slate-400">GET (Gasto Energético Total)</span><span className="font-medium">{macrosPreview.get} kcal</span></div>
                <div className="flex justify-between border-t border-slate-700 pt-2 mt-2">
                  <span className="text-slate-300 font-medium">Meta calórica diária</span>
                  <span className="font-bold text-brand-400">{macrosPreview.metaCalorias} kcal</span>
                </div>
              </div>
            </div>
            <div className="glass-card rounded-2xl p-5">
              <h3 className="font-bold mb-3 text-brand-400">Distribuição de macros</h3>
              <div className="grid grid-cols-3 gap-3">
                {[
                  { label: "Proteína", valor: macrosPreview.metaProteina_g, cor: "text-blue-400", bg: "bg-blue-500/10" },
                  { label: "Carboidrato", valor: macrosPreview.metaCarboidrato_g, cor: "text-yellow-400", bg: "bg-yellow-500/10" },
                  { label: "Gordura", valor: macrosPreview.metaGordura_g, cor: "text-red-400", bg: "bg-red-500/10" },
                ].map((m) => (
                  <div key={m.label} className={`${m.bg} rounded-xl p-3 text-center`}>
                    <p className={`font-bold text-lg ${m.cor}`}>{m.valor}g</p>
                    <p className="text-slate-400 text-xs mt-0.5">{m.label}</p>
                  </div>
                ))}
              </div>
            </div>
            <div className="glass-card rounded-2xl p-5">
              <h3 className="font-bold mb-3 text-brand-400">Treino</h3>
              <div className="text-sm space-y-1">
                <div className="flex justify-between"><span className="text-slate-400">Dias por semana</span><span className="font-medium">{form.dias_treino}x</span></div>
                <div className="flex justify-between"><span className="text-slate-400">Split</span><span className="font-medium">{gerarSplitTreino(Number(form.dias_treino), form.objetivo as Objetivo).tipo}</span></div>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Navegação fixa — sem BottomNav nesta página */}
      <div className="fixed bottom-0 inset-x-0 bg-slate-950/95 backdrop-blur border-t border-slate-800 p-4"
        style={{ paddingBottom: "calc(env(safe-area-inset-bottom) + 1rem)" }}>
        <div className="max-w-lg mx-auto flex gap-3">
          {step > 0 && (
            <button onClick={() => setStep(step - 1)}
              className="flex items-center gap-2 px-4 py-3 rounded-xl border border-slate-700 text-slate-400 hover:border-slate-500 hover:text-white transition-colors">
              <ChevronLeft className="w-5 h-5" />
              Voltar
            </button>
          )}
          {step < STEPS.length - 1 ? (
            <button onClick={() => setStep(step + 1)} disabled={!canNext()}
              className="flex-1 brand-gradient text-white font-bold py-3 rounded-xl hover:opacity-90 transition-opacity disabled:opacity-40 flex items-center justify-center gap-2">
              Continuar <ChevronRight className="w-5 h-5" />
            </button>
          ) : (
            <button onClick={handleSubmit} disabled={loading}
              className="flex-1 brand-gradient text-white font-bold py-3 rounded-xl hover:opacity-90 transition-opacity disabled:opacity-50 flex items-center justify-center gap-2 shadow-lg shadow-brand-500/20">
              {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : <>Criar meu plano! <CheckCircle2 className="w-5 h-5" /></>}
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

function selecionarExercicios(exercicios: { id: string; grupo_muscular: string }[], grupos: string[], max: number) {
  const result: { id: string; grupo_muscular: string }[] = [];
  const visto = new Set<string>();
  for (const grupo of grupos) {
    const doGrupo = exercicios.filter(e => e.grupo_muscular === grupo && !visto.has(e.id));
    const selecionado = doGrupo[0];
    if (selecionado) { result.push(selecionado); visto.add(selecionado.id); }
  }
  for (const ex of exercicios) {
    if (result.length >= max) break;
    if (!visto.has(ex.id)) { result.push(ex); visto.add(ex.id); }
  }
  return result.slice(0, max);
}
