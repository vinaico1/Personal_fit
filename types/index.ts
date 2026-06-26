export type Objetivo = "perder_gordura" | "ganhar_peso" | "manter_peso";
export type NivelAtividade =
  | "sedentario"
  | "levemente_ativo"
  | "moderadamente_ativo"
  | "muito_ativo"
  | "extremamente_ativo";
export type Sexo = "masculino" | "feminino";
export type TipoExercicio = "composto" | "isolamento" | "cardio" | "funcional";
export type Dificuldade = "iniciante" | "intermediario" | "avancado";

export interface Profile {
  id: string;
  nome: string;
  email: string;
  avatar_url?: string;
  created_at: string;
}

export interface Anamnese {
  id: string;
  user_id: string;
  data_nascimento: string;
  sexo: Sexo;
  altura_cm: number;
  peso_kg: number;
  objetivo: Objetivo;
  nivel_atividade: NivelAtividade;
  dias_treino_semana: number;
  tmb?: number;
  get?: number;
  meta_calorias?: number;
  meta_proteina_g?: number;
  meta_carboidrato_g?: number;
  meta_gordura_g?: number;
  condicoes_medicas?: string[];
  observacoes?: string;
}

export interface Macros {
  calorias: number;
  proteina_g: number;
  carboidrato_g: number;
  gordura_g: number;
  fibra_g?: number;
}

export interface Alimento {
  id: string;
  nome: string;
  categoria: string;
  calorias_100g: number;
  proteina_100g: number;
  carboidrato_100g: number;
  gordura_100g: number;
  fibra_100g: number;
  unidade_padrao: string;
  porcao_padrao_g: number;
}

export interface AlimentoComQuantidade extends Alimento {
  quantidade_g: number;
  macros: Macros;
}

export interface Refeicao {
  id: string;
  plano_id: string;
  nome: string;
  horario_sugerido?: string;
  ordem: number;
  meta_calorias?: number;
  meta_proteina_g?: number;
  meta_carboidrato_g?: number;
  meta_gordura_g?: number;
  alimentos?: AlimentoComQuantidade[];
}

export interface PlanoNutricional {
  id: string;
  user_id: string;
  nome: string;
  ativo: boolean;
  meta_calorias: number;
  meta_proteina_g: number;
  meta_carboidrato_g: number;
  meta_gordura_g: number;
  refeicoes?: Refeicao[];
}

export interface Exercicio {
  id: string;
  nome: string;
  grupo_muscular: string;
  musculo_primario: string;
  musculos_secundarios?: string[];
  tipo: TipoExercicio;
  equipamento?: string;
  instrucoes: string;
  dicas?: string;
  video_url?: string;
  gif_url?: string;
  dificuldade: Dificuldade;
}

export interface ExercicioNoDia {
  id: string;
  exercicio: Exercicio;
  series: number;
  repeticoes: string;
  carga_sugerida_kg?: number;
  descanso_segundos: number;
  observacoes?: string;
  ordem: number;
}

export interface DiaTreino {
  id: string;
  plano_id: string;
  dia_semana: number;
  nome: string;
  grupo_foco: string;
  ordem: number;
  exercicios?: ExercicioNoDia[];
}

export interface PlanoTreino {
  id: string;
  user_id: string;
  nome: string;
  tipo: string;
  dias_semana: number;
  ativo: boolean;
  objetivo: string;
  dias?: DiaTreino[];
}

export interface MedidaCorporal {
  id: string;
  user_id: string;
  data: string;
  peso_kg?: number;
  percentual_gordura?: number;
  massa_muscular_kg?: number;
  circunferencia_cintura_cm?: number;
  circunferencia_quadril_cm?: number;
  circunferencia_braco_cm?: number;
  circunferencia_coxa_cm?: number;
}

export interface LogAlimentacao {
  id: string;
  user_id: string;
  data: string;
  refeicao_nome: string;
  alimento_nome: string;
  quantidade_g: number;
  calorias: number;
  proteina_g: number;
  carboidrato_g: number;
  gordura_g: number;
}

export interface ResumoNutricional {
  calorias_consumidas: number;
  proteina_consumida_g: number;
  carboidrato_consumido_g: number;
  gordura_consumida_g: number;
  meta_calorias: number;
  meta_proteina_g: number;
  meta_carboidrato_g: number;
  meta_gordura_g: number;
}
