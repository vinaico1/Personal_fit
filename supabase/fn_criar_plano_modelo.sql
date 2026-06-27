-- ============================================================
-- Função: criar_plano_modelo
-- Cria plano de treino profissional para o usuário.
-- Modelos: 'fullbody' | 'ppl' | 'abc'
-- Uso: SELECT criar_plano_modelo('user-uuid', 'ppl');
-- ============================================================

CREATE OR REPLACE FUNCTION criar_plano_modelo(p_user_id uuid, p_modelo text)
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_plano_id uuid;
  v_dia_a    uuid;
  v_dia_b    uuid;
  v_dia_c    uuid;
  v_dia_d    uuid;
  v_dia_e    uuid;
  v_dia_f    uuid;
BEGIN

  -- Desativa plano ativo
  UPDATE public.planos_treino SET ativo = false
  WHERE user_id = p_user_id AND ativo = true;

  -- ============================================================
  -- FULL BODY 3x/SEMANA — INICIANTE
  -- ============================================================
  IF p_modelo = 'fullbody' THEN

    INSERT INTO public.planos_treino (user_id, nome, tipo, dias_semana, objetivo, ativo)
    VALUES (p_user_id, 'Full Body 3x', 'Full Body', 3, 'hipertrofia', true)
    RETURNING id INTO v_plano_id;

    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 1, 'Treino A', 'Full Body', 0) RETURNING id INTO v_dia_a;
    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 3, 'Treino B', 'Full Body', 1) RETURNING id INTO v_dia_b;
    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 5, 'Treino C', 'Full Body', 2) RETURNING id INTO v_dia_c;

    -- Exercícios idênticos nos 3 dias
    INSERT INTO public.dia_exercicios (dia_id, user_id, exercicio_id, series, repeticoes, descanso_segundos, ordem)
    SELECT d.dia_id, p_user_id, e.id, d.s, d.r, d.ds, d.o
    FROM (VALUES
      (v_dia_a,'Agachamento com Barra',       3,'8-10', 90,0),(v_dia_a,'Supino Reto com Barra',       3,'8-10', 90,1),
      (v_dia_a,'Remada Curvada com Barra',    3,'8-10', 90,2),(v_dia_a,'Desenvolvimento com Halteres',3,'10-12',75,3),
      (v_dia_a,'Rosca Direta com Barra',      3,'10-12',60,4),(v_dia_a,'Tríceps Pulley',              3,'12-15',60,5),
      (v_dia_a,'Prancha Isométrica',          3,'30s',  45,6),
      (v_dia_b,'Agachamento com Barra',       3,'10-12',90,0),(v_dia_b,'Supino Reto com Barra',       3,'10-12',90,1),
      (v_dia_b,'Remada Curvada com Barra',    3,'10-12',90,2),(v_dia_b,'Desenvolvimento com Halteres',3,'12',   75,3),
      (v_dia_b,'Rosca Direta com Barra',      3,'12',   60,4),(v_dia_b,'Tríceps Pulley',              3,'15',   60,5),
      (v_dia_b,'Prancha Isométrica',          3,'30s',  45,6),
      (v_dia_c,'Agachamento com Barra',       3,'8-12', 90,0),(v_dia_c,'Supino Reto com Barra',       3,'8-12', 90,1),
      (v_dia_c,'Remada Curvada com Barra',    3,'8-12', 90,2),(v_dia_c,'Desenvolvimento com Halteres',3,'10-12',75,3),
      (v_dia_c,'Rosca Direta com Barra',      3,'10-12',60,4),(v_dia_c,'Tríceps Pulley',              3,'12-15',60,5),
      (v_dia_c,'Prancha Isométrica',          3,'30s',  45,6)
    ) AS d(dia_id, nome_ex, s, r, ds, o)
    JOIN public.exercicios e ON e.nome = d.nome_ex;

  -- ============================================================
  -- PPL 6x/SEMANA — INTERMEDIÁRIO
  -- ============================================================
  ELSIF p_modelo = 'ppl' THEN

    INSERT INTO public.planos_treino (user_id, nome, tipo, dias_semana, objetivo, ativo)
    VALUES (p_user_id, 'Push Pull Legs 6x', 'Push/Pull/Legs', 6, 'hipertrofia', true)
    RETURNING id INTO v_plano_id;

    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 1, 'Push A',  'Peito, Ombros, Tríceps', 0) RETURNING id INTO v_dia_a;
    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 2, 'Pull A',  'Costas, Bíceps',          1) RETURNING id INTO v_dia_b;
    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 3, 'Legs A',  'Pernas, Glúteos',         2) RETURNING id INTO v_dia_c;
    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 4, 'Push B',  'Peito, Ombros, Tríceps', 3) RETURNING id INTO v_dia_d;
    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 5, 'Pull B',  'Costas, Bíceps',          4) RETURNING id INTO v_dia_e;
    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 6, 'Legs B',  'Pernas, Glúteos',         5) RETURNING id INTO v_dia_f;

    INSERT INTO public.dia_exercicios (dia_id, user_id, exercicio_id, series, repeticoes, descanso_segundos, ordem)
    SELECT d.dia_id, p_user_id, e.id, d.s, d.r, d.ds, d.o
    FROM (VALUES
      -- Push A
      (v_dia_a,'Supino Reto com Barra',         4,'6-8',  120,0),
      (v_dia_a,'Supino Inclinado com Halteres',  3,'8-10',  90,1),
      (v_dia_a,'Crucifixo com Halteres',         3,'12-15', 60,2),
      (v_dia_a,'Desenvolvimento com Halteres',   4,'8-10',  90,3),
      (v_dia_a,'Elevação Lateral',               4,'15-20', 60,4),
      (v_dia_a,'Supino Fechado',                 3,'10-12', 75,5),
      (v_dia_a,'Tríceps Pulley',                 3,'12-15', 60,6),
      -- Pull A
      (v_dia_b,'Barra Fixa',                     4,'6-8',  120,0),
      (v_dia_b,'Remada Curvada com Barra',       4,'6-8',  120,1),
      (v_dia_b,'Puxada Frontal com Barra',       3,'10-12', 90,2),
      (v_dia_b,'Remada Unilateral com Halter',   3,'12',    75,3),
      (v_dia_b,'Rosca Direta com Barra',         4,'10-12', 60,4),
      (v_dia_b,'Rosca Martelo',                  3,'12-15', 60,5),
      -- Legs A
      (v_dia_c,'Agachamento com Barra',          4,'6-8',  120,0),
      (v_dia_c,'Leg Press 45°',                  3,'10-12', 90,1),
      (v_dia_c,'Stiff (Romanian Deadlift)',      3,'10-12', 90,2),
      (v_dia_c,'Hip Thrust com Barra',           3,'12-15', 90,3),
      (v_dia_c,'Extensora (Leg Extension)',      3,'15-20', 60,4),
      (v_dia_c,'Flexora (Leg Curl)',             3,'15-20', 60,5),
      (v_dia_c,'Panturrilha em Pé',              4,'15-20', 45,6),
      -- Push B
      (v_dia_d,'Supino Inclinado com Halteres',  4,'8-10',  90,0),
      (v_dia_d,'Supino Reto com Barra',          3,'8-10',  90,1),
      (v_dia_d,'Crucifixo com Halteres',         3,'12-15', 60,2),
      (v_dia_d,'Desenvolvimento Arnold',          3,'10-12', 90,3),
      (v_dia_d,'Elevação Frontal',               3,'12-15', 60,4),
      (v_dia_d,'Mergulho em Banco (Tricep Dip)', 3,'10-12', 75,5),
      (v_dia_d,'Supino Fechado',                 3,'10-12', 60,6),
      -- Pull B
      (v_dia_e,'Remada Curvada com Barra',       4,'8-10',  90,0),
      (v_dia_e,'Puxada Frontal com Barra',       4,'10-12', 90,1),
      (v_dia_e,'Remada Unilateral com Halter',   3,'12',    75,2),
      (v_dia_e,'Barra Fixa',                     3,'6-8',   90,3),
      (v_dia_e,'Rosca Concentrada',              3,'12-15', 60,4),
      (v_dia_e,'Rosca Martelo',                  3,'12-15', 60,5),
      -- Legs B
      (v_dia_f,'Leg Press 45°',                  4,'10-12', 90,0),
      (v_dia_f,'Agachamento Búlgaro',            3,'10-12', 90,1),
      (v_dia_f,'Stiff (Romanian Deadlift)',      3,'10-12', 90,2),
      (v_dia_f,'Hip Thrust com Barra',           4,'12-15', 90,3),
      (v_dia_f,'Flexora (Leg Curl)',             3,'15-20', 60,4),
      (v_dia_f,'Extensora (Leg Extension)',      3,'15-20', 60,5),
      (v_dia_f,'Panturrilha em Pé',              4,'20',    45,6)
    ) AS d(dia_id, nome_ex, s, r, ds, o)
    JOIN public.exercicios e ON e.nome = d.nome_ex;

  -- ============================================================
  -- ABC 3x/SEMANA — INTERMEDIÁRIO
  -- ============================================================
  ELSIF p_modelo = 'abc' THEN

    INSERT INTO public.planos_treino (user_id, nome, tipo, dias_semana, objetivo, ativo)
    VALUES (p_user_id, 'Divisão ABC 3x', 'ABC Split', 3, 'hipertrofia', true)
    RETURNING id INTO v_plano_id;

    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 1, 'Dia A', 'Peito, Ombros, Tríceps', 0) RETURNING id INTO v_dia_a;
    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 3, 'Dia B', 'Costas, Bíceps',         1) RETURNING id INTO v_dia_b;
    INSERT INTO public.dias_treino (plano_id, user_id, dia_semana, nome, grupo_foco, ordem)
    VALUES (v_plano_id, p_user_id, 5, 'Dia C', 'Pernas, Glúteos, Core',  2) RETURNING id INTO v_dia_c;

    INSERT INTO public.dia_exercicios (dia_id, user_id, exercicio_id, series, repeticoes, descanso_segundos, ordem)
    SELECT d.dia_id, p_user_id, e.id, d.s, d.r, d.ds, d.o
    FROM (VALUES
      -- Dia A — Peito, Ombros, Tríceps
      (v_dia_a,'Supino Reto com Barra',         4,'6-8',  120,0),
      (v_dia_a,'Supino Inclinado com Halteres',  3,'10-12', 75,1),
      (v_dia_a,'Crucifixo com Halteres',         3,'12-15', 60,2),
      (v_dia_a,'Desenvolvimento com Halteres',   4,'8-10',  90,3),
      (v_dia_a,'Elevação Lateral',               4,'15-20', 60,4),
      (v_dia_a,'Elevação Frontal',               3,'12-15', 60,5),
      (v_dia_a,'Tríceps Pulley',                 4,'12-15', 60,6),
      (v_dia_a,'Mergulho em Banco (Tricep Dip)', 3,'10-12', 60,7),
      -- Dia B — Costas, Bíceps
      (v_dia_b,'Barra Fixa',                     4,'5-8',  120,0),
      (v_dia_b,'Remada Curvada com Barra',       4,'8-10', 120,1),
      (v_dia_b,'Puxada Frontal com Barra',       3,'10-12', 90,2),
      (v_dia_b,'Remada Unilateral com Halter',   3,'12',    75,3),
      (v_dia_b,'Rosca Direta com Barra',         4,'8-12',  60,4),
      (v_dia_b,'Rosca Martelo',                  3,'12-15', 60,5),
      (v_dia_b,'Rosca Concentrada',              3,'12-15', 60,6),
      -- Dia C — Pernas, Glúteos, Core
      (v_dia_c,'Agachamento com Barra',          4,'6-10', 120,0),
      (v_dia_c,'Leg Press 45°',                  3,'12-15', 90,1),
      (v_dia_c,'Stiff (Romanian Deadlift)',      3,'10-12', 90,2),
      (v_dia_c,'Hip Thrust com Barra',           4,'12-15', 90,3),
      (v_dia_c,'Agachamento Búlgaro',            3,'10-12', 75,4),
      (v_dia_c,'Extensora (Leg Extension)',      3,'15-20', 60,5),
      (v_dia_c,'Flexora (Leg Curl)',             3,'15-20', 60,6),
      (v_dia_c,'Panturrilha em Pé',              4,'15-20', 45,7),
      (v_dia_c,'Prancha Isométrica',             3,'45s',   45,8),
      (v_dia_c,'Abdominal Bicicleta',            3,'20',    30,9)
    ) AS d(dia_id, nome_ex, s, r, ds, o)
    JOIN public.exercicios e ON e.nome = d.nome_ex;

  END IF;

  RETURN v_plano_id;
END;
$$;

GRANT EXECUTE ON FUNCTION criar_plano_modelo(uuid, text) TO authenticated;
