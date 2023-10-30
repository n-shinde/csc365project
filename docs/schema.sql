Route Table:
  
create table
  public.route (
    id integer generated by default as identity,
    name text not null,
    date_added timestamp with time zone null default now(),
    location text null,
    length_in_miles real null,
    difficulty integer null,
    activities text null,
    coords text[] null,
    user_id bigint null,
    constraint Route_pkey primary key (id)
  ) tablespace pg_default;

User Table

create table
  public.user (
    id integer generated by default as identity,
    username text not null,
    date_joined time without time zone null default now(),
    num_followers integer null default 0,
    boolean boolean null default false,
    peep_coins integer null default 0,
    constraint User_pkey primary key (id),
    constraint User_username_key unique (username)
  ) tablespace pg_default;
