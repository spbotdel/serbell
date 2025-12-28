create table if not exists public.person_media (
  id uuid primary key default gen_random_uuid(),
  person_id text not null,
  media_path text not null,
  media_type text not null,
  created_at timestamptz not null default now()
);

alter table public.person_media enable row level security;

create policy "person_media_select_all"
  on public.person_media
  for select
  using (true);

create policy "person_media_modify_auth"
  on public.person_media
  for insert
  with check (auth.role() = 'authenticated');

create policy "person_media_update_auth"
  on public.person_media
  for update
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

create policy "person_media_delete_auth"
  on public.person_media
  for delete
  using (auth.role() = 'authenticated');
