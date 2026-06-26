-- ============================================================
-- FIT SAAS - Supabase Schema
-- Execute este SQL no SQL Editor do seu projeto Supabase
-- ============================================================

-- Habilitar extensões necessárias
create extension if not exists "uuid-ossp";

-- ============================================================
-- PERFIL DO USUÁRIO
-- ============================================================
create table public.profiles (
  id uuid references auth.users on delete cascade primary key,
  nome text not null,
  email text not null,
  avatar_url text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.profiles enable row level security;
create policy "Usuário vê e edita apenas seu perfil"
  on public.profiles for all using (auth.uid() = id);

-- ============================================================
-- ANAMNESE
-- ============================================================
create table public.anamneses (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null unique,
  -- Dados pessoais
  data_nascimento date not null,
  sexo text check (sexo in ('masculino', 'feminino')) not null,
  altura_cm integer not null,
  peso_kg decimal(5,2) not null,
  -- Objetivos e atividade
  objetivo text check (objetivo in ('perder_gordura', 'ganhar_peso', 'manter_peso')) not null,
  nivel_atividade text check (nivel_atividade in ('sedentario', 'levemente_ativo', 'moderadamente_ativo', 'muito_ativo', 'extremamente_ativo')) not null,
  dias_treino_semana integer check (dias_treino_semana between 1 and 7) not null,
  -- Dados calculados
  tmb decimal(8,2),
  get decimal(8,2),
  meta_calorias decimal(8,2),
  meta_proteina_g decimal(6,2),
  meta_carboidrato_g decimal(6,2),
  meta_gordura_g decimal(6,2),
  -- Saúde
  condicoes_medicas text[],
  observacoes text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.anamneses enable row level security;
create policy "Usuário gerencia sua anamnese"
  on public.anamneses for all using (auth.uid() = user_id);

-- ============================================================
-- PLANO NUTRICIONAL
-- ============================================================
create table public.planos_nutricionais (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  nome text not null default 'Meu Plano',
  ativo boolean default true,
  meta_calorias decimal(8,2) not null,
  meta_proteina_g decimal(6,2) not null,
  meta_carboidrato_g decimal(6,2) not null,
  meta_gordura_g decimal(6,2) not null,
  created_at timestamptz default now()
);

alter table public.planos_nutricionais enable row level security;
create policy "Usuário gerencia seus planos nutricionais"
  on public.planos_nutricionais for all using (auth.uid() = user_id);

-- ============================================================
-- REFEIÇÕES DO PLANO
-- ============================================================
create table public.refeicoes (
  id uuid default uuid_generate_v4() primary key,
  plano_id uuid references public.planos_nutricionais(id) on delete cascade not null,
  user_id uuid references public.profiles(id) on delete cascade not null,
  nome text not null,
  horario_sugerido time,
  ordem integer not null default 0,
  meta_calorias decimal(7,2),
  meta_proteina_g decimal(6,2),
  meta_carboidrato_g decimal(6,2),
  meta_gordura_g decimal(6,2),
  created_at timestamptz default now()
);

alter table public.refeicoes enable row level security;
create policy "Usuário gerencia suas refeições"
  on public.refeicoes for all using (auth.uid() = user_id);

-- ============================================================
-- BANCO DE ALIMENTOS (tabela TACO simplificada)
-- ============================================================
create table public.alimentos (
  id uuid default uuid_generate_v4() primary key,
  nome text not null,
  categoria text not null,
  calorias_100g decimal(7,2) not null,
  proteina_100g decimal(6,2) not null default 0,
  carboidrato_100g decimal(6,2) not null default 0,
  gordura_100g decimal(6,2) not null default 0,
  fibra_100g decimal(6,2) not null default 0,
  sodio_mg_100g decimal(7,2) default 0,
  unidade_padrao text default 'g',
  porcao_padrao_g decimal(7,2) default 100,
  created_at timestamptz default now()
);

-- Alimentos são públicos (leitura)
alter table public.alimentos enable row level security;
create policy "Alimentos são públicos para leitura"
  on public.alimentos for select using (true);

-- ============================================================
-- ALIMENTOS DA REFEIÇÃO
-- ============================================================
create table public.refeicao_alimentos (
  id uuid default uuid_generate_v4() primary key,
  refeicao_id uuid references public.refeicoes(id) on delete cascade not null,
  user_id uuid references public.profiles(id) on delete cascade not null,
  alimento_id uuid references public.alimentos(id) not null,
  quantidade_g decimal(7,2) not null default 100,
  -- Valores calculados no momento do registro
  calorias decimal(7,2) not null,
  proteina_g decimal(6,2) not null,
  carboidrato_g decimal(6,2) not null,
  gordura_g decimal(6,2) not null,
  created_at timestamptz default now()
);

alter table public.refeicao_alimentos enable row level security;
create policy "Usuário gerencia alimentos de suas refeições"
  on public.refeicao_alimentos for all using (auth.uid() = user_id);

-- ============================================================
-- LOG DIÁRIO DE ALIMENTAÇÃO
-- ============================================================
create table public.logs_alimentacao (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  data date not null default current_date,
  refeicao_nome text not null,
  alimento_id uuid references public.alimentos(id),
  alimento_nome text not null,
  quantidade_g decimal(7,2) not null,
  calorias decimal(7,2) not null,
  proteina_g decimal(6,2) not null,
  carboidrato_g decimal(6,2) not null,
  gordura_g decimal(6,2) not null,
  created_at timestamptz default now()
);

alter table public.logs_alimentacao enable row level security;
create policy "Usuário gerencia seu log de alimentação"
  on public.logs_alimentacao for all using (auth.uid() = user_id);

-- ============================================================
-- BANCO DE EXERCÍCIOS
-- ============================================================
create table public.exercicios (
  id uuid default uuid_generate_v4() primary key,
  nome text not null,
  grupo_muscular text not null,
  musculo_primario text not null,
  musculos_secundarios text[],
  tipo text check (tipo in ('composto', 'isolamento', 'cardio', 'funcional')) not null,
  equipamento text,
  instrucoes text not null,
  dicas text,
  video_url text,
  gif_url text,
  dificuldade text check (dificuldade in ('iniciante', 'intermediario', 'avancado')) default 'intermediario',
  created_at timestamptz default now()
);

alter table public.exercicios enable row level security;
create policy "Exercícios são públicos para leitura"
  on public.exercicios for select using (true);

-- ============================================================
-- PLANO DE TREINO
-- ============================================================
create table public.planos_treino (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  nome text not null default 'Meu Treino',
  tipo text not null,
  dias_semana integer not null,
  ativo boolean default true,
  objetivo text not null,
  created_at timestamptz default now()
);

alter table public.planos_treino enable row level security;
create policy "Usuário gerencia seus planos de treino"
  on public.planos_treino for all using (auth.uid() = user_id);

-- ============================================================
-- DIAS DO TREINO
-- ============================================================
create table public.dias_treino (
  id uuid default uuid_generate_v4() primary key,
  plano_id uuid references public.planos_treino(id) on delete cascade not null,
  user_id uuid references public.profiles(id) on delete cascade not null,
  dia_semana integer check (dia_semana between 0 and 6) not null,
  nome text not null,
  grupo_foco text not null,
  ordem integer not null default 0,
  created_at timestamptz default now()
);

alter table public.dias_treino enable row level security;
create policy "Usuário gerencia seus dias de treino"
  on public.dias_treino for all using (auth.uid() = user_id);

-- ============================================================
-- EXERCÍCIOS DO DIA
-- ============================================================
create table public.dia_exercicios (
  id uuid default uuid_generate_v4() primary key,
  dia_id uuid references public.dias_treino(id) on delete cascade not null,
  user_id uuid references public.profiles(id) on delete cascade not null,
  exercicio_id uuid references public.exercicios(id) not null,
  series integer not null default 3,
  repeticoes text not null default '8-12',
  carga_sugerida_kg decimal(6,2),
  descanso_segundos integer default 60,
  observacoes text,
  ordem integer not null default 0,
  created_at timestamptz default now()
);

alter table public.dia_exercicios enable row level security;
create policy "Usuário gerencia exercícios de seus treinos"
  on public.dia_exercicios for all using (auth.uid() = user_id);

-- ============================================================
-- LOG DE TREINO
-- ============================================================
create table public.logs_treino (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  dia_id uuid references public.dias_treino(id),
  data date not null default current_date,
  concluido boolean default false,
  duracao_minutos integer,
  observacoes text,
  created_at timestamptz default now()
);

alter table public.logs_treino enable row level security;
create policy "Usuário gerencia seus logs de treino"
  on public.logs_treino for all using (auth.uid() = user_id);

-- ============================================================
-- MEDIDAS CORPORAIS (acompanhamento de evolução)
-- ============================================================
create table public.medidas_corporais (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  data date not null default current_date,
  peso_kg decimal(5,2),
  percentual_gordura decimal(5,2),
  massa_muscular_kg decimal(5,2),
  circunferencia_cintura_cm decimal(5,2),
  circunferencia_quadril_cm decimal(5,2),
  circunferencia_braco_cm decimal(5,2),
  circunferencia_coxa_cm decimal(5,2),
  created_at timestamptz default now()
);

alter table public.medidas_corporais enable row level security;
create policy "Usuário gerencia suas medidas"
  on public.medidas_corporais for all using (auth.uid() = user_id);

-- ============================================================
-- TRIGGER: auto-criar perfil ao registrar usuário
-- ============================================================
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, nome, email)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'nome', split_part(new.email, '@', 1)),
    new.email
  );
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- ============================================================
-- TRIGGER: atualizar updated_at automaticamente
-- ============================================================
create or replace function public.handle_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger profiles_updated_at before update on public.profiles
  for each row execute procedure public.handle_updated_at();

create trigger anamneses_updated_at before update on public.anamneses
  for each row execute procedure public.handle_updated_at();

-- ============================================================
-- ÍNDICES para performance
-- ============================================================
create index idx_anamneses_user_id on public.anamneses(user_id);
create index idx_logs_alimentacao_user_data on public.logs_alimentacao(user_id, data);
create index idx_logs_treino_user_data on public.logs_treino(user_id, data);
create index idx_medidas_user_data on public.medidas_corporais(user_id, data);
create index idx_alimentos_nome on public.alimentos using gin(to_tsvector('portuguese', nome));
create index idx_exercicios_grupo on public.exercicios(grupo_muscular);
