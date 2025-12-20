-- 1. Tabela de Categorias
CREATE TABLE IF NOT EXISTS public.categories (
    id text NOT NULL PRIMARY KEY,
    name text NOT NULL,
    updated_at timestamp with time zone NOT NULL DEFAULT now()
);

-- 2. Tabela de Letras (Lyrics)
CREATE TABLE IF NOT EXISTS public.lyrics (
    id text NOT NULL PRIMARY KEY,
    category_id text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    -- audio_url adicionado via ALTER abaixo para garantir migração
    
    CONSTRAINT lyrics_category_id_fkey 
        FOREIGN KEY (category_id) 
        REFERENCES public.categories(id)
        ON DELETE CASCADE
);

-- Migração: Adicionar coluna audio_url se não existir
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='lyrics' AND column_name='audio_url') THEN
        ALTER TABLE public.lyrics ADD COLUMN audio_url text;
    END IF;
END $$;

-- Restrição: Permitir apenas arquivos MP3 (verifica a extensão na URL)
ALTER TABLE public.lyrics DROP CONSTRAINT IF EXISTS check_audio_mp3;
ALTER TABLE public.lyrics ADD CONSTRAINT check_audio_mp3 CHECK (audio_url IS NULL OR audio_url ILIKE '%.mp3');

-- Índices
CREATE INDEX IF NOT EXISTS idx_lyrics_category_id ON public.lyrics(category_id);

-- Permissões (RLS)
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lyrics ENABLE ROW LEVEL SECURITY;

-- Políticas de Acesso (Drop antes de criar para evitar erro de duplicidade)
DROP POLICY IF EXISTS "Public Access Categories" ON public.categories;
CREATE POLICY "Public Access Categories" ON public.categories FOR ALL USING (true);

DROP POLICY IF EXISTS "Public Access Lyrics" ON public.lyrics;
CREATE POLICY "Public Access Lyrics" ON public.lyrics FOR ALL USING (true);


-- 3. Configuração do Storage (Bucket 'audio')
-- Garante que o bucket existe
INSERT INTO storage.buckets (id, name, public) 
VALUES ('audio', 'audio', true)
ON CONFLICT (id) DO NOTHING;

-- Políticas de Storage para o bucket 'audio'

-- Política: Upload (apenas MP3)
DROP POLICY IF EXISTS "Upload MP3 Only" ON storage.objects;
CREATE POLICY "Upload MP3 Only" ON storage.objects
FOR INSERT TO public
WITH CHECK (bucket_id = 'audio' AND name ILIKE '%.mp3');

-- Política: Select (Público)
DROP POLICY IF EXISTS "Public Select Audio" ON storage.objects;
CREATE POLICY "Public Select Audio" ON storage.objects
FOR SELECT TO public
USING (bucket_id = 'audio');

-- Política: Update/Delete (Público - ou restrinja conforme necessidade)
DROP POLICY IF EXISTS "Public Manage Audio" ON storage.objects;
CREATE POLICY "Public Manage Audio" ON storage.objects
FOR ALL TO public
USING (bucket_id = 'audio');
