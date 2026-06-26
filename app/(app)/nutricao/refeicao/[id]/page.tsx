import { createClient } from "@/lib/supabase/server";
import { notFound, redirect } from "next/navigation";
import { formatarCaloria, formatarMacro, calcularPorcentagem, dataHoje } from "@/lib/utils";
import { AdicionarAlimentoForm } from "@/components/nutricao/adicionar-alimento-form";
import { ArrowLeft, Flame } from "lucide-react";
import Link from "next/link";

export default async function RefeicaoPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  const { data: refeicao } = await supabase
    .from("refeicoes")
    .select("*")
    .eq("id", id)
    .eq("user_id", user!.id)
    .maybeSingle();

  if (!refeicao) notFound();

  const hoje = dataHoje();
  const [{ data: logsHoje }, { data: alimentos }] = await Promise.all([
    supabase.from("logs_alimentacao").select("*").eq("user_id", user!.id).eq("data", hoje).eq("refeicao_nome", refeicao.nome),
    supabase.from("alimentos").select("*").order("nome").limit(100),
  ]);

  const consumo = (logsHoje ?? []).reduce(
    (acc, l) => ({ cal: acc.cal + l.calorias, prot: acc.prot + l.proteina_g, carbo: acc.carbo + l.carboidrato_g, gord: acc.gord + l.gordura_g }),
    { cal: 0, prot: 0, carbo: 0, gord: 0 }
  );

  const meta = {
    cal: refeicao.meta_calorias ?? 0,
    prot: refeicao.meta_proteina_g ?? 0,
    carbo: refeicao.meta_carboidrato_g ?? 0,
    gord: refeicao.meta_gordura_g ?? 0,
  };

  return (
    <div className="max-w-lg mx-auto px-4 pt-4 pb-4">
      <div className="flex items-center gap-3 mb-5">
        <Link href="/nutricao" className="text-slate-400 hover:text-white">
          <ArrowLeft className="w-5 h-5" />
        </Link>
        <div>
          <h1 className="text-xl font-bold">{refeicao.nome}</h1>
          <p className="text-slate-500 text-sm">{refeicao.horario_sugerido?.slice(0, 5)}</p>
        </div>
      </div>

      {/* Resumo da refeição */}
      <div className="glass-card rounded-2xl p-4 mb-5">
        <div className="flex items-center gap-2 mb-3">
          <Flame className="w-4 h-4 text-orange-400" />
          <span className="font-semibold text-sm">Consumido nesta refeição hoje</span>
        </div>
        <div className="grid grid-cols-4 gap-2 text-center">
          {[
            { label: "Cal", val: consumo.cal, meta: meta.cal, unit: "kcal", cor: "text-orange-400" },
            { label: "Prot", val: consumo.prot, meta: meta.prot, unit: "g", cor: "text-blue-400" },
            { label: "Carbo", val: consumo.carbo, meta: meta.carbo, unit: "g", cor: "text-yellow-400" },
            { label: "Gord", val: consumo.gord, meta: meta.gord, unit: "g", cor: "text-red-400" },
          ].map((m) => (
            <div key={m.label} className="bg-slate-800/60 rounded-xl p-2">
              <p className={`font-bold text-sm ${m.cor}`}>{m.label === "Cal" ? Math.round(m.val) : formatarMacro(m.val)}{m.unit}</p>
              <div className="h-1 bg-slate-700 rounded-full mt-1 mb-1">
                <div className={`h-full rounded-full`}
                  style={{
                    width: `${m.meta > 0 ? Math.min(100, calcularPorcentagem(m.val, m.meta)) : 0}%`,
                    background: m.label === "Cal" ? "#f97316" : m.label === "Prot" ? "#60a5fa" : m.label === "Carbo" ? "#facc15" : "#f87171"
                  }} />
              </div>
              <p className="text-slate-500 text-xs">/{m.meta > 0 ? (m.label === "Cal" ? Math.round(m.meta) : Math.round(m.meta)) : "—"}</p>
            </div>
          ))}
        </div>
      </div>

      {/* Alimentos já adicionados hoje */}
      {(logsHoje ?? []).length > 0 && (
        <div className="mb-5">
          <h2 className="font-semibold mb-3 text-sm text-slate-400 uppercase tracking-wider">Registrado hoje</h2>
          <div className="space-y-2">
            {(logsHoje ?? []).map((log) => (
              <div key={log.id} className="glass-card rounded-xl p-3 flex items-center justify-between">
                <div>
                  <p className="font-medium text-sm">{log.alimento_nome}</p>
                  <p className="text-slate-500 text-xs">{log.quantidade_g}g</p>
                </div>
                <div className="text-right">
                  <p className="font-bold text-sm text-orange-400">{Math.round(log.calorias)} kcal</p>
                  <p className="text-xs text-slate-500">P:{Math.round(log.proteina_g)}g C:{Math.round(log.carboidrato_g)}g</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Adicionar alimento */}
      <AdicionarAlimentoForm
        refeicaoId={refeicao.id}
        refeicaoNome={refeicao.nome}
        alimentos={alimentos ?? []}
        metaRestante={{
          calorias: Math.max(0, meta.cal - consumo.cal),
          proteina: Math.max(0, meta.prot - consumo.prot),
          carbo: Math.max(0, meta.carbo - consumo.carbo),
          gordura: Math.max(0, meta.gord - consumo.gord),
        }}
      />
    </div>
  );
}
