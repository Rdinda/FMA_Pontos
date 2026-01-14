-- 1. Add code to categories
ALTER TABLE public.categories ADD COLUMN IF NOT EXISTS code text;

-- 2. Populate code for existing categories
DO $$
DECLARE
    r RECORD;
    new_code text;
    counter integer;
BEGIN
    FOR r IN SELECT * FROM public.categories WHERE code IS NULL LOOP
        -- Generate initial code (first 2 letters)
        -- Remove accents/special chars if possible, but basic substring is fine for now
        new_code := UPPER(SUBSTRING(r.name FROM 1 FOR 2));
        
        -- Check if exists
        IF EXISTS (SELECT 1 FROM public.categories WHERE code = new_code) THEN
            -- Try appending a number
            counter := 1;
            WHILE EXISTS (SELECT 1 FROM public.categories WHERE code = new_code || counter::text) LOOP
                counter := counter + 1;
            END LOOP;
            new_code := new_code || counter::text;
        END IF;
        
        UPDATE public.categories SET code = new_code WHERE id = r.id;
    END LOOP;
END $$;

-- Add unique constraint
ALTER TABLE public.categories ADD CONSTRAINT categories_code_key UNIQUE (code);
ALTER TABLE public.categories ALTER COLUMN code SET NOT NULL;


-- 3. Add sequence_number to lyrics
ALTER TABLE public.lyrics ADD COLUMN IF NOT EXISTS sequence_number integer;

-- 4. Populate sequence_number
WITH numbered_lyrics AS (
    SELECT 
        id, 
        ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY updated_at ASC, title ASC) as rn
    FROM public.lyrics
)
UPDATE public.lyrics
SET sequence_number = numbered_lyrics.rn
FROM numbered_lyrics
WHERE public.lyrics.id = numbered_lyrics.id;

ALTER TABLE public.lyrics ALTER COLUMN sequence_number SET DEFAULT 0;
ALTER TABLE public.lyrics ALTER COLUMN sequence_number SET NOT NULL;

-- 5. Create function to get next sequence
CREATE OR REPLACE FUNCTION public.get_next_lyric_sequence(cat_id text)
RETURNS integer AS $$
DECLARE
    max_seq integer;
BEGIN
    SELECT COALESCE(MAX(sequence_number), 0) INTO max_seq
    FROM public.lyrics
    WHERE category_id = cat_id;
    
    RETURN max_seq + 1;
END;
$$ LANGUAGE plpgsql;
