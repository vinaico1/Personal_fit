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
-- ============================================================
-- SEED - Alimentos (baseado na tabela TACO)
-- ============================================================
insert into public.alimentos (nome, categoria, calorias_100g, proteina_100g, carboidrato_100g, gordura_100g, fibra_100g, porcao_padrao_g) values
-- PROTEÍNAS ANIMAIS
('Frango grelhado (peito)', 'Proteínas', 163, 31.5, 0, 3.6, 0, 100),
('Carne bovina (patinho)', 'Proteínas', 219, 21.6, 0, 14.5, 0, 100),
('Ovo cozido', 'Proteínas', 146, 13.3, 0.6, 9.5, 0, 50),
('Atum em conserva (água)', 'Proteínas', 127, 28.0, 0, 1.5, 0, 100),
('Salmão grelhado', 'Proteínas', 183, 25.4, 0, 8.8, 0, 100),
('Tilápia grelhada', 'Proteínas', 128, 26.2, 0, 2.7, 0, 100),
('Carne suína (lombo)', 'Proteínas', 214, 22.4, 0, 13.5, 0, 100),
('Peru (peito)', 'Proteínas', 135, 29.8, 0, 1.7, 0, 100),
('Whey protein', 'Proteínas', 370, 80.0, 6.0, 4.0, 0, 30),
('Queijo cottage', 'Proteínas', 98, 11.1, 3.4, 4.5, 0, 100),
('Ricota', 'Laticínios', 144, 11.1, 3.0, 9.7, 0, 100),
('Iogurte grego integral', 'Laticínios', 97, 9.0, 3.6, 5.0, 0, 100),
('Iogurte desnatado', 'Laticínios', 46, 4.0, 6.0, 0.1, 0, 200),
('Leite integral', 'Laticínios', 61, 3.2, 4.7, 3.2, 0, 240),
('Leite desnatado', 'Laticínios', 35, 3.5, 5.0, 0.1, 0, 240),
-- CARBOIDRATOS
('Arroz branco cozido', 'Carboidratos', 128, 2.5, 28.1, 0.2, 1.6, 100),
('Arroz integral cozido', 'Carboidratos', 124, 2.6, 25.8, 1.0, 2.7, 100),
('Macarrão cozido', 'Carboidratos', 137, 4.4, 27.9, 0.8, 1.6, 100),
('Batata doce cozida', 'Carboidratos', 77, 1.4, 18.4, 0.1, 2.2, 150),
('Batata inglesa cozida', 'Carboidratos', 52, 1.9, 11.4, 0.2, 1.8, 150),
('Aveia (flocos)', 'Carboidratos', 394, 13.9, 66.6, 8.5, 9.1, 40),
('Pão integral', 'Carboidratos', 253, 8.1, 45.7, 4.7, 6.9, 50),
('Pão francês', 'Carboidratos', 300, 8.0, 57.5, 3.1, 2.3, 50),
('Mandioca cozida', 'Carboidratos', 125, 0.9, 30.1, 0.3, 1.9, 100),
('Inhame cozido', 'Carboidratos', 116, 1.6, 27.8, 0.2, 3.9, 100),
('Feijão preto cozido', 'Leguminosas', 77, 4.5, 14.0, 0.5, 8.4, 100),
('Feijão carioca cozido', 'Leguminosas', 76, 4.8, 13.6, 0.5, 8.5, 100),
('Lentilha cozida', 'Leguminosas', 93, 6.3, 16.3, 0.5, 7.9, 100),
('Grão-de-bico cozido', 'Leguminosas', 164, 8.9, 27.4, 2.6, 7.6, 100),
-- GORDURAS BOAS
('Abacate', 'Gorduras', 96, 1.2, 6.0, 8.4, 6.3, 100),
('Azeite de oliva', 'Gorduras', 884, 0, 0, 100, 0, 10),
('Amendoim (torrado)', 'Gorduras', 592, 25.4, 19.7, 46.7, 7.8, 30),
('Pasta de amendoim integral', 'Gorduras', 595, 25.0, 20.0, 50.0, 8.0, 30),
('Castanha-do-pará', 'Gorduras', 659, 14.3, 15.1, 63.5, 7.5, 30),
('Amêndoas', 'Gorduras', 579, 21.2, 21.7, 49.4, 12.5, 30),
('Chia', 'Gorduras', 486, 17.0, 42.1, 30.7, 34.4, 20),
('Linhaça', 'Gorduras', 534, 18.3, 28.9, 42.2, 27.3, 20),
-- FRUTAS
('Banana prata', 'Frutas', 92, 1.4, 23.8, 0.1, 1.9, 100),
('Maçã', 'Frutas', 56, 0.3, 15.2, 0.1, 1.3, 130),
('Laranja', 'Frutas', 47, 1.0, 11.5, 0.1, 2.4, 130),
('Morango', 'Frutas', 34, 0.7, 7.7, 0.3, 2.0, 100),
('Manga', 'Frutas', 59, 0.8, 15.3, 0.2, 1.6, 100),
('Melancia', 'Frutas', 33, 0.6, 7.5, 0.4, 0.4, 200),
('Mamão papaia', 'Frutas', 40, 0.5, 10.4, 0.1, 1.8, 150),
('Uva', 'Frutas', 69, 0.7, 17.7, 0.2, 0.9, 100),
('Blueberry', 'Frutas', 57, 0.7, 14.5, 0.3, 2.4, 100),
-- VEGETAIS
('Brócolis cozido', 'Vegetais', 25, 2.9, 3.6, 0.3, 2.5, 100),
('Espinafre cru', 'Vegetais', 22, 2.9, 3.6, 0.4, 2.2, 100),
('Tomate', 'Vegetais', 15, 1.1, 3.1, 0.2, 1.2, 100),
('Cenoura crua', 'Vegetais', 34, 0.9, 7.7, 0.2, 3.2, 100),
('Abobrinha cozida', 'Vegetais', 22, 1.4, 4.5, 0.3, 1.2, 100),
('Pepino', 'Vegetais', 13, 0.7, 2.9, 0.1, 0.5, 100),
('Alface', 'Vegetais', 11, 1.3, 2.1, 0.2, 1.2, 30),
('Chuchu cozido', 'Vegetais', 20, 0.9, 4.4, 0.1, 1.5, 100),
('Pimentão vermelho', 'Vegetais', 28, 0.9, 6.3, 0.3, 2.1, 100),
('Couve-flor', 'Vegetais', 21, 1.9, 4.2, 0.1, 2.3, 100);

-- ============================================================
-- SEED - Exercícios por grupo muscular
-- ============================================================
insert into public.exercicios (nome, grupo_muscular, musculo_primario, musculos_secundarios, tipo, equipamento, instrucoes, dicas, dificuldade) values

-- PEITO
('Supino Reto com Barra', 'Peito', 'Peitoral maior', ARRAY['Deltóide anterior', 'Tríceps'], 'composto', 'Barra + Banco',
'1. Deite no banco com os pés no chão\n2. Segure a barra na largura dos ombros\n3. Desça a barra até tocar o peito\n4. Empurre de volta à posição inicial',
'Mantenha as escápulas retraídas durante todo o movimento. Não solte os cotovelos para fora excessivamente.', 'intermediario'),

('Supino Inclinado com Halteres', 'Peito', 'Peitoral maior (porção superior)', ARRAY['Deltóide anterior', 'Tríceps'], 'composto', 'Halteres + Banco inclinado',
'1. Incline o banco em 30-45°\n2. Segure os halteres na altura do peito\n3. Empurre até a extensão total\n4. Retorne controladamente',
'Ângulo de inclinação menor que 45° foca mais no peitoral superior. Mantenha os pés firmes no chão.', 'intermediario'),

('Flexão de Braço', 'Peito', 'Peitoral maior', ARRAY['Tríceps', 'Deltóide anterior', 'Core'], 'composto', 'Sem equipamento',
'1. Posição de prancha com mãos na largura dos ombros\n2. Desça o corpo até o peito quase tocar o chão\n3. Empurre de volta\n4. Mantenha o corpo reto',
'Evite que o quadril suba ou desça. Variações: pés elevados (superior), mãos mais abertas (externo).', 'iniciante'),

('Crucifixo com Halteres', 'Peito', 'Peitoral maior', ARRAY['Deltóide anterior'], 'isolamento', 'Halteres + Banco',
'1. Deite no banco segurando os halteres\n2. Abra os braços em arco mantendo leve flexão nos cotovelos\n3. Sinta o alongamento no peito\n4. Feche em arco voltando ao início',
'Não abra demais para evitar lesão no ombro. Leve flexão fixa no cotovelo durante todo o movimento.', 'iniciante'),

-- COSTAS
('Puxada Frontal com Barra', 'Costas', 'Grande dorsal', ARRAY['Bíceps', 'Romboides', 'Infraespinhoso'], 'composto', 'Polia alta',
'1. Sente-se com as coxas sob os apoios\n2. Pegue a barra com pegada supinada na largura dos ombros\n3. Puxe a barra até o queixo\n4. Retorne controladamente',
'Incline levemente o tronco para trás. Concentre em puxar pelos cotovelos, não pelas mãos.', 'iniciante'),

('Remada Curvada com Barra', 'Costas', 'Grande dorsal', ARRAY['Trapézio', 'Romboides', 'Bíceps'], 'composto', 'Barra',
'1. Curvatura de 45° no quadril com barra nas mãos\n2. Puxe a barra em direção ao umbigo\n3. Contraia as escápulas no topo\n4. Retorne controladamente',
'Mantenha a coluna neutra. Não balance o tronco para ganhar impulso.', 'intermediario'),

('Barra Fixa', 'Costas', 'Grande dorsal', ARRAY['Bíceps', 'Infraespinhoso', 'Core'], 'composto', 'Barra fixa',
'1. Pegue a barra com pegada pronada na largura dos ombros\n2. Parta de braços estendidos\n3. Puxe até o queixo ultrapassar a barra\n4. Desça com controle',
'Cruze os pés e mantenha o core ativado. Uma das melhores alternativas ao pull-down.', 'avancado'),

('Remada Unilateral com Halter', 'Costas', 'Grande dorsal', ARRAY['Romboides', 'Bíceps', 'Trapézio médio'], 'composto', 'Halter + Banco',
'1. Apoie um joelho e mão no banco\n2. Segure o halter com o braço estendido\n3. Puxe o halter até o quadril\n4. Retorne controladamente',
'Mantenha o cotovelo próximo ao corpo. Gire levemente o tronco para maximizar amplitude.', 'iniciante'),

-- OMBROS
('Desenvolvimento com Halteres', 'Ombros', 'Deltóide medial', ARRAY['Deltóide anterior', 'Trapézio', 'Tríceps'], 'composto', 'Halteres',
'1. Sente-se com os halteres na altura dos ombros\n2. Empurre para cima até quase estender os braços\n3. Retorne controladamente\n4. Não trave os cotovelos',
'Manter leve flexão no topo protege os ombros. Pode fazer em pé também.', 'iniciante'),

('Elevação Lateral', 'Ombros', 'Deltóide medial', ARRAY['Trapézio superior'], 'isolamento', 'Halteres',
'1. Em pé, segure os halteres ao lado do corpo\n2. Eleve os braços lateralmente até a altura dos ombros\n3. Pause brevemente\n4. Desça controladamente',
'Imagine que está despejando água de uma jarra. Evite balançar o corpo. Use cargas mais leves.', 'iniciante'),

('Elevação Frontal', 'Ombros', 'Deltóide anterior', ARRAY['Peitoral superior'], 'isolamento', 'Halteres ou Barra',
'1. Em pé, segure os halteres à frente do corpo\n2. Eleve um braço de cada vez até a altura dos ombros\n3. Pause brevemente\n4. Desça controladamente',
'Mantenha leve flexão no cotovelo. Alternando os braços é mais eficiente.', 'iniciante'),

('Desenvolvimento Arnold', 'Ombros', 'Deltóide', ARRAY['Tríceps', 'Trapézio'], 'composto', 'Halteres',
'1. Inicie com halteres à frente, palmas viradas para você\n2. Ao empurrar, gire os pulsos para fora\n3. Complete com palmas para frente no topo\n4. Reverta o movimento na descida',
'Movimento criado por Arnold Schwarzenegger. Trabalha todas as porções do deltóide.', 'intermediario'),

-- BÍCEPS
('Rosca Direta com Barra', 'Bíceps', 'Bíceps braquial', ARRAY['Braquial', 'Braquiorradial'], 'isolamento', 'Barra',
'1. Em pé, segure a barra com pegada supinada\n2. Flexione os cotovelos trazendo a barra até os ombros\n3. Contraia no topo\n4. Desça controladamente',
'Cotovelos fixos ao lado do corpo. Não use impulso do corpo. Barra W reduz pressão nos pulsos.', 'iniciante'),

('Rosca Martelo', 'Bíceps', 'Braquial', ARRAY['Bíceps', 'Braquiorradial'], 'isolamento', 'Halteres',
'1. Em pé, segure os halteres com pegada neutra (palmas voltadas para si)\n2. Flexione um braço de cada vez\n3. Mantenha o pulso neutro durante todo o movimento\n4. Alterne os braços',
'A pegada neutra enfatiza o músculo braquial, que fica sob o bíceps e aumenta o "pico".', 'iniciante'),

('Rosca Concentrada', 'Bíceps', 'Bíceps braquial', ARRAY['Braquial'], 'isolamento', 'Halter',
'1. Sente-se com o cotovelo apoiado na coxa interna\n2. Curle o halter concentrando no bíceps\n3. Contraia fortemente no topo\n4. Desça lentamente',
'Excelente para isolamento e contração de pico. Foco total no bíceps.', 'iniciante'),

-- TRÍCEPS
('Tríceps Pulley', 'Tríceps', 'Tríceps braquial', ARRAY['Anconeu'], 'isolamento', 'Polia alta',
'1. Em pé, segure a corda ou barra da polia alta\n2. Cotovelos fixos ao lado do corpo\n3. Estenda os braços completamente\n4. Retorne controladamente',
'Cotovelos devem permanecer fixos. No final da extensão, abra a corda para maximizar contração.', 'iniciante'),

('Supino Fechado', 'Tríceps', 'Tríceps braquial', ARRAY['Peitoral', 'Deltóide anterior'], 'composto', 'Barra',
'1. Deite no banco com pegada estreita na barra\n2. Desça a barra controladamente até o peito\n3. Empurre de volta focando nos tríceps\n4. Não feche demais a pegada',
'Pegada um pouco mais estreita que os ombros. Muito estreita pode causar dor no pulso.', 'intermediario'),

('Mergulho em Banco (Tricep Dip)', 'Tríceps', 'Tríceps braquial', ARRAY['Peitoral inferior', 'Deltóide anterior'], 'composto', 'Banco',
'1. Apoie as mãos no banco atrás de você\n2. Pés no chão ou em outro banco\n3. Desça flexionando os cotovelos\n4. Empurre de volta',
'Para focar no tríceps, mantenha o corpo próximo ao banco. Para mais dificuldade, eleve os pés.', 'iniciante'),

-- PERNAS
('Agachamento com Barra', 'Pernas', 'Quadríceps', ARRAY['Glúteos', 'Isquiotibiais', 'Lombar', 'Core'], 'composto', 'Barra + Rack',
'1. Barra apoiada nos trapézios, pés na largura dos ombros\n2. Desça como se fosse sentar em uma cadeira\n3. Joelhos acompanham a direção dos pés\n4. Suba mantendo a coluna neutra',
'O agachamento é o rei dos exercícios. Desça até as coxas ficarem paralelas ao chão. Respire fundo antes de descer.', 'intermediario'),

('Leg Press 45°', 'Pernas', 'Quadríceps', ARRAY['Glúteos', 'Isquiotibiais', 'Adutores'], 'composto', 'Leg Press',
'1. Sente-se na máquina com os pés na plataforma na largura dos ombros\n2. Solte os travas\n3. Desça controladamente até 90° nos joelhos\n4. Empurre de volta sem travar os joelhos',
'Posição dos pés mais alta = mais glúteo. Mais baixa = mais quadríceps. Não trave os joelhos no topo.', 'iniciante'),

('Stiff (Romanian Deadlift)', 'Pernas', 'Isquiotibiais', ARRAY['Glúteos', 'Lombar'], 'composto', 'Barra ou Halteres',
'1. Em pé, segure a barra na frente\n2. Empurre o quadril para trás descendo a barra\n3. Sinta o alongamento nos isquiotibiais\n4. Retorne contraindo o glúteo',
'Não é levantamento terra. Joelhos levemente flexionados, barra próxima ao corpo, coluna neutra.', 'intermediario'),

('Extensora (Leg Extension)', 'Pernas', 'Quadríceps', ARRAY['Vasto lateral', 'Vasto medial'], 'isolamento', 'Máquina',
'1. Sente-se na máquina com o encosto nas coxas\n2. Estenda as pernas completamente\n3. Contraia no topo\n4. Desça controladamente',
'Exercício de isolamento para quadríceps. Ótimo para finalizar após compostos.', 'iniciante'),

('Flexora (Leg Curl)', 'Pernas', 'Isquiotibiais', ARRAY['Gastrocnêmio'], 'isolamento', 'Máquina',
'1. Deite na máquina com os calcanhares sob o rolo\n2. Flexione os joelhos trazendo os calcanhares em direção ao glúteo\n3. Contraia no topo\n4. Desça lentamente',
'Flexão máxima = maior contração. Pode fazer sentado (leg curl sentado) para maior ênfase no comprimento.', 'iniciante'),

('Agachamento Búlgaro', 'Pernas', 'Quadríceps', ARRAY['Glúteos', 'Isquiotibiais', 'Adutores'], 'composto', 'Halteres + Banco',
'1. Pé de trás apoiado no banco\n2. Pé da frente afastado o suficiente\n3. Desça até a coxa da frente ficar paralela\n4. Empurre com o calcanhar para subir',
'Excelente para glúteos e força unilateral. Aumenta equilíbrio e corrige assimetrias.', 'avancado'),

('Panturrilha em Pé', 'Pernas', 'Gastrocnêmio', ARRAY['Sóleo'], 'isolamento', 'Máquina ou degrau',
'1. Em pé com a ponta dos pés no degrau\n2. Suba na ponta dos pés o mais alto possível\n3. Contraia no topo e pause\n4. Desça abaixo da linha do degrau para alongar',
'Amplitude completa é fundamental: alongamento total na descida. Use cargas progressivas.', 'iniciante'),

-- GLÚTEOS
('Hip Thrust com Barra', 'Glúteos', 'Glúteo máximo', ARRAY['Isquiotibiais', 'Core'], 'composto', 'Barra + Banco',
'1. Costas apoiadas no banco, barra sobre o quadril\n2. Pés no chão na largura dos ombros\n3. Empurre o quadril para cima contraindo o glúteo\n4. Mantenha o core ativado na descida',
'O melhor exercício isolado para glúteo. Acolchoamento na barra evita desconforto no quadril.', 'intermediario'),

('Elevação Pélvica (Glute Bridge)', 'Glúteos', 'Glúteo máximo', ARRAY['Isquiotibiais', 'Core'], 'composto', 'Peso corporal ou anilha',
'1. Deitado no chão, joelhos flexionados\n2. Empurre o quadril para cima\n3. Contraia o glúteo no topo\n4. Desça controladamente',
'Versão mais acessível do Hip Thrust. Pode adicionar peso no quadril para progressão.', 'iniciante'),

-- CORE / ABDÔMEN
('Prancha Isométrica', 'Core', 'Reto abdominal', ARRAY['Transverso abdominal', 'Oblíquos', 'Lombar'], 'funcional', 'Sem equipamento',
'1. Posição de flexão com antebraços no chão\n2. Corpo em linha reta da cabeça aos calcanhares\n3. Mantenha o core fortemente contraído\n4. Respire normalmente',
'Não levante ou afunde o quadril. Comece com 30 segundos e progrida. Uma das melhores para o core.', 'iniciante'),

('Crunch Abdominal', 'Core', 'Reto abdominal', ARRAY['Oblíquos'], 'isolamento', 'Sem equipamento',
'1. Deitado com joelhos flexionados\n2. Mãos atrás da cabeça sem puxar\n3. Contraia o abdômen elevando os ombros\n4. Pause e desça controladamente',
'Movimento pequeno e controlado. Foco na contração do reto abdominal, não em subir alto.', 'iniciante'),

('Abdominal Bicicleta', 'Core', 'Oblíquos', ARRAY['Reto abdominal', 'Flexores do quadril'], 'funcional', 'Sem equipamento',
'1. Deitado, mãos atrás da cabeça\n2. Leve joelho esquerdo ao cotovelo direito\n3. Alterne para o lado oposto\n4. Mantenha as costas baixas',
'Movimento lento e controlado é mais eficaz. Um dos mais efetivos para oblíquos.', 'iniciante'),

-- CARDIO
('Corrida (esteira ou rua)', 'Cardio', 'Sistema cardiovascular', ARRAY['Quadríceps', 'Isquiotibiais', 'Gastrocnêmio'], 'cardio', 'Esteira ou livre',
'1. Aquecimento de 5 min em ritmo leve\n2. Mantenha cadência de 170-180 passos/min\n3. Postura ereta, olhar no horizonte\n4. Respire de forma rítmica',
'Frequência cardíaca alvo: 60-75% da FC máxima para queima de gordura. FC máxima = 220 - idade.', 'iniciante'),

('HIIT (Intervalado de Alta Intensidade)', 'Cardio', 'Sistema cardiovascular', ARRAY['Membros inferiores', 'Core'], 'cardio', 'Sem equipamento',
'1. Aquecimento 5 min\n2. Esforço máximo 20-30 segundos\n3. Recuperação ativa 10-40 segundos\n4. Repita 8-12 vezes',
'Muito eficiente para queima de gordura e manutenção muscular. Não mais que 3x por semana.', 'avancado'),

('Pular Corda', 'Cardio', 'Sistema cardiovascular', ARRAY['Gastrocnêmio', 'Ombros', 'Core'], 'cardio', 'Corda',
'1. Segure a corda nas laterais do corpo\n2. Pule sobre as pontas dos pés\n3. Mantenha saltos baixos e rítmicos\n4. Core ativado durante o exercício',
'Excelente condicionamento cardiovascular e coordenação. Queima ~10 cal/min.', 'iniciante'),

('Polichinelo (Jumping Jack)', 'Cardio', 'Sistema cardiovascular', ARRAY['Deltóides', 'Glúteos', 'Adutores'], 'cardio', 'Sem equipamento',
'1. Em pé, braços ao lado do corpo\n2. Pule abrindo pernas e elevando braços\n3. Retorne à posição inicial\n4. Mantenha ritmo constante',
'Excelente aquecimento. Simples e efetivo para elevar a frequência cardíaca rapidamente.', 'iniciante');
