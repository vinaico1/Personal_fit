-- Criar usuário Ariane Borges
-- Execute no SQL Editor do Supabase (Authentication > SQL Editor)

INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at,
  confirmation_token,
  recovery_token,
  email_change_token_new,
  email_change,
  is_super_admin
)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'ariane01borges@gmail.com',
  crypt('190191', gen_salt('bf')),
  now(),
  '{"provider": "email", "providers": ["email"]}',
  '{"full_name": "Ariane Borges", "nome": "Ariane Borges"}',
  now(),
  now(),
  '',
  '',
  '',
  '',
  false
);

-- Verificar se foi criado
SELECT id, email, created_at, email_confirmed_at
FROM auth.users
WHERE email = 'ariane01borges@gmail.com';
