create table
  public.business (
    id integer generated by default as identity,
    name text not null,
    address text not null,
    commissions_rate double precision null,
    constraint business_pkey primary key (id)
  ) tablespace pg_default;

create table
  public.coupons (
    id integer generated by default as identity,
    name text not null,
    valid boolean not null,
    business_id integer not null,
    price integer not null,
    constraint Coupons_pkey primary key (id),
    constraint coupons_business_id_fkey foreign key (business_id) references business (id) on update cascade on delete cascade
  ) tablespace pg_default;

create table
  public.followers (
    id integer generated by default as identity,
    follower_id integer not null,
    date_added timestamp with time zone null,
    user_id integer not null,
    user_name text null,
    follower_name text null,
    constraint Friendship_pkey primary key (id),
    constraint followers_follower_id_fkey foreign key (follower_id) references users (id) on update cascade on delete cascade,
    constraint followers_user_id_fkey foreign key (user_id) references users (id) on update cascade on delete cascade
  ) tablespace pg_default;

create table
  public.review (
    id integer generated by default as identity,
    description text null,
    rating integer not null,
    route_id integer not null,
    user_id integer not null,
    difficulty integer not null,
    constraint Review_pkey primary key (id),
    constraint review_route_id_fkey foreign key (route_id) references routes (id),
    constraint review_user_id_fkey foreign key (user_id) references users (id) on update cascade on delete restrict
  ) tablespace pg_default;

create table
  public.routes (
    id integer generated by default as identity,
    name text not null,
    address text null,
    city text null,
    state text not null,
    length_in_miles real not null,
    added_by_user_id integer not null,
    coordinates double precision[] not null,
    constraint route_info_pkey primary key (id),
    constraint routes_name_key unique (name),
    constraint routes_added_by_user_id_fkey foreign key (added_by_user_id) references users (id)
  ) tablespace pg_default;

create table
  public.user_coupon_ledger (
    date timestamp with time zone not null default now(),
    user_id integer not null,
    coupon_id integer not null,
    change integer null default 0,
    id integer generated by default as identity,
    constraint user_coupon_ledger_pkey primary key (id),
    constraint user_coupon_ledger_coupon_id_fkey foreign key (coupon_id) references coupons (id) on update cascade on delete restrict,
    constraint user_coupon_ledger_user_id_fkey foreign key (user_id) references users (id) on update cascade on delete restrict
  ) tablespace pg_default;

create table
  public.user_peepcoin_ledger (
    date timestamp with time zone not null default now(),
    user_id integer not null,
    change integer null default 0,
    id integer generated by default as identity,
    constraint user_peepcoin_ledger_pkey primary key (id),
    constraint user_peepcoin_ledger_user_id_fkey foreign key (user_id) references users (id) on update cascade on delete restrict
  ) tablespace pg_default;

create table
  public.users (
    id integer generated by default as identity,
    date_joined timestamp with time zone not null default now(),
    username text null,
    num_followers integer not null default 0,
    constraint user_test_pkey primary key (id),
    constraint users_username_key unique (username)
  ) tablespace pg_default;