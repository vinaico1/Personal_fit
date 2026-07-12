import { createClient } from "@/lib/supabase/server";
import Link from "next/link";
import { redirect } from "next/navigation";
import { formatarCaloria, formatarMacro, calcularPorcentagem, dataHoje } from "@/lib/utils";
import { Plus, Flame, ChevronRight, Info } from "lucide-react";
import { BuscarAlimentoModal } from "@/components/nutricao/buscar-alimento-modal";

export default async function NutricaoPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  const [{ data: anamnese }, { data: plano }] = await Promise.all([
    supabase.from("anamneses").select("*").eq("user_id", user!.id).maybeSingle(),
    supabase.from("planos_nutricionais").select("*, refeicoes(*, refeicao_alimentos(*, alimentos(*)))").eq("user_id", user!.id).eq("ativo", true).maybeSingle(),
  ]);

  if (!anamnese) redirect("/anamnese");

  const hoje = dataHoje();
  const { data: logsHoje } = await supabase
    .from("logs_alimentacao")
    .select("*")
    .eq("user_id", user!.id)
    .eq("data", hoje);

  const consumo = (logsHoje ?? []).reduce(
    (acc, l) => ({ calorias: acc.calorias + l.calorias, proteina: acc.proteina + l.proteina_g, carbo: acc.carbo + l.carboidrato_g, gordura: acc.gordura + l.gordura_g }),
    { calorias: 0, proteina: 0, carbo: 0, gordura: 0 }
  );

  const meta = {
    calorias: anamnese.meta_calorias ?? 2000,
    proteina: anamnese.meta_proteina_g ?? 150,
    carbo: anamnese.meta_carboidrato_g ?? 250,
    gordura: anamnese.meta_gordura_g ?? 55,
  };

  const refeicoes = plano?.refeicoes
    ? [...plano.refeicoes].sort((a, b) => a.ordem - b.ordem)
    : [];

  return (
    <div className="max-w-lg mx-auto px-4 pt-6 pb-4">
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold">Nutrição</h1>
        <Link href="/nutricao/buscar" className="flex items-center gap-1.5 bg-brand-500/20 text-brand-400 text-sm font-medium px-3 py-2 rounded-xl hover:bg-brand-500/30 transition-colors">
          <Plus className="w-4 h-4" /> Registrar
        </Link>
      </div>

      {/* Resumo do dia */}
      <div className="glass-card rounded-2xl p-5 mb-4">
        <div className="flex items-center gap-2 mb-4">
          <Flame className="w-5 h-5 text-orange-400" />
          <span className="font-semibold">Resumo de Hoje</span>
        </div>

        {/* Anel de calorias simplificado */}
        <div className="flex items-center gap-5 mb-5">
          <div className="relative w-24 h-24">
            <svg className="w-24 h-24 -rotate-90" viewBox="0 0 96 96">
              <circle cx="48" cy="48" r="40" fill="none" stroke="#1e293b" strokeWidth="8" />
              <circle
                cx="48" cy="48" r="40" fill="none"
                stroke="#10b981" strokeWidth="8"
                strokeLinecap="round"
                strokeDasharray={`${2 * Math.PI * 40}`}
                strokeDashoffset={`${2 * Math.PI * 40 * (1 - Math.min(1, consumo.calorias / meta.calorias))}`}
                className="transition-all duration-700"
              />
            </svg>
            <div className="absolute inset-0 flex flex-col items-center justify-center">
              <span className="font-bold text-lg leading-none">{formatarCaloria(consumo.calorias)}</span>
              <span className="text-slate-500 text-xs">kcal</span>
            </div>
          </div>
          <div className="flex-1 space-y-1.5">
            <div className="flex justify-between text-sm">
              <span className="text-slate-400">Consumido</span>
              <span className="font-medium">{formatarCaloria(consumo.calorias)} kcal</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-slate-400">Meta</span>
              <span className="font-medium">{formatarCaloria(meta.calorias)} kcal</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-slate-400">Restante</span>
              <span className={`font-bold ${meta.calorias - consumo.calorias < 0 ? "text-orange-400" : "text-brand-400"}`}>
                {formatarCaloria(Math.abs(meta.calorias - consumo.calorias))} kcal
                {meta.calorias - consumo.calorias < 0 ? " excedido" : ""}
              </span>
            </div>
          </div>
        </div>

        {/* Macros */}
        <div className="grid grid-cols-3 gap-3">
          {[
            { label: "Proteína", consumido: consumo.proteina, meta: meta.proteina, cor: "bg-blue-500", text: "text-blue-400" },
            { label: "Carbo", consumido: consumo.carbo, meta: meta.carbo, cor: "bg-yellow-500", text: "text-yellow-400" },
            { label: "Gordura", consumido: consumo.gordura, meta: meta.gordura, cor: "bg-red-500", text: "text-red-400" },
          ].map((m) => {
            const pct = calcularPorcentagem(m.consumido, m.meta);
            return (
              <div key={m.label} className="bg-slate-800/50 rounded-xl p-3">
                <div className="flex justify-between items-center mb-1.5">
                  <span className="text-xs text-slate-400">{m.label}</span>
                  <span className={`text-xs font-bold ${m.text}`}>{pct}%</span>
                </div>
                <div className="h-1.5 bg-slate-700 rounded-full mb-1">
                  <div className={`h-full ${m.cor} rounded-full transition-all`} style={{ width: `${Math.min(100, pct)}%` }} />
                </div>
                <p className="text-xs text-slate-300 font-medium">{formatarMacro(m.consumido)}g / {formatarMacro(m.meta)}g</p>
              </div>
            );
          })}
        </div>
      </div>

      {/* Refeições do plano */}
      <div className="mb-2">
        <h2 className="font-bold text-lg mb-3">Refeições do Plano</h2>
        {!plano && (
          <div className="glass-card rounded-2xl p-6 text-center">
            <p className="text-slate-400 mb-3">Nenhum plano nutricional encontrado.</p>
            <Link href="/anamnese" className="text-brand-400 font-medium text-sm">Criar plano →</Link>
          </div>
        )}
        <div className="space-y-3">
          {refeicoes.map((refeicao) => {
            const calRefeicao = refeicao.meta_calorias ?? 0;
            const logsDaRefeicao = (logsHoje ?? []).filter(l => l.refeicao_nome === refeicao.nome);
            const consumidoRefeicao = logsDaRefeicao.reduce((s, l) => s + l.calorias, 0);

            return (
              <Link key={refeicao.id} href={`/nutricao/refeicao/${refeicao.id}`}>
                <div className="glass-card rounded-2xl p-4 hover:border-slate-600 transition-colors">
                  <div className="flex items-center justify-between mb-3">
                    <div>
                      <p className="font-semibold">{refeicao.nome}</p>
                      <p className="text-slate-500 text-xs">{refeicao.horario_sugerido?.slice(0, 5) ?? ""} · Meta: {formatarCaloria(calRefeicao)} kcal</p>
                    </div>
                    <div className="flex items-center gap-2">
                      <span className="text-sm text-slate-400">{formatarCaloria(consumidoRefeicao)} kcal</span>
                      <ChevronRight className="w-4 h-4 text-slate-600" />
                    </div>
                  </div>
                  <div className="h-1.5 bg-slate-800 rounded-full">
                    <div
                      className={`h-full rounded-full transition-all ${consumidoRefeicao >= calRefeicao ? "bg-orange-500" : "brand-gradient"}`}
                      style={{ width: `${Math.min(100, calcularPorcentagem(consumidoRefeicao, calRefeicao))}%` }}
                    />
                  </div>
                </div>
              </Link>
            );
          })}
        </div>
      </div>

      {/* Info sobre macros */}
      <div className="glass-card rounded-2xl p-4 mt-4 flex gap-3">
        <Info className="w-5 h-5 text-brand-400 shrink-0 mt-0.5" />
        <div>
          <p className="text-sm font-medium mb-1">Como funciona?</p>
          <p className="text-slate-400 text-xs leading-relaxed">
            Clique em uma refeição para adicionar alimentos. O app mostra quanto de proteína, carboidrato e gordura você pode consumir em cada refeição dentro das suas metas.
          </p>
        </div>
      </div>
    </div>
  );
}
