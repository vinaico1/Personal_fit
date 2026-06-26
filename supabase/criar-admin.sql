-- ============================================================
-- Adicionar coluna is_admin na tabela profiles (execute após setup.sql)
-- ============================================================
alter table public.profiles
  add column if not exists is_admin boolean not null default false;

-- ============================================================
-- Criar usuário admin no Supabase Auth
-- Email: vcsconsult1204@gmail.com | Senha: 12345678
-- ============================================================
create extension if not exists pgcrypto;

insert into auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  last_sign_in_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at,
  confirmation_token,
  email_change,
  email_change_token_new,
  recovery_token
)
select
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'vcsconsult1204@gmail.com',
  crypt('12345678', gen_salt('bf')),
  now(),
  now(),
  '{"provider":"email","providers":["email"]}',
  '{"nome":"Admin"}',
  now(),
  now(),
  '', '', '', ''
where not exists (
  select 1 from auth.users where email = 'vcsconsult1204@gmail.com'
);

-- ============================================================
-- Promover o usuário a admin
-- ============================================================
update public.profiles
  set is_admin = true
  where email = 'vcsconsult1204@gmail.com';

-- ============================================================
-- Verificar resultado
-- ============================================================
select p.nome, p.email, p.is_admin, u.created_at
  from public.profiles p
  join auth.users u on u.id = p.id
  where p.email = 'vcsconsult1204@gmail.com';
