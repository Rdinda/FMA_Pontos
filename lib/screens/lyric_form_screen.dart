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

  @override
  void initState() {
    super.initState();
    if (widget.lyric != null) {
      _titleController.text = widget.lyric!.title;
      _youtubeController.text = widget.lyric!.youtubeLink ?? '';
      _initContent(widget.lyric!.content);
      _audioUrl = widget.lyric!.audioUrl;
    }
  }

  void _initContent(String content) {
    try {
      // Try to parse as JSON (legacy Quill/SuperEditor format if any)
      // If it looks like JSON, we try to extract text.
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
    // Fallback: use content as is
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
      final result = await FilePicker.platform.pickFiles(type: FileType.audio);

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

            // Auto-save if editing
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

    // Validar se estamos editando (não criando) para atualizar o banco imediatamente
    if (widget.lyric != null) {
      try {
        final repo = Provider.of<SyncRepository>(context, listen: false);
        final updatedLyric = Lyric(
          id: widget.lyric!.id,
          categoryId: widget.categoryId,
          title: _titleController.text, // Mantém o título atual
          content: _contentController.text, // Mantém o conteúdo atual
          updatedAt: DateTime.now(),
          audioUrl: null, // Remove a URL do banco
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
    final title = _titleController.text;
    final content = _contentController.text;
    final youtubeUrl = _youtubeController.text.trim();

    if (title.isEmpty) return;

    if (youtubeUrl.isNotEmpty) {
      if (YoutubePlayer.convertUrlToId(youtubeUrl) == null) {
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
        isSynced: false, // Mark as unsynced
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
        title: const Text("Excluir"),
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
              Navigator.pop(context, true); // Return true to indicate deletion
            },
            child: const Text("Excluir", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lyric == null ? "Nova Letra" : "Editar Letra"),
        actions: [
          if (widget.lyric != null)
            IconButton(onPressed: _delete, icon: const Icon(Icons.delete)),
          IconButton(onPressed: _save, icon: const Icon(Icons.check)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
          ),
          // Audio Selection UI
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.audiotrack, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _audioUrl != null
                                ? "Áudio anexado"
                                : "Nenhum áudio selecionado",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (_isUploadingAudio)
                  const CircularProgressIndicator()
                else if (_audioUrl != null)
                  IconButton(
                    onPressed: _removeAudio,
                    icon: const Icon(Icons.close, color: Colors.red),
                    tooltip: "Remover áudio",
                  )
                else
                  ElevatedButton.icon(
                    onPressed: _pickAndUploadAudio,
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Anexar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6200EE),
                      elevation: 0,
                      side: BorderSide(color: Colors.grey.shade200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _youtubeController,
              decoration: const InputDecoration(
                labelText: "Link do YouTube",
                prefixIcon: Icon(Icons.video_library),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _contentController,
                expands: true,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  labelText: "Letra",
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
