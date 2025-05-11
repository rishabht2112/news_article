import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_providers.dart';
import '../widgets/article_card.dart';
import '../widgets/artile_shimmer_card.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ArticleProvider>(context, listen: false);
    provider.fetchArticles();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        provider.loadMore();
      }
    });
  }

  Future<void> _onRefresh() async {
    final provider = Provider.of<ArticleProvider>(context, listen: false);
    await provider.fetchArticles(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);
    final articles = _selectedIndex == 0 ? provider.articles : provider.favorites;

    return Scaffold(
        appBar: buildAppBar("All Articles"),
      body: Column(
        children: [
          if (_selectedIndex == 0)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onChanged: (value) => provider.search(value),
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: provider.isLoading && articles.isEmpty
                  ? ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => const ArticleShimmerCard(),
              )
                  : ListView.builder(
                controller: _scrollController,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return ArticleCard(
                    index: index,
                    article: article,
                    isFavorite: provider.isFavorite(article),
                    onTap: () => Navigator.pushNamed(context, '/details', arguments: article),
                    onFavoriteToggle: () => provider.toggleFavorite(article),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Articles'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
