import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/audio_player_service.dart';
import '../utils/string_extensions.dart';
import '../utils/snackbar_utils.dart';
import '../widgets/streaming/streaming_scaffold.dart';
import '../widgets/streaming/streaming_navigation.dart';
import '../widgets/streaming/streaming_search_field.dart';
import '../widgets/streaming/category_card.dart';
import '../widgets/streaming/track_list_tile.dart';
import '../theme/streaming_tokens.dart';
import 'lyric_view_screen.dart';
import 'category_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Lyric> _results = [];
  List<Category> _categories = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final cats = await Provider.of<SyncRepository>(
      context,
      listen: false,
    ).getCategories();
    if (mounted) setState(() => _categories = cats);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
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

    return StreamingScaffold(
      navContext: StreamingNavContext.standard,
      currentNavIndex: StreamingNavIndex.search,
      appBar: const StreamingAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              'Buscar',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(StreamingTokens.spacingMd),
            child: StreamingSearchField(
              controller: _searchController,
              hintText: 'O que você quer ouvir?',
              onSubmitted: _performSearch,
              onClear: () {
                _searchController.clear();
                _onSearchChanged();
              },
            ),
          ),
          if (_isLoading)
            const LinearProgressIndicator(minHeight: 2)
          else
            const SizedBox(height: 4),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Provider.of<SyncRepository>(
                  context,
                  listen: false,
                ).syncData();
                await _loadCategories();
                if (_searchController.text.isNotEmpty) _performSearch();
              },
              child: _buildBody(colorScheme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ColorScheme colorScheme) {
    if (_errorMessage != null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          Center(
            child: Text(_errorMessage!, textAlign: TextAlign.center),
          ),
        ],
      );
    }

    if (_searchController.text.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Text(
            'Navegar por todas as categorias',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              return BentoCategoryCard(
                name: cat.name.capitalize(),
                index: index,
                category: cat,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(category: cat),
                    ),
                  );
                },
              );
            },
          ),
        ],
      );
    }

    if (!_isLoading && _results.isEmpty && _lastQuery.isNotEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          Center(
            child: Text('Nenhum ponto encontrado para "$_lastQuery"'),
          ),
        ],
      );
    }

    return Consumer<AudioPlayerService>(
      builder: (context, audioService, _) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _results.length,
          itemBuilder: (ctx, i) {
            final lyric = _results[i];
            final isCurrent = audioService.currentLyric?.id == lyric.id;
            final isPlaying = isCurrent && audioService.isPlaying;

            return TrackListTile(
              title: lyric.title.capitalize(),
              subtitle: lyric.content,
              isCurrent: isCurrent,
              isPlaying: isPlaying,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LyricViewScreen(lyric: lyric),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
