begin;

delete from public.lyrics
where category_id in (
  'd582c002-c509-4160-8663-af1a5fe01d96',
  'c5dfb335-d0fe-441b-90fb-0e44e738e6ad',
  '8e182b4b-1b3d-45a1-a2e7-64d3f805ff72',
  'd4376d52-dcfc-43b6-9a17-da848efe981c',
  'ac24acca-ce30-44e2-975f-3a07120ac5e2',
  'a5a06a94-cd62-41f4-aed9-d776747a8e62',
  'cbd01d65-e035-4011-bb5a-befad4a8746e',
  'e53d426c-5f17-4e02-b74e-4fff950b20f6',
  '7ea8ec81-de50-4c38-8d09-15e837fb3397'
);

delete from public.categories
where id in (
  'd582c002-c509-4160-8663-af1a5fe01d96',
  'c5dfb335-d0fe-441b-90fb-0e44e738e6ad',
  '8e182b4b-1b3d-45a1-a2e7-64d3f805ff72',
  'd4376d52-dcfc-43b6-9a17-da848efe981c',
  'ac24acca-ce30-44e2-975f-3a07120ac5e2',
  'a5a06a94-cd62-41f4-aed9-d776747a8e62',
  'cbd01d65-e035-4011-bb5a-befad4a8746e',
  'e53d426c-5f17-4e02-b74e-4fff950b20f6',
  '7ea8ec81-de50-4c38-8d09-15e837fb3397'
);

commit;
