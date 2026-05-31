import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/audio_player_service.dart';
import '../services/favorites_service.dart';
import '../services/sync_repository.dart';
import '../utils/snackbar_utils.dart';
import '../utils/string_extensions.dart';
import '../widgets/category_player_widget.dart';
import 'lyric_view_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Future<List<MapEntry<Lyric, Category>>>? _favoritesFuture;
  Set<String>? _lastFavoriteIds;

  Future<List<MapEntry<Lyric, Category>>> _loadFavoritesData(
    SyncRepository repo,
    Set<String> favoriteIds,
  ) async {
    if (favoriteIds.isEmpty) return [];

    final categories = await repo.getCategories();
    final categoryMap = {for (var c in categories) c.id: c};

    final List<MapEntry<Lyric, Category>> results = [];
    for (final id in favoriteIds) {
      final lyric = await repo.getLyric(id);
      if (lyric != null) {
        final category = categoryMap[lyric.categoryId];
        if (category != null) {
          results.add(MapEntry(lyric, category));
        }
      }
    }

    // Ordenar por título (case-insensitive)
    results.sort((a, b) =>
        a.key.title.toLowerCase().compareTo(b.key.title.toLowerCase()));
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<SyncRepository>(context, listen: false);
    final favService = Provider.of<FavoritesService>(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (_lastFavoriteIds == null ||
        !setEquals(_lastFavoriteIds, favService.favorites)) {
      _lastFavoriteIds = Set.from(favService.favorites);
      _favoritesFuture = _loadFavoritesData(repo, favService.favorites);
    }

    return FutureBuilder<List<MapEntry<Lyric, Category>>>(
      future: _favoritesFuture,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final data = snapshot.data ?? [];
        final playableLyrics = data
            .map((e) => e.key)
            .where((l) =>
                (l.audioUrl?.isNotEmpty ?? false) ||
                (l.localAudioPath?.isNotEmpty ?? false))
            .toList();

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Gostei",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: colorScheme.onSurface,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: colorScheme.onSurface),
            actions: [
              if (!isLoading && playableLyrics.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.play_circle_outline),
                  tooltip: 'Tocar Todas',
                  onPressed: () async {
                    final audioService = Provider.of<AudioPlayerService>(
                      context,
                      listen: false,
                    );
                    await audioService.playAll(playableLyrics);
                  },
                ),
            ],
          ),
          body: _buildBody(context, isLoading, data, favService),
          bottomSheet: const CategoryPlayerWidget(),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    bool isLoading,
    List<MapEntry<Lyric, Category>> data,
    FavoritesService favService,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    if (favService.favorites.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                size: 64,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                "Nenhum favorito ainda",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Suas músicas favoritas aparecerão aqui.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data.isEmpty) {
      // Significa que existem IDs salvos no FavoritesService, mas nenhum foi encontrado no SQLite.
      // Ou seja, todos os favoritos são órfãos (letras que foram deletadas do banco local).
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                "Nenhuma letra encontrada",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Suas letras favoritas podem ter sido removidas do banco de dados.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                icon: const Icon(Icons.clear_all),
                label: const Text("Limpar lista de favoritos"),
                onPressed: () async {
                  await favService.clearAll();
                  if (context.mounted) {
                    SnackbarUtils.show(
                      context,
                      message: 'Lista de favoritos limpa com sucesso.',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    }

    return Consumer<AudioPlayerService>(
      builder: (context, audioService, child) {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 80),
          itemCount: data.length,
          itemBuilder: (ctx, i) {
            final entry = data[i];
            final lyric = entry.key;
            final category = entry.value;

            return _buildMusicalLyricTile(
              context,
              lyric,
              category,
              audioService,
              favService,
            );
          },
        );
      },
    );
  }

  Widget _buildMusicalLyricTile(
    BuildContext context,
    Lyric lyric,
    Category category,
    AudioPlayerService audioService,
    FavoritesService favService,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPlaying =
        audioService.currentLyric?.id == lyric.id && audioService.isPlaying;
    final isCurrent = audioService.currentLyric?.id == lyric.id;
    final hasAudio =
        (lyric.audioUrl?.isNotEmpty ?? false) ||
        (lyric.localAudioPath?.isNotEmpty ?? false);
    final hasVideo = lyric.youtubeLink?.isNotEmpty ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isCurrent
            ? colorScheme.primaryContainer.withValues(alpha: 0.3)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrent
              ? colorScheme.primary.withValues(alpha: 0.5)
              : colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isCurrent
                ? colorScheme.primary
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              if (isCurrent)
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Center(
            child: isPlaying
                ? Icon(Icons.graphic_eq, color: colorScheme.onPrimary)
                : Text(
                    lyric.sequenceNumber.toString(),
                    style: TextStyle(
                      color: isCurrent
                          ? colorScheme.onPrimary
                          : colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
        title: Text(
          lyric.title.capitalize(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
            color: isCurrent ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
        subtitle: Row(
          children: [
            if (hasAudio) ...[
              Icon(Icons.music_note, size: 14, color: colorScheme.secondary),
              const SizedBox(width: 4),
            ],
            if (hasVideo) ...[
              Icon(Icons.videocam, size: 14, color: colorScheme.tertiary),
              const SizedBox(width: 4),
            ],
            Text(
              "${category.code}${lyric.sequenceNumber.toString().padLeft(2, '0')}",
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasAudio)
              IconButton(
                icon: Icon(
                  isCurrent && isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: colorScheme.primary,
                ),
                onPressed: () {
                  if (isCurrent && isPlaying) {
                    audioService.pause();
                  } else {
                    audioService.play(lyric);
                  }
                },
              ),
            IconButton(
              icon: const Icon(Icons.favorite),
              color: colorScheme.error,
              tooltip: 'Remover dos favoritos',
              onPressed: () async {
                await favService.removeFavorite(lyric.id);
                if (context.mounted) {
                  SnackbarUtils.show(
                    context,
                    message: 'Removido dos favoritos',
                  );
                }
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LyricViewScreen(lyric: lyric)),
          );
        },
      ),
    );
  }
}
