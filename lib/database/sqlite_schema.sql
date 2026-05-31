-- SQLite Schema for FMA_Pontos
-- Local Mobile Database Definition and Migrations

-- ==========================================
-- CURRENT VERSION SCHEMA (Version 5)
-- Use this schema for fresh installations
-- ==========================================

-- Table: categories
-- Holds categories for the lyrics (e.g. Orixás, Entities)
CREATE TABLE IF NOT EXISTS categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  code TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  is_synced INTEGER NOT NULL DEFAULT 0,
  is_deleted INTEGER NOT NULL DEFAULT 0
);

-- Table: lyrics
-- Holds points / lyric contents, linked to a category, with offline flags
CREATE TABLE IF NOT EXISTS lyrics (
  id TEXT PRIMARY KEY,
  category_id TEXT NOT NULL,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  is_synced INTEGER NOT NULL DEFAULT 0,
  is_deleted INTEGER NOT NULL DEFAULT 0,
  audio_url TEXT,
  local_audio_path TEXT,
  youtube_link TEXT,
  sequence_number INTEGER NOT NULL DEFAULT 0
);

-- ==========================================
-- STEP-BY-STEP MIGRATIONS
-- Used when upgrading from previous versions
-- ==========================================

-- Version 1 (Initial Setup)
-- ------------------------------------------
-- CREATE TABLE categories (
--   id TEXT PRIMARY KEY,
--   name TEXT NOT NULL,
--   updated_at TEXT NOT NULL,
--   is_synced INTEGER NOT NULL DEFAULT 0,
--   is_deleted INTEGER NOT NULL DEFAULT 0
-- );
-- 
-- CREATE TABLE lyrics (
--   id TEXT PRIMARY KEY,
--   category_id TEXT NOT NULL,
--   title TEXT NOT NULL,
--   content TEXT NOT NULL,
--   updated_at TEXT NOT NULL,
--   is_synced INTEGER NOT NULL DEFAULT 0,
--   is_deleted INTEGER NOT NULL DEFAULT 0
-- );

-- Version 2
-- ------------------------------------------
-- ALTER TABLE lyrics ADD COLUMN audio_url TEXT;

-- Version 3
-- ------------------------------------------
-- ALTER TABLE lyrics ADD COLUMN local_audio_path TEXT;

-- Version 4
-- ------------------------------------------
-- ALTER TABLE lyrics ADD COLUMN youtube_link TEXT;

-- Version 5
-- ------------------------------------------
-- ALTER TABLE categories ADD COLUMN code TEXT;
-- UPDATE categories SET code = SUBSTR(name, 1, 2) WHERE code IS NULL;
-- ALTER TABLE lyrics ADD COLUMN sequence_number INTEGER NOT NULL DEFAULT 0;
