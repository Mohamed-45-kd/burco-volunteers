-- Burco Volunteers — Student Registry
-- Run this once in your Supabase project: Dashboard → SQL Editor → New query → paste → Run

create extension if not exists "pgcrypto";

create table if not exists students (
  id                 uuid primary key default gen_random_uuid(),
  full_name          text not null,
  age                int,
  gender             text,
  reg_date           date default current_date,
  disability         text default 'No',
  disability_details text,
  reason             text,
  village            text,
  sector             text,
  edu_place          text,
  sponsor_needed     text default 'Yes',
  sponsor_notes      text,
  parent_name        text,
  parent_rel         text,
  parent_phone       text,
  parent_occupation  text,
  registered_by      text,
  follow_up_phone    text,
  notes              text,
  created_at         timestamptz default now()
);

-- Row Level Security: on, with a permissive policy so the app (using the public anon key)
-- can read/write. The app's password screen is what limits who gets this far — see README
-- for how to tighten this later with real per-volunteer accounts.
alter table students enable row level security;

create policy "Allow all access with anon key"
  on students
  for all
  using (true)
  with check (true);
