import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/supabase_service.dart';
import '../utils/snackbar_utils.dart';

class LyricFormScreen extends StatefulWidget {
  final String categoryId;
  final Lyric? lyric;

  const LyricFormScreen({super.key, required this.categoryId, this.lyric});

  @override
  State<LyricFormScreen> createState() => _LyricFormScreenState();
}

class _LyricFormScreenState extends State<LyricFormScreen> {
  final _titleController = TextEditingController();
  final _youtubeController = TextEditingController();
  final _contentController = TextEditingController();
  String? _audioUrl;
  bool _isUploadingAudio = false;

  String? _titleError;
  String? _contentError;
  String? _youtubeError;

  @override
  void initState() {
    super.initState();
    if (widget.lyric != null) {
      _titleController.text = widget.lyric!.title;
      _youtubeController.text = widget.lyric!.youtubeLink ?? '';
      _initContent(widget.lyric!.content);
      _audioUrl = widget.lyric!.audioUrl;
    }

    _titleController.addListener(() {
      if (_titleError != null && _titleController.text.trim().isNotEmpty) {
        setState(() {
          _titleError = null;
        });
      }
    });

    _contentController.addListener(() {
      if (_contentError != null && _contentController.text.trim().isNotEmpty) {
        setState(() {
          _contentError = null;
        });
      }
    });

    _youtubeController.addListener(() {
      if (_youtubeError != null) {
        setState(() {
          _youtubeError = null;
        });
      }
    });
  }

  void _initContent(String content) {
    try {
      if (content.trim().startsWith('[') || content.trim().startsWith('{')) {
        final dynamic json = jsonDecode(content);
        if (json is List) {
          final buffer = StringBuffer();
          for (var op in json) {
            if (op is Map && op.containsKey('insert')) {
              buffer.write(op['insert']);
            }
          }
          _contentController.text = buffer.toString();
          return;
        }
      }
    } catch (e) {
      // Ignore error, treat as plain text
    }
    _contentController.text = content;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _youtubeController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadAudio() async {
    try {
      final result = await FilePicker.pickFiles(type: FileType.audio);

      if (result != null && result.files.single.path != null) {
        setState(() {
          _isUploadingAudio = true;
        });

        final path = result.files.single.path!;
        final name = '${const Uuid().v4()}_${result.files.single.name}';

        final url = await SupabaseService().uploadAudio(path, name);

        if (mounted) {
          setState(() {
            _audioUrl = url;
            _isUploadingAudio = false;
          });
          if (url != null) {
            SnackbarUtils.show(context, message: 'Áudio enviado com sucesso!');

            if (widget.lyric != null) {
              try {
                final repo = Provider.of<SyncRepository>(
                  context,
                  listen: false,
                );
                final updatedLyric = Lyric(
                  id: widget.lyric!.id,
                  categoryId: widget.categoryId,
                  title: _titleController.text,
                  content: _contentController.text,
                  updatedAt: DateTime.now(),
                  audioUrl: _audioUrl,
                  isSynced: false,
                  youtubeLink: _youtubeController.text.trim().isEmpty
                      ? null
                      : _youtubeController.text.trim(),
                  sequenceNumber: widget.lyric!.sequenceNumber,
                );
                await repo.addLyric(updatedLyric);
              } catch (e) {
                debugPrint("Erro ao atualizar letra com áudio: $e");
              }
            }
          } else {
            SnackbarUtils.show(
              context,
              message: 'Erro ao enviar áudio.',
              isError: true,
            );
          }
        }
      }
    } catch (e) {
      debugPrint("Error picking audio: $e");
      if (mounted) {
        setState(() {
          _isUploadingAudio = false;
        });
        SnackbarUtils.show(
          context,
          message: 'Erro ao selecionar áudio: Verifique permissões.',
          isError: true,
        );
      }
    }
  }

  Future<void> _removeAudio() async {
    if (_audioUrl != null) {
      try {
        await SupabaseService().deleteAudioByUrl(_audioUrl!);
        if (mounted) {
          SnackbarUtils.show(
            context,
            message: 'Áudio removido do armazenamento.',
          );
        }
      } catch (e) {
        debugPrint("Error removing audio: $e");
      }
    }
    setState(() {
      _audioUrl = null;
    });

    if (!mounted) return;

    if (widget.lyric != null) {
      try {
        final repo = Provider.of<SyncRepository>(context, listen: false);
        final updatedLyric = Lyric(
          id: widget.lyric!.id,
          categoryId: widget.categoryId,
          title: _titleController.text,
          content: _contentController.text,
          updatedAt: DateTime.now(),
          audioUrl: null,
          isSynced: false,
          youtubeLink: _youtubeController.text.trim().isEmpty
              ? null
              : _youtubeController.text.trim(),
          sequenceNumber: widget.lyric!.sequenceNumber,
        );
        await repo.addLyric(updatedLyric);
      } catch (e) {
        debugPrint("Erro ao atualizar letra sem áudio: $e");
      }
    }
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final youtubeUrl = _youtubeController.text.trim();

    setState(() {
      _titleError = title.isEmpty ? "O título é obrigatório" : null;
      _contentError = content.isEmpty ? "A letra é obrigatória" : null;
      _youtubeError = null;
    });

    if (title.isEmpty || content.isEmpty) {
      SnackbarUtils.show(
        context,
        message: 'Preencha os campos obrigatórios.',
        isError: true,
      );
      return;
    }

    if (youtubeUrl.isNotEmpty) {
      if (YoutubePlayer.convertUrlToId(youtubeUrl) == null) {
        setState(() {
          _youtubeError = 'Link do YouTube inválido.';
        });
        SnackbarUtils.show(
          context,
          message: 'Link do YouTube inválido.',
          isError: true,
        );
        return;
      }
    }

    final repo = Provider.of<SyncRepository>(context, listen: false);

    if (widget.lyric == null) {
      final seqNum = await repo.getNextSequenceNumber(widget.categoryId);
      final newLyric = Lyric(
        id: const Uuid().v4(),
        categoryId: widget.categoryId,
        title: title,
        content: content,
        updatedAt: DateTime.now(),
        audioUrl: _audioUrl,
        youtubeLink: youtubeUrl.isEmpty ? null : youtubeUrl,
        sequenceNumber: seqNum,
      );
      repo.addLyric(newLyric);
    } else {
      final updatedLyric = Lyric(
        id: widget.lyric!.id,
        categoryId: widget.categoryId,
        title: title,
        content: content,
        updatedAt: DateTime.now(),
        audioUrl: _audioUrl,
        isSynced: false,
        youtubeLink: youtubeUrl.isEmpty ? null : youtubeUrl,
        sequenceNumber: widget.lyric!.sequenceNumber,
      );
      repo.addLyric(updatedLyric);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  void _delete() {
    if (widget.lyric == null) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Excluir",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        content: const Text("Tem certeza que deseja excluir esta letra?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<SyncRepository>(
                context,
                listen: false,
              ).deleteLyric(widget.lyric!.id);
              Navigator.pop(ctx);
              Navigator.pop(context, true);
            },
            child: const Text("Excluir", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.lyric == null ? "Nova Letra" : "Editar Letra",
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        actions: [
          if (widget.lyric != null)
            IconButton(
              onPressed: _delete,
              icon: const Icon(Icons.delete_outline),
              tooltip: "Excluir",
            ),
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.check),
            tooltip: "Salvar",
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: "Título",
                  labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerLow,
                  errorText: _titleError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.primary, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.error, width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerLow,
                        border: Border.all(color: colorScheme.outlineVariant),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.audiotrack,
                            color: _audioUrl != null ? colorScheme.primary : colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _audioUrl != null ? "Áudio anexado" : "Nenhum áudio selecionado",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: _audioUrl != null ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
                                fontWeight: _audioUrl != null ? FontWeight.w500 : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (_isUploadingAudio)
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2, color: colorScheme.primary),
                    )
                  else if (_audioUrl != null)
                    IconButton(
                      onPressed: _removeAudio,
                      icon: Icon(Icons.delete_outline, color: colorScheme.error),
                      tooltip: "Remover áudio",
                    )
                  else
                    ElevatedButton.icon(
                      onPressed: _pickAndUploadAudio,
                      icon: const Icon(Icons.upload_file_outlined),
                      label: Text(
                        "Anexar",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        foregroundColor: colorScheme.primary,
                        elevation: 0,
                        side: BorderSide(color: colorScheme.outlineVariant),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: _youtubeController,
                decoration: InputDecoration(
                  labelText: "Link do YouTube",
                  labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  prefixIcon: Icon(Icons.video_library_outlined, color: colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerLow,
                  errorText: _youtubeError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.primary, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.error, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  controller: _contentController,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    labelText: "Letra",
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerLow,
                    errorText: _contentError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colorScheme.outlineVariant),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colorScheme.outlineVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colorScheme.primary, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colorScheme.error),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colorScheme.error, width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

