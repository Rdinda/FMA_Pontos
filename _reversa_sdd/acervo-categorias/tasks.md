# Acervo e Categorias — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 Dependências Flutter, Provider, sqflite, Supabase e uuid disponíveis conforme `pubspec.yaml`.
- [ ] 🟢 Schema local de `categories` compatível com `id`, `name`, `code`, `updated_at`, `is_synced`, `is_deleted`.
- [ ] 🟢 Schema remoto de `public.categories` compatível com `id`, `name`, `code`, `updated_at`, `is_deleted`.
- [ ] 🟢 RBAC `user/moderator/admin` disponível em `AuthService` e Supabase RLS.
- [ ] 🟡 Estratégia de erro para código duplicado definida, caso a implementação moderna queira melhorar o legado.

## Tarefas

- [ ] T-01, Implementar modelo `Category`
  - Origem no legado: `lib/models/category.dart`
  - Critério de pronto: o modelo deve conter `id`, `name`, `code`, `updatedAt`, `isSynced`, `isDeleted`, além de serialização local e remota equivalentes ao legado.
  - Confiança: 🟢

- [ ] T-02, Implementar tabela local `categories`
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: a tabela local deve aceitar `id TEXT PRIMARY KEY`, `name TEXT NOT NULL`, `code TEXT`, `updated_at TEXT`, `is_synced INTEGER DEFAULT 0`, `is_deleted INTEGER DEFAULT 0`.
  - Confiança: 🟢

- [ ] T-03, Implementar migração local para `code`
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: bancos antigos devem receber coluna `code` e preencher valor inicial com os dois primeiros caracteres de `name` quando `code` estiver nulo.
  - Confiança: 🟢

- [ ] T-04, Implementar DAO de leitura de categorias ativas
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: `readAllCategories()` deve retornar apenas `is_deleted = 0`, ordenado por `name ASC`.
  - Confiança: 🟢

- [ ] T-05, Implementar upsert local de categoria
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: `upsertCategory(category)` deve inserir/substituir por PK e garantir `is_deleted = 0` para registros ativos.
  - Confiança: 🟢

- [ ] T-06, Implementar soft delete local com cascade lógico
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: `softDeleteCategory(id)` deve marcar categoria e letras associadas com `is_deleted = 1`, `is_synced = 0`, `updated_at = now`.
  - Confiança: 🟢

- [ ] T-07, Implementar hard delete local com cascade físico
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: `hardDeleteCategory(id)` deve apagar letras por `category_id` e depois apagar a categoria.
  - Confiança: 🟢

- [ ] T-08, Implementar contrato remoto Supabase para categorias
  - Origem no legado: `lib/services/supabase_service.dart`
  - Critério de pronto: serviço deve suportar `fetchCategories({since})`, `upsertCategory(category)` e `deleteCategory(id)` com soft delete remoto.
  - Confiança: 🟢

- [ ] T-09, Implementar repository offline-first de categorias
  - Origem no legado: `lib/services/sync_repository.dart`
  - Critério de pronto: `addCategory`, `updateCategory`, `deleteCategory`, `getCategories`, `getCategory` e `getLyricsCount` devem operar localmente e tentar sync remoto quando online.
  - Confiança: 🟢

- [ ] T-10, Implementar permissions gate para criação de categoria
  - Origem no legado: `lib/screens/home_screen.dart`, `lib/services/auth_service.dart`
  - Critério de pronto: comando de criar categoria deve exigir `canAddCategories`; usuário sem permissão recebe feedback de login/role.
  - Confiança: 🟢

- [ ] T-11, Implementar diálogo de criação de categoria
  - Origem no legado: `lib/screens/home_screen.dart`
  - Critério de pronto: diálogo deve capturar nome e código, auto-sugerir código quando vazio, validar campos obrigatórios e chamar `addCategory`.
  - Confiança: 🟢

- [ ] T-12, Implementar listagem visual de categorias
  - Origem no legado: `lib/screens/home_screen.dart`
  - Critério de pronto: Home deve renderizar categorias, exibir nome capitalizado, contagem de pontos e navegar para detalhe da categoria.
  - Confiança: 🟢

- [ ] T-13, Implementar tela de categoria com ações protegidas
  - Origem no legado: `lib/screens/category_screen.dart`
  - Critério de pronto: tela deve exibir editar apenas para `canEditCategories` e excluir apenas para `canDeleteCategories`.
  - Confiança: 🟢

- [ ] T-14, Implementar edição de categoria
  - Origem no legado: `lib/screens/category_screen.dart`
  - Critério de pronto: ação editar deve abrir formulário com dados atuais, salvar `name`, `code.toUpperCase()`, `updatedAt = now` e chamar `updateCategory`.
  - Confiança: 🟢

- [ ] T-15, Implementar exclusão confirmada de categoria
  - Origem no legado: `lib/screens/category_screen.dart`
  - Critério de pronto: ação excluir deve pedir confirmação, chamar `deleteCategory(id)` e voltar para tela anterior.
  - Confiança: 🟢

- [ ] T-16, Implementar policies Supabase de categorias
  - Origem no legado: `supabase/supabase_schema.sql`
  - Critério de pronto: SELECT público, INSERT/UPDATE para `moderator` ou `admin`, DELETE para `admin`, bloqueando usuários anônimos em mutações.
  - Confiança: 🟢

- [ ] T-17, Implementar constraint/migration de código único
  - Origem no legado: `supabase/migrations/20260114120000_add_prefix_and_sequence.sql`
  - Critério de pronto: `categories.code` deve existir, ser não nulo e único no banco remoto.
  - Confiança: 🟢

- [ ] T-18, Definir tratamento de conflito de código duplicado na UI moderna
  - Origem no legado: lacuna em `_reversa_sdd/acervo-categorias/design.md`
  - Critério de pronto: comportamento para erro de constraint remota deve ser especificado e testado.
  - Confiança: 🟡

## Tarefas de Teste

- [ ] TT-01, Testar serialização local/remota de `Category`
  - Origem no legado: `lib/models/category.dart`
  - Critério de pronto: `toMap`, `toSupabaseMap` e `fromMap` preservam `id`, `name`, `code`, `updatedAt`, flags e defaults.
  - Confiança: 🟢

- [ ] TT-02, Testar listagem de categorias ativas
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: categorias com `is_deleted = 1` não aparecem e a ordenação é alfabética.
  - Confiança: 🟢

- [ ] TT-03, Testar criação offline
  - Origem no legado: `lib/services/sync_repository.dart`
  - Critério de pronto: com estado offline, `addCategory` persiste localmente, notifica listeners e não tenta falhar por rede.
  - Confiança: 🟢

- [ ] TT-04, Testar push online e marcação sincronizada
  - Origem no legado: `lib/services/sync_repository.dart`
  - Critério de pronto: com estado online e Supabase mockado com sucesso, categoria é enviada e marcada como sincronizada.
  - Confiança: 🟢

- [ ] TT-05, Testar soft delete com cascade lógico
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: ao excluir categoria, categoria e letras da categoria recebem `is_deleted = 1` e `is_synced = 0`.
  - Confiança: 🟢

- [ ] TT-06, Testar gates de permissão
  - Origem no legado: `lib/services/auth_service.dart`, `lib/screens/home_screen.dart`, `lib/screens/category_screen.dart`
  - Critério de pronto: anônimo/user não vê ações restritas; moderator vê criar/editar; admin vê criar/editar/excluir.
  - Confiança: 🟢

- [ ] TT-07, Testar validação de campos obrigatórios
  - Origem no legado: `lib/screens/home_screen.dart`
  - Critério de pronto: salvar com nome ou código vazio não chama repository e mostra feedback de erro.
  - Confiança: 🟢

- [ ] TT-08, Testar colisão de código
  - Origem no legado: `supabase/migrations/20260114120000_add_prefix_and_sequence.sql`
  - Critério de pronto: tentativa de salvar código duplicado recebe tratamento previsível.
  - Confiança: 🟡

## Tarefas de Migração de Dados

- [ ] TM-01, Migrar categorias existentes para conter `code`
  - Origem no legado: `lib/services/db_helper.dart`, `supabase/migrations/20260114120000_add_prefix_and_sequence.sql`
  - Critério de pronto: categorias antigas recebem `code` derivado ou revisado antes de impor `NOT NULL`.
  - Confiança: 🟢

- [ ] TM-02, Garantir unicidade de `code`
  - Origem no legado: `supabase/migrations/20260114120000_add_prefix_and_sequence.sql`
  - Critério de pronto: não há códigos duplicados antes de aplicar constraint única.
  - Confiança: 🟢

## Ordem Sugerida

1. Implementar `Category` e schema local/remoto, pois todo o fluxo depende deles.
2. Implementar DAO local e repository offline-first.
3. Implementar SupabaseService e policies.
4. Implementar UI de listagem/criação/edição/exclusão com gates RBAC.
5. Implementar testes de modelo, DAO e repository.
6. Implementar testes de UI/permissões.
7. Resolver tratamento amigável de código duplicado.

## Lacunas Pendentes (🔴)

- 🔴 Não há política explícita de resolução de conflito quando a mesma categoria é alterada localmente e remotamente antes do sync.
- 🟡 Tratamento de erro de `code` duplicado depende de decisão de UX/arquitetura da reimplementação.

