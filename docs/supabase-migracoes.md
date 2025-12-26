## Supabase – Fluxo de migrações (cloud‑first)

Este projeto usa o **Supabase CLI** como fonte de verdade para o schema do banco, aplicando as migrações **diretamente na cloud**, sem stack local.

Diretório base: `c:\laravel\flutter\google\pontos`

---

### 1. Pré‑requisitos

- Supabase CLI instalado e acessível no PATH.
- Login já realizado:

```bash
supabase login
```

- Projeto já inicializado com `supabase/config.toml` (já feito neste repo).

---

### 2. Linkar este diretório ao projeto da cloud

Na raiz do projeto:

```bash
cd c:\laravel\flutter\google\pontos
supabase link --project-ref <PROJECT_REF>
```

- `<PROJECT_REF>` é o ID que aparece na URL do dashboard:
  - `https://supabase.com/dashboard/project/<PROJECT_REF>`
- Esse comando associa **este diretório** ao projeto remoto.  
  Todos os comandos `supabase db ...` passam a agir sobre esse projeto.

Se o projeto já estiver linkado e você quiser apenas revalidar:

```bash
supabase link
```

---

### 3. Sincronizar schema remoto → repositório (primeira vez)

Se você já criou tabelas/colunas direto pelo painel do Supabase, é preciso capturar esse estado atual em uma migração:

```bash
cd c:\laravel\flutter\google\pontos
supabase db pull
```

Esse comando:

- Conecta no banco remoto.
- Cria um banco shadow temporário.
- Gera uma migração em `supabase/migrations/*_remote_schema.sql` com o schema atual da cloud.
- Atualiza a tabela de histórico de migrações remota para refletir essa migração.

Depois disso, o repositório e a cloud passam a estar alinhados.

---

### 4. Criar uma nova migração (sempre a partir daqui)

Sempre que precisar alterar o schema (tabelas, colunas, índices, policies etc.):

1. Gerar o arquivo de migração:

```bash
cd c:\laravel\flutter\google\pontos
supabase migration new <nome_da_migracao>
```

Exemplo:

```bash
supabase migration new criar_tabela_usuarios
```

2. Editar o arquivo gerado em `supabase/migrations/` e escrever o SQL necessário.

Exemplo simples:

```sql
create table public.usuarios (
  id bigint primary key generated always as identity,
  nome text not null,
  email text unique not null,
  criado_em timestamptz default now()
);
```

---

### 5. Aplicar migrações diretamente na cloud

Depois de revisar o SQL da migração, aplicar no banco remoto:

```bash
cd c:\laravel\flutter\google\pontos
supabase db push
```

Isso:

- Verifica quais migrações em `supabase/migrations` ainda não foram aplicadas.
- Executa essas migrações diretamente no banco da cloud.

Se também quiser rodar o seed configurado em `supabase/seed.sql` no ambiente remoto:

```bash
supabase db push --include-seed
```

---

### 6. Fluxo recomendado (resumo)

1. Garantir login:
   - `supabase login`
2. Linkar ao projeto correto:
   - `supabase link --project-ref <PROJECT_REF>`
3. (Primeira vez) sincronizar schema remoto:
   - `supabase db pull`
4. Para cada mudança de schema:
   - `supabase migration new <descricao>`
   - editar o `.sql` em `supabase/migrations/...`
   - `supabase db push` (ou `db push --include-seed`)

Não é necessário usar `supabase start` para esse fluxo, já que o objetivo é operar **somente na cloud**.

---

### 7. Boas práticas

- Nunca editar diretamente o banco de produção pelo painel sem gerar migrações.  
  Se isso acontecer, rode `supabase db pull` para reconciliar.
- Manter os nomes de migração descritivos:
  - `YYYYMMDDHHMMSS_criar_tabela_x.sql`
  - `YYYYMMDDHHMMSS_adicionar_coluna_y_em_z.sql`
- Versionar sempre a pasta `supabase/` no controle de versão.

