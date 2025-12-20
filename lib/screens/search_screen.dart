import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
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
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _results.length,
                itemBuilder: (ctx, i) {
                  final lyric = _results[i];
                  return ListTile(
                    title: Text(
                      lyric.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      lyric.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
