# Busca — Fluxos Operacionais

## Fluxo 1 — Busca local por título ou trecho

```mermaid
flowchart TD
  A["SearchScreen aberta"] --> B["Usuário digita query"]
  B --> C{"Query vazia?"}
  C -- "sim" --> D["_results = []"]
  C -- "não" --> E["_performSearch"]
  E --> F["SyncRepository.searchLyrics(query)"]
  F --> G["DatabaseHelper.searchLyrics"]
  G --> H["SQLite: title/content LIKE + is_deleted=0"]
  H --> I["ORDER BY title ASC"]
  I --> J["Renderizar ListView"]
  J --> K{"Usuário toca item?"}
  K -- "sim" --> L["Navigator.push LyricViewScreen"]
  K -- "não" --> J
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Busca apenas em dados SQLite locais (sem API remota direta).
- 🟢 **CONFIRMADO** — Letras com `is_deleted = 1` não entram nos resultados.
- 🟢 **CONFIRMADO** — Item em reprodução (`AudioPlayerService.currentLyric`) recebe destaque visual.
- 🟡 **INFERIDO** — Case-sensitivity do `LIKE` depende do collation SQLite do dispositivo.

## Fluxo 2 — Refresh com sincronização

```mermaid
flowchart TD
  A["Pull-to-refresh na SearchScreen"] --> B["SyncRepository.syncData()"]
  B --> C["PUSH/PULL + downloads"]
  C --> D{"Query atual não vazia?"}
  D -- "sim" --> E["_performSearch novamente"]
  D -- "não" --> F["Mantém lista vazia"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Refresh dispara sync completo antes de repetir a busca ativa.
- 🟢 **CONFIRMADO** — Busca não exige login Google (leitura local).
