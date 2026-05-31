# Acervo e Categorias — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre a listagem, criação, edição, exclusão lógica e navegação de categorias do acervo de pontos.  
🟢 **CONFIRMADO** — Categorias agrupam letras/pontos, possuem código curto e são armazenadas localmente em SQLite com sincronização para Supabase.  
🟡 **INFERIDO** — A finalidade de `code` + `sequence_number` é criar referências legíveis como `OX01` para estudo e organização do acervo.

## Responsabilidades

- 🟢 **CONFIRMADO** — Listar categorias não excluídas, ordenadas por nome.
- 🟢 **CONFIRMADO** — Exibir a quantidade de pontos por categoria.
- 🟢 **CONFIRMADO** — Criar categoria com `name`, `code`, `id` UUID e `updatedAt`.
- 🟢 **CONFIRMADO** — Sugerir código de categoria a partir dos dois primeiros caracteres do nome quando o campo de código está vazio.
- 🟢 **CONFIRMADO** — Permitir edição de categoria para moderadores e administradores.
- 🟢 **CONFIRMADO** — Permitir exclusão de categoria apenas para administradores.
- 🟢 **CONFIRMADO** — Ao excluir categoria, marcar a categoria e suas letras associadas como excluídas localmente para sincronização posterior.
- 🟢 **CONFIRMADO** — Navegar de uma categoria para a lista de letras associadas.

## Regras de Negócio

- 🟢 **CONFIRMADO** — Categoria exige `name` e `code`.
- 🟢 **CONFIRMADO** — Categorias visíveis devem atender `is_deleted = 0`.
- 🟢 **CONFIRMADO** — Categorias devem ser ordenadas por `name ASC` na leitura local.
- 🟢 **CONFIRMADO** — O campo `code` é convertido para maiúsculas ao criar/editar pela UI.
- 🟢 **CONFIRMADO** — O código sugerido usa até os dois primeiros caracteres do nome digitado.
- 🟢 **CONFIRMADO** — `moderator` e `admin` podem adicionar e editar categorias.
- 🟢 **CONFIRMADO** — Apenas `admin` pode excluir categorias.
- 🟢 **CONFIRMADO** — Excluir categoria também marca todas as letras da categoria como `is_deleted = 1` e `is_synced = 0`.
- 🟢 **CONFIRMADO** — No Supabase, `categories.code` é `NOT NULL UNIQUE` — definido em `supabase/migrations/20251226191350_initial_schema.sql` (schema consolidado).
- 🟢 **CONFIRMADO** — `supabase/seed.sql` popula `code` explicitamente por categoria (ex.: Caboclos → `CA`, Obá → `OB1`).
- 🟡 **INFERIDO** — Colisão de código deve ser tratada pelo backend remoto via constraint, mas a UI atual não valida unicidade antes do save.

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O sistema deve listar todas as categorias locais não excluídas. | Must | Dado SQLite com categorias ativas e excluídas, quando a Home carregar, então apenas categorias com `is_deleted = 0` aparecem. |
| RF-02 | 🟢 O sistema deve ordenar categorias por nome ascendente. | Must | Dado múltiplas categorias, quando `readAllCategories()` for chamado, então o resultado vem ordenado por `name ASC`. |
| RF-03 | 🟢 O sistema deve exibir a contagem de letras de cada categoria. | Should | Dado uma categoria, quando renderizada na Home, então a UI consulta `getLyricsCount(category.id)` e exibe `ponto/pontos`. |
| RF-04 | 🟢 O sistema deve criar categoria com UUID, nome, código e data de atualização. | Must | Dado nome e código preenchidos, quando o usuário salva, então `SyncRepository.addCategory()` recebe uma `Category` com `Uuid().v4()` e `DateTime.now()`. |
| RF-05 | 🟢 O sistema deve sugerir automaticamente código se o campo estiver vazio. | Should | Dado campo de código vazio, quando o usuário digita nome, então os dois primeiros caracteres do nome preenchem o código em maiúsculas. |
| RF-06 | 🟢 O sistema deve bloquear criação de categoria sem nome ou código. | Must | Dado nome ou código vazio, quando o usuário tenta salvar, então a categoria não é criada e aparece snackbar de erro. |
| RF-07 | 🟢 O sistema deve permitir edição de categoria para `moderator` ou `admin`. | Must | Dado usuário com `canEditCategories`, quando acessa a tela da categoria, então o botão editar fica disponível e salva a alteração. |
| RF-08 | 🟢 O sistema deve impedir edição de categoria para anônimo ou `user`. | Must | Dado usuário sem `canEditCategories`, quando acessa a tela, então o botão de editar não é exibido. |
| RF-09 | 🟢 O sistema deve permitir exclusão de categoria apenas para `admin`. | Must | Dado usuário com `canDeleteCategories`, quando confirma exclusão, então `deleteCategory(id)` é chamado. |
| RF-10 | 🟢 O sistema deve excluir logicamente categoria e letras associadas antes de sync. | Must | Dado uma categoria com letras, quando `softDeleteCategory(id)` executa, então categoria e letras recebem `is_deleted = 1`, `is_synced = 0`, `updated_at = now`. |
| RF-11 | 🟢 O sistema deve remover fisicamente categoria e letras após exclusão remota bem-sucedida. | Should | Dado sync online e delete remoto concluído, quando `hardDeleteCategory(id)` executa, então letras da categoria e categoria são removidas do SQLite. |
| RF-12 | 🟢 O sistema deve abrir a tela de letras ao tocar em uma categoria. | Must | Dado uma categoria na Home, quando o usuário toca nela, então navega para `CategoryScreen(category)`. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Segurança | Mutação de categorias deve respeitar RBAC no app e Supabase RLS. | `lib/services/auth_service.dart`, `supabase/supabase_schema.sql` | 🟢 |
| Consistência | Exclusão de categoria deve também excluir logicamente as letras associadas. | `lib/services/db_helper.dart` | 🟢 |
| Operação offline | Criação/edição/exclusão local deve funcionar antes da sincronização remota. | `lib/services/sync_repository.dart`, `lib/services/db_helper.dart` | 🟢 |
| Integridade | Código de categoria deve ser único e não nulo no banco remoto. | `supabase/migrations/20251226191350_initial_schema.sql` | 🟢 |
| Usabilidade | Categorias devem exibir contagem de pontos e feedback visual de lista. | `lib/screens/home_screen.dart` | 🟢 |

## Critérios de Aceitação

```gherkin
Dado que existem categorias ativas e excluídas no SQLite
Quando a tela inicial carregar a lista de categorias
Então somente categorias com is_deleted igual a 0 devem ser exibidas

Dado que o usuário tem role moderator ou admin
Quando ele informa nome e código de uma nova categoria e salva
Então a categoria deve ser criada localmente com is_synced igual a 0 e aparecer na lista

Dado que o campo código está vazio
Quando o usuário digita um nome de categoria com pelo menos dois caracteres
Então o sistema deve sugerir os dois primeiros caracteres em maiúsculas como código

Dado que o usuário é anônimo ou tem apenas role user
Quando ele tenta acessar ações de criação ou edição de categoria
Então o sistema deve bloquear a ação ou ocultar o comando correspondente

Dado que o usuário é admin
Quando ele confirma a exclusão de uma categoria
Então a categoria e suas letras associadas devem ser marcadas como excluídas localmente

Dado que a sincronização online conclui uma exclusão de categoria
Quando o delete remoto retorna sucesso
Então a categoria e suas letras associadas devem ser removidas fisicamente do SQLite
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Listar categorias ativas | Must | 🟢 Caminho crítico da Home e entrada principal do acervo. |
| Criar categoria | Must | 🟢 Necessário para manutenção do acervo por moderador/admin. |
| Editar categoria | Must | 🟢 Necessário para correção de nome/código. |
| Excluir categoria com cascade lógico | Must | 🟢 Regra crítica para preservar sync e consistência. |
| Contagem de pontos por categoria | Should | 🟢 Melhora navegação, mas o acervo ainda funciona sem a contagem. |
| Código auto-sugerido | Should | 🟢 Facilita cadastro, mas o usuário pode preencher manualmente. |
| Validação prévia de unicidade de código na UI | Could | 🟡 Unicidade é garantida remotamente, mas a UI não antecipa conflito. |
| Excluir categoria por usuário comum | Won't | 🟢 Bloqueado por RBAC; apenas admin pode excluir. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/models/category.dart` | `Category`, `toMap`, `toSupabaseMap`, `fromMap` | 🟢 |
| `lib/services/db_helper.dart` | `readAllCategories`, `upsertCategory`, `softDeleteCategory`, `hardDeleteCategory`, `getLyricsCount` via repository | 🟢 |
| `lib/services/sync_repository.dart` | `addCategory`, `updateCategory`, `deleteCategory`, `getCategories`, `getLyricsCount` | 🟢 |
| `lib/services/supabase_service.dart` | `upsertCategory`, `deleteCategory`, `fetchCategories` | 🟢 |
| `lib/screens/home_screen.dart` | `_showAddCategoryDialog`, listagem e navegação de categorias | 🟢 |
| `lib/screens/category_screen.dart` | `_editCategory`, `_deleteCategory`, permissões de edição/exclusão | 🟢 |
| `lib/services/auth_service.dart` | `canAddCategories`, `canEditCategories`, `canDeleteCategories` | 🟢 |
| `supabase/supabase_schema.sql` | policies de `categories`, função `has_role` | 🟢 |
| `supabase/migrations/20251226191350_initial_schema.sql` | Schema consolidado: `categories.code` NOT NULL UNIQUE, `lyrics.sequence_number`, RLS, audit | 🟢 |
| `supabase/seed.sql` | Seed com `code` por categoria (obrigatório pós-NOT NULL) | 🟢 |
| `supabase/migrations/20260114120000_add_prefix_and_sequence.sql` | Migration incremental legada (coexiste; ver re-extração 2026-05-21) | 🟡 |

