-- =====================================================================
-- MUNDIAL 2026 - Esquema de base de datos para Supabase
-- =====================================================================
-- Copia y pega TODO este archivo en el SQL Editor de Supabase y dale RUN.
-- =====================================================================

-- Tabla de usuarios (nombre + contraseña hash)
create table if not exists users (
  name        text primary key,
  pass_hash   text not null,
  created_at  timestamptz default now()
);

-- Tabla de predicciones de los usuarios
create table if not exists predictions (
  user_name   text not null references users(name) on delete cascade,
  match_id    text not null,
  home_score  int  not null,
  away_score  int  not null,
  updated_at  timestamptz default now(),
  primary key (user_name, match_id)
);

-- Tabla de resultados reales (la llena el admin)
create table if not exists results (
  match_id    text primary key,
  home_score  int  not null,
  away_score  int  not null,
  updated_at  timestamptz default now()
);

-- Configuración global (campeón real, fases cerradas, etc.)
create table if not exists settings (
  key    text primary key,
  value  text
);

-- =====================================================================
-- Row Level Security: permitimos lectura/escritura desde la app web.
-- La contraseña de admin se valida en el cliente.
-- =====================================================================

alter table users           enable row level security;
alter table predictions     enable row level security;
alter table results         enable row level security;
alter table settings        enable row level security;

-- Política permisiva para anon (la app es para amigos, todos pueden leer/escribir)
do $$
begin
  if not exists (select 1 from pg_policies where tablename='users' and policyname='anon_all_users') then
    create policy anon_all_users on users for all to anon using (true) with check (true);
  end if;
  if not exists (select 1 from pg_policies where tablename='predictions' and policyname='anon_all_predictions') then
    create policy anon_all_predictions on predictions for all to anon using (true) with check (true);
  end if;
  if not exists (select 1 from pg_policies where tablename='results' and policyname='anon_all_results') then
    create policy anon_all_results on results for all to anon using (true) with check (true);
  end if;
  if not exists (select 1 from pg_policies where tablename='settings' and policyname='anon_all_settings') then
    create policy anon_all_settings on settings for all to anon using (true) with check (true);
  end if;
end $$;
