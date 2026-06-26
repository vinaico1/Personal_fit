"use client";

import { useState, useMemo } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { calcularMacrosPorQuantidade, formatarCaloria } from "@/lib/utils";
import type { Alimento } from "@/types";
import { toast } from "sonner";
import { Search, Plus, Loader2, X } from "lucide-react";

interface Props {
  refeicaoId: string;
  refeicaoNome: string;
  alimentos: Alimento[];
  metaRestante: { calorias: number; proteina: number; carbo: number; gordura: number };
}

export function AdicionarAlimentoForm({ refeicaoId, refeicaoNome, alimentos, metaRestante }: Props) {
  const router = useRouter();
  const [busca, setBusca] = useState("");
  const [selecionado, setSelecionado] = useState<Alimento | null>(null);
  const [quantidade, setQuantidade] = useState("100");
  const [loading, setLoading] = useState(false);

  const filtrados = useMemo(() => {
    if (!busca.trim()) return alimentos.slice(0, 15);
    const lower = busca.toLowerCase();
    return alimentos.filter(a => a.nome.toLowerCase().includes(lower)).slice(0, 20);
  }, [busca, alimentos]);

  const macrosPreview = useMemo(() => {
    if (!selecionado || !quantidade) return null;
    return calcularMacrosPorQuantidade(
      selecionado.calorias_100g, selecionado.proteina_100g,
      selecionado.carboidrato_100g, selecionado.gordura_100g,
      Number(quantidade)
    );
  }, [selecionado, quantidade]);

  async function handleAdicionar() {
    if (!selecionado || !macrosPreview) return;
    setLoading(true);
    const supabase = createClient();

    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const { error } = await supabase.from("logs_alimentacao").insert({
      user_id: user.id,
      refeicao_nome: refeicaoNome,
      alimento_id: selecionado.id,
      alimento_nome: selecionado.nome,
      quantidade_g: Number(quantidade),
      calorias: macrosPreview.calorias,
      proteina_g: macrosPreview.proteina_g,
      carboidrato_g: macrosPreview.carboidrato_g,
      gordura_g: macrosPreview.gordura_g,
    });

    if (error) {
      toast.error("Erro ao registrar alimento.");
    } else {
      toast.success(`${selecionado.nome} adicionado!`);
      setSelecionado(null);
      setBusca("");
      setQuantidade("100");
      router.refresh();
    }
    setLoading(false);
  }

  return (
    <div>
      <h2 className="font-semibold mb-3 text-sm text-slate-400 uppercase tracking-wider">Adicionar alimento</h2>

      {/* Macros disponíveis */}
      {metaRestante.calorias > 0 && (
        <div className="glass-card rounded-xl p-3 mb-4">
          <p className="text-xs text-slate-400 mb-1">Disponível nesta refeição:</p>
          <div className="flex gap-3 text-xs">
            <span className="text-orange-400 font-bold">{Math.round(metaRestante.calorias)} kcal</span>
            <span className="text-blue-400">P: {Math.round(metaRestante.proteina)}g</span>
            <span className="text-yellow-400">C: {Math.round(metaRestante.carbo)}g</span>
            <span className="text-red-400">G: {Math.round(metaRestante.gordura)}g</span>
          </div>
        </div>
      )}

      {!selecionado ? (
        <div>
          <div className="relative mb-3">
            <Search className="absolute left-3 top-3.5 w-4 h-4 text-slate-500" />
            <input
              value={busca}
              onChange={(e) => setBusca(e.target.value)}
              placeholder="Buscar alimento..."
              className="w-full bg-slate-800 border border-slate-700 rounded-xl pl-9 pr-4 py-3 text-slate-100 placeholder-slate-500 focus:outline-none focus:border-brand-500 transition-colors"
            />
          </div>
          <div className="space-y-1.5 max-h-80 overflow-y-auto">
            {filtrados.map((a) => (
              <button key={a.id} onClick={() => { setSelecionado(a); setBusca(""); }}
                className="w-full text-left p-3 rounded-xl bg-slate-800/60 hover:bg-slate-800 border border-slate-700/50 hover:border-slate-600 transition-all">
                <div className="flex justify-between items-start">
                  <div>
                    <p className="font-medium text-sm">{a.nome}</p>
                    <p className="text-slate-500 text-xs">{a.categoria}</p>
                  </div>
                  <div className="text-right text-xs text-slate-400">
                    <p className="font-bold text-slate-300">{Math.round(a.calorias_100g)} kcal</p>
                    <p>P:{a.proteina_100g}g / 100g</p>
                  </div>
                </div>
              </button>
            ))}
          </div>
        </div>
      ) : (
        <div className="glass-card rounded-2xl p-5">
          <div className="flex items-start justify-between mb-4">
            <div>
              <p className="font-bold">{selecionado.nome}</p>
              <p className="text-slate-400 text-sm">{selecionado.categoria}</p>
            </div>
            <button onClick={() => setSelecionado(null)} className="text-slate-500 hover:text-white">
              <X className="w-5 h-5" />
            </button>
          </div>

          <div className="mb-4">
            <label className="text-sm text-slate-400 block mb-1.5">Quantidade (gramas)</label>
            <div className="flex gap-2">
              <input
                type="number"
                value={quantidade}
                onChange={(e) => setQuantidade(e.target.value)}
                min={1} max={2000}
                className="flex-1 bg-slate-800 border border-slate-700 rounded-xl px-4 py-3 text-slate-100 focus:outline-none focus:border-brand-500 transition-colors"
              />
              <div className="flex gap-1">
                {[selecionado.porcao_padrao_g, 100, 200].map(q => (
                  <button key={q} onClick={() => setQuantidade(String(q))}
                    className={`px-3 py-2 rounded-xl text-sm font-medium transition-colors ${
                      quantidade === String(q) ? "brand-gradient text-white" : "bg-slate-800 text-slate-400 hover:text-white"
                    }`}>
                    {q}g
                  </button>
                ))}
              </div>
            </div>
          </div>

          {macrosPreview && (
            <div className="grid grid-cols-4 gap-2 mb-4 text-center">
              {[
                { label: "Kcal", val: Math.round(macrosPreview.calorias), cor: "text-orange-400" },
                { label: "Prot", val: `${Math.round(macrosPreview.proteina_g)}g`, cor: "text-blue-400" },
                { label: "Carbo", val: `${Math.round(macrosPreview.carboidrato_g)}g`, cor: "text-yellow-400" },
                { label: "Gord", val: `${Math.round(macrosPreview.gordura_g)}g`, cor: "text-red-400" },
              ].map((m) => (
                <div key={m.label} className="bg-slate-800/60 rounded-xl p-2">
                  <p className={`font-bold text-sm ${m.cor}`}>{m.val}</p>
                  <p className="text-slate-500 text-xs">{m.label}</p>
                </div>
              ))}
            </div>
          )}

          <button onClick={handleAdicionar} disabled={loading || !macrosPreview}
            className="w-full brand-gradient text-white font-bold py-3 rounded-xl hover:opacity-90 transition-opacity disabled:opacity-50 flex items-center justify-center gap-2">
            {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : <><Plus className="w-5 h-5" /> Adicionar à refeição</>}
          </button>
        </div>
      )}
    </div>
  );
}
