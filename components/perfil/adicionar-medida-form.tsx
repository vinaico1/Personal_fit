"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { toast } from "sonner";
import { Loader2, Save } from "lucide-react";

export function AdicionarMedidaForm() {
  const router = useRouter();
  const [peso, setPeso] = useState("");
  const [loading, setLoading] = useState(false);

  async function handleSalvar(e: React.FormEvent) {
    e.preventDefault();
    if (!peso) return;
    setLoading(true);
    const supabase = createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const { error } = await supabase.from("medidas_corporais").insert({
      user_id: user.id,
      peso_kg: Number(peso),
      data: new Date().toISOString().split("T")[0],
    });

    if (error) {
      toast.error("Erro ao salvar medida.");
    } else {
      toast.success("Medida registrada!");
      setPeso("");
      router.refresh();
    }
    setLoading(false);
  }

  return (
    <form onSubmit={handleSalvar} className="flex gap-3">
      <div className="flex-1">
        <label className="text-xs text-slate-500 block mb-1">Peso atual (kg)</label>
        <input
          type="number"
          value={peso}
          onChange={(e) => setPeso(e.target.value)}
          placeholder="Ex: 75.5"
          min={30} max={300} step={0.1}
          className="w-full bg-slate-800 border border-slate-700 rounded-xl px-4 py-2.5 text-slate-100 placeholder-slate-500 focus:outline-none focus:border-brand-500 transition-colors"
        />
      </div>
      <button
        type="submit"
        disabled={loading || !peso}
        className="self-end brand-gradient text-white p-2.5 rounded-xl hover:opacity-90 transition-opacity disabled:opacity-50 flex items-center gap-1.5"
      >
        {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
      </button>
    </form>
  );
}
