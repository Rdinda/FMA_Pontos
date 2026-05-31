import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/audio_player_service.dart';
import '../services/auth_service.dart';
import '../widgets/streaming/streaming_scaffold.dart';
import '../widgets/streaming/streaming_navigation.dart';
import '../widgets/streaming/track_list_tile.dart';
import '../theme/app_colors.dart';
import '../theme/streaming_tokens.dart';
import 'lyric_view_screen.dart';
import '../utils/snackbar_utils.dart';
import '../utils/string_extensions.dart';
class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool get _canEditCategory {
    return Provider.of<AuthService>(context, listen: false).canEditCategories;
  }

  bool get _canDeleteCategory {
    return Provider.of<AuthService>(context, listen: false).canDeleteCategories;
  }

  void _editCategory() {
    final nameController = TextEditingController(text: widget.category.name);
    final codeController = TextEditingController(text: widget.category.code);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Editar Categoria'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: 'Código (Prefixo)'),
              textCapitalization: TextCapitalization.characters,
              maxLength: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedCat = Category(
                id: widget.category.id,
                name: nameController.text.trim(),
                code: codeController.text.trim().toUpperCase(),
                updatedAt: DateTime.now(),
              );
              Provider.of<SyncRepository>(
                context,
                listen: false,
              ).updateCategory(updatedCat);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _deleteCategory() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Categoria?'),
        content: const Text('Isso excluirá todas as letras desta categoria.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<SyncRepository>(
                context,
                listen: false,
              ).deleteCategory(widget.category.id);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _playAllLyrics() async {
    final repo = Provider.of<SyncRepository>(context, listen: false);
    final audioService = Provider.of<AudioPlayerService>(
      context,
      listen: false,
    );

    final lyrics = await repo.getLyrics(widget.category.id);
    if (lyrics.isEmpty) {
      if (mounted) {
        SnackbarUtils.show(context, message: 'Nenhuma letra nesta categoria.');
      }
      return;
    }

    await audioService.playAll(lyrics);
  }

  String _formatTotalDuration(int count) {
    final mins = (count * 3).clamp(1, 999);
    return '$count pontos • $mins min';
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<SyncRepository>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return StreamingScaffold(
      navContext: StreamingNavContext.category,
      currentNavIndex: StreamingNavIndex.home,
      category: widget.category,
      onEditCategory: _editCategory,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: colorScheme.primary,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'FMA Pontos',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: colorScheme.primary,
          ),
        ),
        actions: [
          if (_canEditCategory)
            IconButton(onPressed: _editCategory, icon: const Icon(Icons.edit)),
          if (_canDeleteCategory)
            IconButton(onPressed: _deleteCategory, icon: const Icon(Icons.delete)),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Lyric>>(
        future: repo.getLyrics(widget.category.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final lyrics = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: () async => repo.syncData(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _CategoryHero(
                    categoryName: widget.category.name.capitalize(),
                    subtitle: lyrics.isEmpty
                        ? '0 pontos'
                        : _formatTotalDuration(lyrics.length),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: StreamingTokens.spacingMd,
                      vertical: StreamingTokens.spacingSm,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (_canEditCategory)
                              IconButton(
                                onPressed: _editCategory,
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            if (_canDeleteCategory)
                              IconButton(
                                onPressed: _deleteCategory,
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                          ],
                        ),
                        if (lyrics.isNotEmpty)
                          Material(
                            color: AppColors.primaryContainer,
                            shape: const CircleBorder(),
                            elevation: 8,
                            shadowColor: AppColors.primaryContainer.withValues(
                              alpha: 0.4,
                            ),
                            child: InkWell(
                              onTap: _playAllLyrics,
                              customBorder: const CircleBorder(),
                              child: const SizedBox(
                                width: 64,
                                height: 64,
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: AppColors.onPrimaryContainer,
                                  size: 36,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (lyrics.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text('Nenhuma letra nesta categoria.'),
                    ),
                  )
                else
                  Consumer<AudioPlayerService>(
                    builder: (context, audioService, _) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) {
                            final lyric = lyrics[i];
                            final isCurrent =
                                audioService.currentLyric?.id == lyric.id;
                            final isPlaying = isCurrent && audioService.isPlaying;
                            final hasAudio =
                                (lyric.audioUrl?.isNotEmpty ?? false) ||
                                (lyric.localAudioPath?.isNotEmpty ?? false);
                            final code =
                                '${widget.category.code}${lyric.sequenceNumber.toString().padLeft(2, '0')}';

                            return TrackListTile(
                              title: lyric.title.capitalize(),
                              subtitle: code,
                              trackNumber: i + 1,
                              isCurrent: isCurrent,
                              isPlaying: isPlaying,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        LyricViewScreen(lyric: lyric),
                                  ),
                                );
                              },
                              onPlay: hasAudio
                                  ? () {
                                      if (isPlaying) {
                                        audioService.pause();
                                      } else {
                                        audioService.play(lyric);
                                      }
                                    }
                                  : null,
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                onPressed: () {},
                              ),
                            );
                          },
                          childCount: lyrics.length,
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryHero extends StatelessWidget {
  final String categoryName;
  final String subtitle;

  const _CategoryHero({
    required this.categoryName,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryContainer.withValues(alpha: 0.4),
                  colorScheme.surfaceContainerHighest,
                ],
              ),
            ),
            child: Image.asset(
              'assets/images/main.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.5),
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  colorScheme.surface,
                  colorScheme.surface.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            left: 24,
            bottom: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryName,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -1,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 12)],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
