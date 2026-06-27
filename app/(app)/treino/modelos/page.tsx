import { ArrowLeft } from "lucide-react";
import Link from "next/link";
import { SelecionarModeloTreino } from "@/components/treino/selecionar-modelo";

export default function ModelosTreinoPage() {
  return (
    <div className="max-w-lg mx-auto px-4 pt-6 pb-8">
      <div className="flex items-center gap-3 mb-6">
        <Link
          href="/treino"
          className="w-9 h-9 rounded-xl bg-slate-800 flex items-center justify-center text-slate-400 hover:text-white hover:bg-slate-700 transition-colors"
        >
          <ArrowLeft className="w-4 h-4" />
        </Link>
        <div>
          <h1 className="text-xl font-bold">Programas de Treino</h1>
          <p className="text-slate-500 text-xs">Escolha um programa profissional</p>
        </div>
      </div>

      <SelecionarModeloTreino modoTrocar />
    </div>
  );
}
