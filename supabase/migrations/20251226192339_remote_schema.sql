drop extension if exists "pg_net";

drop policy "Admins can manage roles" on "public"."user_roles";

drop policy "Users can create own user role" on "public"."user_roles";

drop policy "Users can view own role" on "public"."user_roles";

revoke delete on table "public"."audit_logs" from "anon";

revoke insert on table "public"."audit_logs" from "anon";

revoke references on table "public"."audit_logs" from "anon";

revoke trigger on table "public"."audit_logs" from "anon";

revoke truncate on table "public"."audit_logs" from "anon";

revoke update on table "public"."audit_logs" from "anon";

revoke delete on table "public"."audit_logs" from "authenticated";

revoke insert on table "public"."audit_logs" from "authenticated";

revoke references on table "public"."audit_logs" from "authenticated";

revoke trigger on table "public"."audit_logs" from "authenticated";

revoke truncate on table "public"."audit_logs" from "authenticated";

revoke update on table "public"."audit_logs" from "authenticated";

revoke delete on table "public"."audit_logs" from "service_role";

revoke insert on table "public"."audit_logs" from "service_role";

revoke references on table "public"."audit_logs" from "service_role";

revoke select on table "public"."audit_logs" from "service_role";

revoke trigger on table "public"."audit_logs" from "service_role";

revoke truncate on table "public"."audit_logs" from "service_role";

revoke update on table "public"."audit_logs" from "service_role";

revoke delete on table "public"."categories" from "service_role";

revoke insert on table "public"."categories" from "service_role";

revoke references on table "public"."categories" from "service_role";

revoke select on table "public"."categories" from "service_role";

revoke trigger on table "public"."categories" from "service_role";

revoke truncate on table "public"."categories" from "service_role";

revoke update on table "public"."categories" from "service_role";

revoke delete on table "public"."lyric_play_stats" from "anon";

revoke insert on table "public"."lyric_play_stats" from "anon";

revoke references on table "public"."lyric_play_stats" from "anon";

revoke trigger on table "public"."lyric_play_stats" from "anon";

revoke truncate on table "public"."lyric_play_stats" from "anon";

revoke update on table "public"."lyric_play_stats" from "anon";

revoke delete on table "public"."lyric_play_stats" from "authenticated";

revoke insert on table "public"."lyric_play_stats" from "authenticated";

revoke references on table "public"."lyric_play_stats" from "authenticated";

revoke trigger on table "public"."lyric_play_stats" from "authenticated";

revoke truncate on table "public"."lyric_play_stats" from "authenticated";

revoke update on table "public"."lyric_play_stats" from "authenticated";

revoke delete on table "public"."lyric_play_stats" from "service_role";

revoke insert on table "public"."lyric_play_stats" from "service_role";

revoke references on table "public"."lyric_play_stats" from "service_role";

revoke select on table "public"."lyric_play_stats" from "service_role";

revoke trigger on table "public"."lyric_play_stats" from "service_role";

revoke truncate on table "public"."lyric_play_stats" from "service_role";

revoke update on table "public"."lyric_play_stats" from "service_role";

revoke delete on table "public"."lyrics" from "service_role";

revoke insert on table "public"."lyrics" from "service_role";

revoke references on table "public"."lyrics" from "service_role";

revoke select on table "public"."lyrics" from "service_role";

revoke trigger on table "public"."lyrics" from "service_role";

revoke truncate on table "public"."lyrics" from "service_role";

revoke update on table "public"."lyrics" from "service_role";

revoke delete on table "public"."user_roles" from "anon";

revoke insert on table "public"."user_roles" from "anon";

revoke references on table "public"."user_roles" from "anon";

revoke select on table "public"."user_roles" from "anon";

revoke trigger on table "public"."user_roles" from "anon";

revoke truncate on table "public"."user_roles" from "anon";

revoke update on table "public"."user_roles" from "anon";

revoke delete on table "public"."user_roles" from "authenticated";

revoke references on table "public"."user_roles" from "authenticated";

revoke trigger on table "public"."user_roles" from "authenticated";

revoke truncate on table "public"."user_roles" from "authenticated";

revoke delete on table "public"."user_roles" from "service_role";

revoke insert on table "public"."user_roles" from "service_role";

revoke references on table "public"."user_roles" from "service_role";

revoke select on table "public"."user_roles" from "service_role";

revoke trigger on table "public"."user_roles" from "service_role";

revoke truncate on table "public"."user_roles" from "service_role";

revoke update on table "public"."user_roles" from "service_role";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.is_admin()
 RETURNS boolean
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM user_roles 
    WHERE id = auth.uid() AND role = 'admin'
  );
$function$
;


  create policy "allow anon insert"
  on "public"."categories"
  as permissive
  for insert
  to anon
with check (true);



  create policy "allow anon insert"
  on "public"."lyrics"
  as permissive
  for insert
  to anon
with check (true);



  create policy "insert_own_role"
  on "public"."user_roles"
  as permissive
  for insert
  to authenticated
with check ((id = auth.uid()));



  create policy "select_own_role"
  on "public"."user_roles"
  as permissive
  for select
  to authenticated
using ((id = auth.uid()));



