import type { Objetivo, NivelAtividade, Sexo } from "@/types";

// Fatores de atividade (multiplicadores do TDEE)
const FATORES_ATIVIDADE: Record<NivelAtividade, number> = {
  sedentario: 1.2,
  levemente_ativo: 1.375,
  moderadamente_ativo: 1.55,
  muito_ativo: 1.725,
  extremamente_ativo: 1.9,
};

// Proteína por kg de peso (g/kg)
const PROTEINA_POR_KG: Record<Objetivo, number> = {
  perder_gordura: 2.2,
  ganhar_peso: 2.0,
  manter_peso: 1.8,
};

// Ajuste calórico por objetivo (kcal)
const AJUSTE_CALORICO: Record<Objetivo, number> = {
  perder_gordura: -500,
  ganhar_peso: 350,
  manter_peso: 0,
};

export interface ResultadoCalculos {
  tmb: number;
  get: number;
  metaCalorias: number;
  metaProteina_g: number;
  metaCarboidrato_g: number;
  metaGordura_g: number;
}

/**
 * Calcula TMB pela equação de Mifflin-St Jeor
 * Homens: 10×peso + 6.25×altura - 5×idade + 5
 * Mulheres: 10×peso + 6.25×altura - 5×idade - 161
 */
export function calcularTMB(
  sexo: Sexo,
  pesoKg: number,
  alturaCm: number,
  idade: number
): number {
  const base = 10 * pesoKg + 6.25 * alturaCm - 5 * idade;
  return sexo === "masculino" ? base + 5 : base - 161;
}

/**
 * Calcula o Gasto Energético Total (GET / TDEE)
 */
export function calcularGET(tmb: number, nivelAtividade: NivelAtividade): number {
  return tmb * FATORES_ATIVIDADE[nivelAtividade];
}

/**
 * Calcula todos os macros baseado nos dados da anamnese
 */
export function calcularMacros(
  sexo: Sexo,
  pesoKg: number,
  alturaCm: number,
  idade: number,
  nivelAtividade: NivelAtividade,
  objetivo: Objetivo
): ResultadoCalculos {
  const tmb = calcularTMB(sexo, pesoKg, alturaCm, idade);
  const get = calcularGET(tmb, nivelAtividade);
  const metaCalorias = Math.max(1200, get + AJUSTE_CALORICO[objetivo]);

  const metaProteina_g = PROTEINA_POR_KG[objetivo] * pesoKg;
  const metaGordura_g = (metaCalorias * 0.25) / 9;
  const caloriasRestantes = metaCalorias - metaProteina_g * 4 - metaGordura_g * 9;
  const metaCarboidrato_g = Math.max(50, caloriasRestantes / 4);

  return {
    tmb: Math.round(tmb),
    get: Math.round(get),
    metaCalorias: Math.round(metaCalorias),
    metaProteina_g: Math.round(metaProteina_g),
    metaCarboidrato_g: Math.round(metaCarboidrato_g),
    metaGordura_g: Math.round(metaGordura_g),
  };
}

/**
 * Calcula IMC e classificação
 */
export function calcularIMC(pesoKg: number, alturaCm: number): {
  imc: number;
  classificacao: string;
  cor: string;
} {
  const alturaM = alturaCm / 100;
  const imc = pesoKg / (alturaM * alturaM);

  let classificacao: string;
  let cor: string;

  if (imc < 18.5) {
    classificacao = "Abaixo do peso";
    cor = "text-blue-400";
  } else if (imc < 25) {
    classificacao = "Peso normal";
    cor = "text-brand-400";
  } else if (imc < 30) {
    classificacao = "Sobrepeso";
    cor = "text-yellow-400";
  } else if (imc < 35) {
    classificacao = "Obesidade grau I";
    cor = "text-orange-400";
  } else if (imc < 40) {
    classificacao = "Obesidade grau II";
    cor = "text-red-400";
  } else {
    classificacao = "Obesidade grau III";
    cor = "text-red-600";
  }

  return { imc: parseFloat(imc.toFixed(1)), classificacao, cor };
}

// Divisão de refeições por calorias totais (percentuais sugeridos)
export const DISTRIBUICAO_REFEICOES = [
  { nome: "Café da manhã", horario: "07:00", percentual: 0.25 },
  { nome: "Lanche da manhã", horario: "10:00", percentual: 0.10 },
  { nome: "Almoço", horario: "12:30", percentual: 0.35 },
  { nome: "Lanche da tarde", horario: "16:00", percentual: 0.15 },
  { nome: "Jantar", horario: "19:30", percentual: 0.15 },
];

/**
 * Gera estrutura de refeições com metas baseadas nos macros totais
 */
export function gerarEstrutraRefeicoes(
  metaCalorias: number,
  metaProteina_g: number,
  metaCarboidrato_g: number,
  metaGordura_g: number
) {
  return DISTRIBUICAO_REFEICOES.map((r) => ({
    nome: r.nome,
    horario_sugerido: r.horario,
    meta_calorias: Math.round(metaCalorias * r.percentual),
    meta_proteina_g: Math.round(metaProteina_g * r.percentual),
    meta_carboidrato_g: Math.round(metaCarboidrato_g * r.percentual),
    meta_gordura_g: Math.round(metaGordura_g * r.percentual),
  }));
}

// ============================================================
// LÓGICA DE GERAÇÃO DE TREINO
// ============================================================

export type SplitTreino = {
  tipo: string;
  dias: Array<{
    nome: string;
    grupo_foco: string;
    gruposMusculares: string[];
  }>;
};

/**
 * Gera o split de treino ideal baseado na quantidade de dias
 */
export function gerarSplitTreino(diasSemana: number, objetivo: Objetivo): SplitTreino {
  if (diasSemana <= 2) {
    return {
      tipo: "Full Body",
      dias: Array.from({ length: diasSemana }, (_, i) => ({
        nome: `Treino ${String.fromCharCode(65 + i)}`,
        grupo_foco: "Corpo Completo",
        gruposMusculares: ["Peito", "Costas", "Ombros", "Bíceps", "Tríceps", "Pernas", "Core"],
      })),
    };
  }

  if (diasSemana === 3) {
    return {
      tipo: "Push / Pull / Legs",
      dias: [
        { nome: "Push (Empurrar)", grupo_foco: "Peito, Ombros, Tríceps", gruposMusculares: ["Peito", "Ombros", "Tríceps"] },
        { nome: "Pull (Puxar)", grupo_foco: "Costas, Bíceps", gruposMusculares: ["Costas", "Bíceps"] },
        { nome: "Legs (Pernas)", grupo_foco: "Pernas, Glúteos, Core", gruposMusculares: ["Pernas", "Glúteos", "Core"] },
      ],
    };
  }

  if (diasSemana === 4) {
    return {
      tipo: "Upper / Lower",
      dias: [
        { nome: "Upper A (Superior)", grupo_foco: "Peito, Costas, Ombros", gruposMusculares: ["Peito", "Costas", "Ombros"] },
        { nome: "Lower A (Inferior)", grupo_foco: "Pernas, Glúteos, Core", gruposMusculares: ["Pernas", "Glúteos", "Core"] },
        { nome: "Upper B (Superior)", grupo_foco: "Bíceps, Tríceps, Ombros", gruposMusculares: ["Bíceps", "Tríceps", "Ombros"] },
        { nome: "Lower B (Inferior)", grupo_foco: "Pernas, Glúteos, Core", gruposMusculares: ["Pernas", "Glúteos", "Core"] },
      ],
    };
  }

  if (diasSemana === 5) {
    return {
      tipo: "Push / Pull / Legs / Upper / Lower",
      dias: [
        { nome: "Push", grupo_foco: "Peito, Ombros, Tríceps", gruposMusculares: ["Peito", "Ombros", "Tríceps"] },
        { nome: "Pull", grupo_foco: "Costas, Bíceps", gruposMusculares: ["Costas", "Bíceps"] },
        { nome: "Legs", grupo_foco: "Pernas, Glúteos", gruposMusculares: ["Pernas", "Glúteos"] },
        { nome: "Upper", grupo_foco: "Peito, Costas, Ombros", gruposMusculares: ["Peito", "Costas", "Ombros"] },
        { nome: "Lower + Core", grupo_foco: "Pernas, Glúteos, Core", gruposMusculares: ["Pernas", "Glúteos", "Core"] },
      ],
    };
  }

  // 6 dias: PPL x2
  return {
    tipo: "Push / Pull / Legs (2x)",
    dias: [
      { nome: "Push A", grupo_foco: "Peito, Ombros, Tríceps", gruposMusculares: ["Peito", "Ombros", "Tríceps"] },
      { nome: "Pull A", grupo_foco: "Costas, Bíceps", gruposMusculares: ["Costas", "Bíceps"] },
      { nome: "Legs A", grupo_foco: "Pernas, Glúteos", gruposMusculares: ["Pernas", "Glúteos"] },
      { nome: "Push B", grupo_foco: "Peito, Ombros, Tríceps", gruposMusculares: ["Peito", "Ombros", "Tríceps"] },
      { nome: "Pull B", grupo_foco: "Costas, Bíceps", gruposMusculares: ["Costas", "Bíceps"] },
      { nome: "Legs B + Core", grupo_foco: "Pernas, Glúteos, Core", gruposMusculares: ["Pernas", "Glúteos", "Core"] },
    ],
  };
}

export function seriesPorObjetivo(objetivo: Objetivo): { series: number; repeticoes: string; descanso: number } {
  switch (objetivo) {
    case "ganhar_peso":
      return { series: 4, repeticoes: "6-10", descanso: 120 };
    case "perder_gordura":
      return { series: 3, repeticoes: "12-15", descanso: 60 };
    case "manter_peso":
      return { series: 3, repeticoes: "8-12", descanso: 90 };
  }
}
