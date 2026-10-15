-- Tenby Campus Circle: moderated comments schema reference.
-- Run only against the intended Supabase project. Public comments are read-only
-- until approved by an administrator.

create table if not exists public.comments (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references public.posts(id) on delete cascade,
  nickname text not null default '匿名同学' check (char_length(nickname) between 1 and 24),
  content text not null check (char_length(btrim(content)) between 1 and 500),
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  created_at timestamptz not null default now()
);

create index if not exists comments_post_status_created_idx
  on public.comments (post_id, status, created_at desc);

alter table public.comments enable row level security;

drop policy if exists "Anyone can read approved comments on approved posts" on public.comments;
create policy "Anyone can read approved comments on approved posts"
on public.comments for select to anon, authenticated
using (
  status = 'approved'
  and exists (
    select 1 from public.posts p
    where p.id = comments.post_id and p.status = 'approved'
  )
);

drop policy if exists "Anyone can submit pending comments" on public.comments;
create policy "Anyone can submit pending comments"
on public.comments for insert to anon, authenticated
with check (
  status = 'pending'
  and exists (
    select 1 from public.posts p
    where p.id = comments.post_id and p.status = 'approved'
  )
);

drop policy if exists "Admins can read all comments" on public.comments;
create policy "Admins can read all comments"
on public.comments for select to authenticated
using ((select auth.jwt()->'app_metadata'->>'role') = 'admin');

drop policy if exists "Admins can update comments" on public.comments;
create policy "Admins can update comments"
on public.comments for update to authenticated
using ((select auth.jwt()->'app_metadata'->>'role') = 'admin')
with check ((select auth.jwt()->'app_metadata'->>'role') = 'admin');

drop policy if exists "Admins can delete comments" on public.comments;
create policy "Admins can delete comments"
on public.comments for delete to authenticated
using ((select auth.jwt()->'app_metadata'->>'role') = 'admin');

revoke all privileges on table public.comments from public, anon, authenticated;
grant select, insert on table public.comments to anon;
grant select, insert, update, delete on table public.comments to authenticated;
