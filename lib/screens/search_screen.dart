import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/audio_player_service.dart';
import '../utils/string_extensions.dart';
import 'lyric_view_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Lyric> _results = [];
  bool _isLoading = false;

  void _performSearch() async {
    setState(() => _isLoading = true);
    final query = _searchController.text;
    if (query.isNotEmpty) {
      final results = await Provider.of<SyncRepository>(
        context,
        listen: false,
      ).searchLyrics(query);
      setState(() {
        _results = results;
        _isLoading = false;
      });
    } else {
      setState(() {
        _results = [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buscar Letras")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: "Pesquisar por nome ou trecho",
                prefixIcon: Icon(Icons.search),
                filled: true,
                // duplicate filled removed
                // fillColor: Color(0xFF2C2C2C), // Removed for light theme
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Provider.of<SyncRepository>(
                  context,
                  listen: false,
                ).syncData();
                if (_searchController.text.isNotEmpty) {
                  _performSearch();
                }
              },
              child: Consumer<AudioPlayerService>(
                builder: (context, audioService, child) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _results.length,
                    itemBuilder: (ctx, i) {
                      final lyric = _results[i];
                      final colorScheme = Theme.of(context).colorScheme;
                      final isPlaying =
                          audioService.currentLyric?.id == lyric.id &&
                          audioService.isPlaying;
                      final isCurrent =
                          audioService.currentLyric?.id == lyric.id;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? colorScheme.primaryContainer.withValues(
                                  alpha: 0.3,
                                )
                              : colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isCurrent
                                ? colorScheme.primary.withValues(alpha: 0.5)
                                : colorScheme.outlineVariant.withValues(
                                    alpha: 0.5,
                                  ),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isCurrent
                                  ? colorScheme.primary
                                  : colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: isPlaying
                                  ? Icon(
                                      Icons.graphic_eq,
                                      color: colorScheme.onPrimary,
                                    )
                                  : Icon(
                                      Icons.music_note,
                                      color: isCurrent
                                          ? colorScheme.onPrimary
                                          : colorScheme.onSurfaceVariant,
                                    ),
                            ),
                          ),
                          title: Text(
                            lyric.title.capitalize(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: isCurrent
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: isCurrent
                                  ? colorScheme.primary
                                  : colorScheme.onSurface,
                            ),
                          ),
                          subtitle: Text(
                            lyric.content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LyricViewScreen(lyric: lyric),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
