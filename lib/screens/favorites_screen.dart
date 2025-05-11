import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_providers.dart';
import '../widgets/article_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: provider.favorites.isEmpty
          ? const Center(child: Text('No favorites yet.'))
          : ListView.builder(
        itemCount: provider.favorites.length,
        itemBuilder: (context, index) {
          final article = provider.favorites[index];
          return ArticleCard(
            index: index,
            article: article,
            isFavorite: provider.isFavorite(article),
            onFavoriteToggle: () => provider.toggleFavorite(article),
            onTap: () => Navigator.pushNamed(context, '/details', arguments: article),
          );
        },
      ),
    );
  }
}
