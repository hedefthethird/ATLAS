create table if not exists public.items (
  id text primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  kind text not null,
  data jsonb not null default '{}',
  updated_at bigint not null,
  deleted boolean not null default false
);
alter table public.items enable row level security;
create policy "own rows" on public.items for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
alter publication supabase_realtime add table public.items;
