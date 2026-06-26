"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { toast } from "sonner";
import { CheckCircle2, Loader2 } from "lucide-react";

export function MarcarTreinoBtn({ diaId }: { diaId: string }) {
  const router = useRouter();
  const [loading, setLoading] = useState(false);

  async function marcarConcluido() {
    setLoading(true);
    const supabase = createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const hoje = new Date().toISOString().split("T")[0];

    const { error } = await supabase.from("logs_treino").upsert({
      user_id: user.id,
      dia_id: diaId,
      data: hoje,
      concluido: true,
    }, { onConflict: "user_id,dia_id,data" });

    if (error) {
      toast.error("Erro ao registrar treino.");
    } else {
      toast.success("Treino concluído! Ótimo trabalho! 💪");
      router.refresh();
    }
    setLoading(false);
  }

  return (
    <button
      onClick={marcarConcluido}
      disabled={loading}
      className="w-full mt-4 brand-gradient text-white font-bold py-3.5 rounded-xl hover:opacity-90 transition-opacity disabled:opacity-50 flex items-center justify-center gap-2 shadow-lg shadow-brand-500/20"
    >
      {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : <><CheckCircle2 className="w-5 h-5" /> Marcar treino como concluído</>}
    </button>
  );
}
