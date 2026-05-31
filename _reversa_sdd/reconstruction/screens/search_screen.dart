import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/audio_player_service.dart';
import '../utils/string_extensions.dart';
import '../utils/snackbar_utils.dart';
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
  String? _errorMessage;
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    // Se o usuário limpar o campo, limpa os resultados imediatamente
    if (_searchController.text.isEmpty && _results.isNotEmpty) {
      setState(() {
        _results = [];
        _errorMessage = null;
        _lastQuery = '';
      });
    }
  }

  void _performSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _results = [];
        _errorMessage = null;
        _lastQuery = '';
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _lastQuery = query;
    });

    try {
      final results = await Provider.of<SyncRepository>(
        context,
        listen: false,
      ).searchLyrics(query);

      if (mounted) {
        setState(() {
          _results = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('[SearchScreen] Erro ao buscar pontos: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Ocorreu um erro ao realizar a busca local.';
          _results = [];
          _isLoading = false;
        });
        SnackbarUtils.show(
          context,
          message: 'Erro ao buscar dados locais: $e',
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar Pontos"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Pesquisar por nome ou trecho",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onSubmitted: (_) => _performSearch(),
              textInputAction: TextInputAction.search,
            ),
          ),
          if (_isLoading)
            const LinearProgressIndicator()
          else
            const SizedBox(height: 4),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                try {
                  await Provider.of<SyncRepository>(
                    context,
                    listen: false,
                  ).syncData();
                  if (_searchController.text.isNotEmpty) {
                    _performSearch();
                  }
                } catch (e) {
                  debugPrint('[SearchScreen] Erro no refresh: $e');
                  if (context.mounted) {
                    SnackbarUtils.show(
                      context,
                      message: 'Erro ao sincronizar dados: $e',
                      isError: true,
                    );
                  }
                }
              },
              child: _buildBody(colorScheme, mediaQuery),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ColorScheme colorScheme, MediaQueryData mediaQuery) {
    if (_errorMessage != null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: mediaQuery.size.height * 0.15),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 64,
                    color: colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _performSearch,
                    icon: const Icon(Icons.replay_rounded),
                    label: const Text('Tentar novamente'),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    if (_searchController.text.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: mediaQuery.size.height * 0.15),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.find_in_page_outlined,
                  size: 80,
                  color: colorScheme.outline.withValues(alpha: 0.4),
                ),
                const SizedBox(height: 16),
                Text(
                  "Digite um termo acima para iniciar a busca",
                  style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    if (!_isLoading && _results.isEmpty && _lastQuery.isNotEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: mediaQuery.size.height * 0.15),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    size: 80,
                    color: colorScheme.outline.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Nenhum ponto encontrado para \"$_lastQuery\"",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Verifique a ortografia ou tente outros termos.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Consumer<AudioPlayerService>(
      builder: (context, audioService, child) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _results.length,
          itemBuilder: (ctx, i) {
            final lyric = _results[i];
            final isPlaying =
                audioService.currentLyric?.id == lyric.id &&
                audioService.isPlaying;
            final isCurrent = audioService.currentLyric?.id == lyric.id;

            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
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
                            Icons.music_note_rounded,
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
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                    color: isCurrent ? colorScheme.primary : colorScheme.onSurface,
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
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
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
    );
  }
}
