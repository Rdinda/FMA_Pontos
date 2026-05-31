/// Enum que formaliza a máquina de estados de sincronização local de categorias e letras.
/// Descrito na seção "Estado de Sincronização Local" do documento `state-machines.md`.
enum LocalSyncStatus {
  /// Registro criado ou editado localmente que ainda não foi enviado ao Supabase.
  /// Critério: is_synced = 0, is_deleted = 0
  localDirty,

  /// Registro totalmente sincronizado com o Supabase.
  /// Critério: is_synced = 1, is_deleted = 0
  synced,

  /// Registro excluído localmente que aguarda sincronização de exclusão (soft delete) no Supabase.
  /// Critério: is_synced = 0, is_deleted = 1
  pendingDelete,

  /// Registro excluído fisicamente da base local (SQLite).
  removed,
}

/// Enum que formaliza o estado do player de mídia embutido na tela de letras.
/// Descrito na seção "Estado do Player da Tela de Letra" do documento `state-machines.md`.
enum PlayerMode {
  /// Nenhum player de mídia visível ou ativo.
  none,

  /// Player de áudio visível (reproduzindo áudio local ou remoto).
  audio,

  /// Player do YouTube ativo (reproduzindo vídeo).
  video,
}
