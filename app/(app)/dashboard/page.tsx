import { createClient } from "@/lib/supabase/server";
import Link from "next/link";
import { redirect } from "next/navigation";
import { Activity, ChevronRight, Dumbbell, Salad, TrendingUp, Flame, Droplets } from "lucide-react";
import { formatarCaloria, calcularPorcentagem, dataHoje, labelObjetivo } from "@/lib/utils";

export default async function DashboardPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data: profile }, { data: anamnese }] = await Promise.all([
    supabase.from("profiles").select("*").eq("id", user.id).single(),
    supabase.from("anamneses").select("*").eq("user_id", user.id).maybeSingle(),
  ]);

  const hoje = dataHoje();

  // Consumo de hoje
  const { data: logsHoje } = await supabase
    .from("logs_alimentacao")
    .select("calorias, proteina_g, carboidrato_g, gordura_g")
    .eq("user_id", user!.id)
    .eq("data", hoje);

  const consumoHoje = (logsHoje ?? []).reduce(
    (acc, l) => ({
      calorias: acc.calorias + l.calorias,
      proteina_g: acc.proteina_g + l.proteina_g,
      carboidrato_g: acc.carboidrato_g + l.carboidrato_g,
      gordura_g: acc.gordura_g + l.gordura_g,
    }),
    { calorias: 0, proteina_g: 0, carboidrato_g: 0, gordura_g: 0 }
  );

  // Log de treino hoje
  const { data: treinoHoje } = await supabase
    .from("logs_treino")
    .select("*")
    .eq("user_id", user!.id)
    .eq("data", hoje)
    .maybeSingle();

  const nome = profile?.nome?.split(" ")[0] ?? "Atleta";
  const hora = new Date().getHours();
  const saudacao = hora < 12 ? "Bom dia" : hora < 18 ? "Boa tarde" : "Boa noite";

  const metaCal = anamnese?.meta_calorias ?? 2000;
  const pctCal = calcularPorcentagem(consumoHoje.calorias, metaCal);

  return (
    <div className="max-w-lg mx-auto px-4 pt-6 pb-4">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <p className="text-slate-400 text-sm">{saudacao},</p>
          <h1 className="text-2xl font-bold">{nome} 👋</h1>
        </div>
        <div className="w-10 h-10 brand-gradient rounded-full flex items-center justify-center">
          <Activity className="w-5 h-5 text-white" />
        </div>
      </div>

      {/* Sem anamnese */}
      {!anamnese && (
        <Link href="/anamnese" className="block mb-6">
          <div className="brand-gradient rounded-2xl p-5 shadow-lg shadow-brand-500/20">
            <div className="flex items-center justify-between">
              <div>
                <p className="font-bold text-white text-lg">Complete sua avaliação</p>
                <p className="text-brand-100 text-sm mt-1">
                  Preencha a anamnese para receber seu plano personalizado
                </p>
              </div>
              <ChevronRight className="w-6 h-6 text-white" />
            </div>
          </div>
        </Link>
      )}

      {/* Objetivo */}
      {anamnese && (
        <div className="glass-card rounded-2xl p-4 mb-4 flex items-center justify-between">
          <div>
            <p className="text-slate-400 text-xs uppercase tracking-wider">Objetivo</p>
            <p className="font-bold text-brand-400 mt-0.5">
              {labelObjetivo[anamnese.objetivo] ?? anamnese.objetivo}
            </p>
          </div>
          <div className="text-right">
            <p className="text-slate-400 text-xs uppercase tracking-wider">Meta diária</p>
            <p className="font-bold text-lg">{formatarCaloria(metaCal)} kcal</p>
          </div>
        </div>
      )}

      {/* Card de calorias do dia */}
      {anamnese && (
        <div className="glass-card rounded-2xl p-5 mb-4">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center gap-2">
              <Flame className="w-5 h-5 text-orange-400" />
              <span className="font-semibold">Calorias de Hoje</span>
            </div>
            <Link href="/nutricao" className="text-brand-400 text-sm font-medium">
              Registrar →
            </Link>
          </div>
          <div className="mb-3">
            <div className="flex justify-between text-sm mb-1.5">
              <span className="text-slate-300 font-medium">
                {formatarCaloria(consumoHoje.calorias)} kcal
              </span>
              <span className="text-slate-500">{formatarCaloria(metaCal)} kcal</span>
            </div>
            <div className="h-3 bg-slate-800 rounded-full overflow-hidden">
              <div
                className={`h-full rounded-full transition-all duration-500 ${
                  pctCal >= 100 ? "bg-orange-500" : "brand-gradient"
                }`}
                style={{ width: `${Math.min(100, pctCal)}%` }}
              />
            </div>
            <p className="text-slate-500 text-xs mt-1 text-right">{pctCal}% da meta</p>
          </div>
          {/* Macros rápidos */}
          <div className="grid grid-cols-3 gap-3">
            {[
              { label: "Proteína", valor: consumoHoje.proteina_g, meta: anamnese.meta_proteina_g ?? 0, cor: "text-blue-400" },
              { label: "Carbo", valor: consumoHoje.carboidrato_g, meta: anamnese.meta_carboidrato_g ?? 0, cor: "text-yellow-400" },
              { label: "Gordura", valor: consumoHoje.gordura_g, meta: anamnese.meta_gordura_g ?? 0, cor: "text-red-400" },
            ].map((m) => (
              <div key={m.label} className="bg-slate-800/50 rounded-xl p-3 text-center">
                <p className={`font-bold text-sm ${m.cor}`}>{Math.round(m.valor)}g</p>
                <p className="text-slate-500 text-xs">/ {Math.round(m.meta)}g</p>
                <p className="text-slate-400 text-xs mt-0.5">{m.label}</p>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Card treino */}
      <Link href="/treino">
        <div className="glass-card rounded-2xl p-5 mb-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-purple-500/20 rounded-xl flex items-center justify-center">
              <Dumbbell className="w-5 h-5 text-purple-400" />
            </div>
            <div>
              <p className="font-semibold">Treino de Hoje</p>
              <p className="text-slate-400 text-sm">
                {treinoHoje?.concluido ? "✅ Treino concluído!" : "Ver plano de treino"}
              </p>
            </div>
          </div>
          <ChevronRight className="w-5 h-5 text-slate-500" />
        </div>
      </Link>

      {/* Acesso rápido */}
      <div className="grid grid-cols-2 gap-3">
        <Link href="/nutricao">
          <div className="glass-card rounded-2xl p-4 flex items-center gap-3">
            <Salad className="w-5 h-5 text-brand-400" />
            <div>
              <p className="font-medium text-sm">Nutrição</p>
              <p className="text-slate-500 text-xs">Ver plano</p>
            </div>
          </div>
        </Link>
        <Link href="/perfil">
          <div className="glass-card rounded-2xl p-4 flex items-center gap-3">
            <TrendingUp className="w-5 h-5 text-blue-400" />
            <div>
              <p className="font-medium text-sm">Evolução</p>
              <p className="text-slate-500 text-xs">Ver progresso</p>
            </div>
          </div>
        </Link>
      </div>

      {/* Hidratação rápida */}
      <div className="glass-card rounded-2xl p-4 mt-3">
        <div className="flex items-center gap-2 mb-2">
          <Droplets className="w-4 h-4 text-blue-400" />
          <span className="text-sm font-medium">Lembre-se de hidratar!</span>
        </div>
        <p className="text-slate-400 text-xs">
          Beba pelo menos {anamnese ? Math.round((anamnese.peso_kg ?? 70) * 35) : 2000}ml de água hoje.
        </p>
      </div>
    </div>
  );
}
