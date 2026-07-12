import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import { labelObjetivo, labelAtividade, formatarData } from "@/lib/utils";
import { calcularIMC } from "@/lib/calculations";
import { LogoutBtn } from "@/components/perfil/logout-btn";
import { AdicionarMedidaForm } from "@/components/perfil/adicionar-medida-form";
import { User, Scale, Activity, Target, TrendingUp } from "lucide-react";

export default async function PerfilPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const [{ data: profile }, { data: anamnese }, { data: medidas }] = await Promise.all([
    supabase.from("profiles").select("*").eq("id", user.id).single(),
    supabase.from("anamneses").select("*").eq("user_id", user.id).maybeSingle(),
    supabase.from("medidas_corporais").select("*").eq("user_id", user.id).order("data", { ascending: false }).limit(10),
  ]);

  const imc = anamnese ? calcularIMC(anamnese.peso_kg, anamnese.altura_cm) : null;
  const ultimaMedida = medidas?.[0];

  return (
    <div className="max-w-lg mx-auto px-4 pt-6 pb-4">
      <h1 className="text-2xl font-bold mb-6">Perfil</h1>

      {/* Avatar e nome */}
      <div className="glass-card rounded-2xl p-5 mb-4 flex items-center gap-4">
        <div className="w-16 h-16 brand-gradient rounded-2xl flex items-center justify-center">
          <User className="w-8 h-8 text-white" />
        </div>
        <div>
          <h2 className="font-bold text-xl">{profile?.nome}</h2>
          <p className="text-slate-400 text-sm">{user?.email}</p>
          {anamnese && (
            <p className="text-brand-400 text-sm font-medium mt-1">
              {labelObjetivo[anamnese.objetivo] ?? anamnese.objetivo}
            </p>
          )}
        </div>
      </div>

      {/* Dados da anamnese */}
      {anamnese && (
        <div className="glass-card rounded-2xl p-5 mb-4">
          <h3 className="font-bold mb-4 flex items-center gap-2">
            <Activity className="w-5 h-5 text-brand-400" />
            Dados Físicos
          </h3>
          <div className="grid grid-cols-2 gap-3">
            {[
              { label: "Peso atual", val: `${anamnese.peso_kg} kg` },
              { label: "Altura", val: `${anamnese.altura_cm} cm` },
              { label: "IMC", val: imc ? `${imc.imc}` : "—", extra: imc?.classificacao, extraCor: imc?.cor },
              { label: "Atividade", val: labelAtividade[anamnese.nivel_atividade] ?? anamnese.nivel_atividade },
            ].map((d) => (
              <div key={d.label} className="bg-slate-800/50 rounded-xl p-3">
                <p className="text-slate-500 text-xs">{d.label}</p>
                <p className="font-bold text-sm mt-0.5">{d.val}</p>
                {d.extra && <p className={`text-xs mt-0.5 ${d.extraCor ?? "text-slate-400"}`}>{d.extra}</p>}
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Metas */}
      {anamnese && (
        <div className="glass-card rounded-2xl p-5 mb-4">
          <h3 className="font-bold mb-4 flex items-center gap-2">
            <Target className="w-5 h-5 text-brand-400" />
            Metas Diárias
          </h3>
          <div className="space-y-2">
            {[
              { label: "Calorias", val: `${Math.round(anamnese.meta_calorias ?? 0)} kcal`, cor: "text-orange-400" },
              { label: "Proteína", val: `${Math.round(anamnese.meta_proteina_g ?? 0)}g`, cor: "text-blue-400" },
              { label: "Carboidratos", val: `${Math.round(anamnese.meta_carboidrato_g ?? 0)}g`, cor: "text-yellow-400" },
              { label: "Gorduras", val: `${Math.round(anamnese.meta_gordura_g ?? 0)}g`, cor: "text-red-400" },
            ].map((m) => (
              <div key={m.label} className="flex justify-between items-center">
                <span className="text-slate-400 text-sm">{m.label}</span>
                <span className={`font-bold text-sm ${m.cor}`}>{m.val}</span>
              </div>
            ))}
            <div className="border-t border-slate-700 pt-2 mt-2">
              <div className="flex justify-between text-xs text-slate-500">
                <span>TMB: {Math.round(anamnese.tmb ?? 0)} kcal</span>
                <span>GET: {Math.round(anamnese.get ?? 0)} kcal</span>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Registrar medidas */}
      <div className="glass-card rounded-2xl p-5 mb-4">
        <h3 className="font-bold mb-4 flex items-center gap-2">
          <Scale className="w-5 h-5 text-brand-400" />
          Registrar Medidas
        </h3>
        <AdicionarMedidaForm />
      </div>

      {/* Histórico de medidas */}
      {medidas && medidas.length > 0 && (
        <div className="glass-card rounded-2xl p-5 mb-4">
          <h3 className="font-bold mb-4 flex items-center gap-2">
            <TrendingUp className="w-5 h-5 text-brand-400" />
            Histórico de Peso
          </h3>
          <div className="space-y-2">
            {medidas.filter(m => m.peso_kg).slice(0, 5).map((m) => (
              <div key={m.id} className="flex justify-between items-center py-2 border-b border-slate-800 last:border-0">
                <span className="text-slate-400 text-sm">{formatarData(m.data)}</span>
                <span className="font-bold">{m.peso_kg} kg</span>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Logout */}
      <LogoutBtn />
    </div>
  );
}
