-- Ejecuta este SQL en Supabase > SQL Editor > New query.
create table if not exists public.budget_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.budget_data enable row level security;
drop policy if exists "Users can read own budget" on public.budget_data;
create policy "Users can read own budget" on public.budget_data for select to authenticated using (auth.uid() = user_id);
drop policy if exists "Users can insert own budget" on public.budget_data;
create policy "Users can insert own budget" on public.budget_data for insert to authenticated with check (auth.uid() = user_id);
drop policy if exists "Users can update own budget" on public.budget_data;
create policy "Users can update own budget" on public.budget_data for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
