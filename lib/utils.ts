import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export function formatarCaloria(valor: number): string {
  return Math.round(valor).toLocaleString("pt-BR");
}

export function formatarMacro(valor: number): string {
  return Math.round(valor).toString();
}

export function calcularPorcentagem(valor: number, total: number): number {
  if (total === 0) return 0;
  return Math.min(100, Math.round((valor / total) * 100));
}

export function calcularIdade(dataNascimento: string): number {
  const nascimento = new Date(dataNascimento);
  const hoje = new Date();
  let idade = hoje.getFullYear() - nascimento.getFullYear();
  const mesAtual = hoje.getMonth();
  const mesNasc = nascimento.getMonth();
  if (mesAtual < mesNasc || (mesAtual === mesNasc && hoje.getDate() < nascimento.getDate())) {
    idade--;
  }
  return idade;
}

export function nomeDiaSemana(dia: number): string {
  const dias = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];
  return dias[dia] ?? "";
}

export function nomeDiaSemanaCompleto(dia: number): string {
  const dias = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"];
  return dias[dia] ?? "";
}

export function dataHoje(): string {
  return new Date().toISOString().split("T")[0]!;
}

export function formatarData(data: string): string {
  return new Date(data + "T00:00:00").toLocaleDateString("pt-BR");
}

export function calcularMacrosPorQuantidade(
  calorias100g: number,
  proteina100g: number,
  carboidrato100g: number,
  gordura100g: number,
  quantidadeG: number
) {
  const fator = quantidadeG / 100;
  return {
    calorias: calorias100g * fator,
    proteina_g: proteina100g * fator,
    carboidrato_g: carboidrato100g * fator,
    gordura_g: gordura100g * fator,
  };
}

export const corObjetivo: Record<string, string> = {
  perder_gordura: "text-orange-400",
  ganhar_peso: "text-brand-400",
  manter_peso: "text-blue-400",
};

export const labelObjetivo: Record<string, string> = {
  perder_gordura: "Perder Gordura",
  ganhar_peso: "Ganhar Massa",
  manter_peso: "Manter Peso",
};

export const labelAtividade: Record<string, string> = {
  sedentario: "Sedentário",
  levemente_ativo: "Levemente Ativo",
  moderadamente_ativo: "Moderadamente Ativo",
  muito_ativo: "Muito Ativo",
  extremamente_ativo: "Extremamente Ativo",
};
