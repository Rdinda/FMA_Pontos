-- =====================================================
-- Script SQL para Área Administrativa - FMA Pontos
-- Execute este script no Supabase SQL Editor
-- =====================================================

-- 1. Remover policies problemáticas existentes (se houver)
DROP POLICY IF EXISTS "Admins can read audit logs" ON audit_logs;
DROP POLICY IF EXISTS "Admins can update user roles" ON user_roles;
DROP POLICY IF EXISTS "Admins can read all user roles" ON user_roles;
DROP POLICY IF EXISTS "Users can read own role" ON user_roles;
DROP POLICY IF EXISTS "Users can insert own role" ON user_roles;
DROP POLICY IF EXISTS "Authenticated can read audit logs" ON audit_logs;
DROP POLICY IF EXISTS "Authenticated can read all user roles" ON user_roles;

-- 2. Tabela de logs de auditoria
CREATE TABLE IF NOT EXISTS audit_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  table_name TEXT NOT NULL,
  record_id TEXT NOT NULL,
  action TEXT NOT NULL CHECK (action IN ('INSERT', 'UPDATE', 'DELETE')),
  old_data JSONB,
  new_data JSONB,
  user_id UUID REFERENCES auth.users(id),
  user_email TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Índices para consultas eficientes
CREATE INDEX IF NOT EXISTS idx_audit_logs_table ON audit_logs(table_name);
CREATE INDEX IF NOT EXISTS idx_audit_logs_created ON audit_logs(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_audit_logs_user ON audit_logs(user_id);

-- 4. Campos adicionais na tabela user_roles (se não existirem)
ALTER TABLE user_roles ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true;
ALTER TABLE user_roles ADD COLUMN IF NOT EXISTS avatar_url TEXT;

-- 5. Função para verificar se usuário é admin (evita recursão em policies)
CREATE OR REPLACE FUNCTION is_admin(user_uuid UUID)
RETURNS BOOLEAN AS $$
DECLARE
  user_role TEXT;
BEGIN
  SELECT role INTO user_role FROM user_roles WHERE id = user_uuid;
  RETURN user_role = 'admin';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 6. Função genérica de auditoria (triggers)
CREATE OR REPLACE FUNCTION audit_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs (table_name, record_id, action, old_data, new_data, user_id, user_email)
  VALUES (
    TG_TABLE_NAME,
    COALESCE(NEW.id::text, OLD.id::text),
    TG_OP,
    CASE WHEN TG_OP IN ('UPDATE', 'DELETE') THEN to_jsonb(OLD) END,
    CASE WHEN TG_OP IN ('INSERT', 'UPDATE') THEN to_jsonb(NEW) END,
    auth.uid(),
    (SELECT email FROM auth.users WHERE id = auth.uid())
  );
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 7. Triggers para categories e lyrics
DROP TRIGGER IF EXISTS audit_categories ON categories;
CREATE TRIGGER audit_categories
AFTER INSERT OR UPDATE OR DELETE ON categories
FOR EACH ROW EXECUTE FUNCTION audit_trigger_func();

DROP TRIGGER IF EXISTS audit_lyrics ON lyrics;
CREATE TRIGGER audit_lyrics
AFTER INSERT OR UPDATE OR DELETE ON lyrics
FOR EACH ROW EXECUTE FUNCTION audit_trigger_func();

-- 8. Desabilitar RLS em audit_logs (mais simples e seguro)
ALTER TABLE audit_logs DISABLE ROW LEVEL SECURITY;

-- 9. Conceder permissões de leitura em audit_logs
GRANT SELECT ON audit_logs TO authenticated;
GRANT SELECT ON audit_logs TO anon;

-- 10. RLS para user_roles
ALTER TABLE user_roles ENABLE ROW LEVEL SECURITY;

-- Usuários podem ler sua própria role
CREATE POLICY "Users can read own role" ON user_roles
FOR SELECT USING (id = auth.uid());

-- Usuários podem inserir sua própria role (novos usuários)
CREATE POLICY "Users can insert own role" ON user_roles
FOR INSERT WITH CHECK (id = auth.uid());

-- Todos autenticados podem ler lista de usuários (para área admin)
CREATE POLICY "Authenticated can read all user roles" ON user_roles
FOR SELECT TO authenticated USING (true);

-- Admins podem atualizar roles (usa função SECURITY DEFINER)
CREATE POLICY "Admins can update user roles" ON user_roles
FOR UPDATE USING (is_admin(auth.uid()));

-- 11. Atualizar schema cache do PostgREST
NOTIFY pgrst, 'reload schema';

-- =====================================================
-- Script concluído! A área administrativa está pronta.
-- =====================================================
