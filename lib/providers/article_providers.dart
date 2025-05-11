import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';

class ArticleProvider extends ChangeNotifier {
  final List<Article> _allArticles = [];
  final List<Article> _visibleArticles = [];
  final List<Article> _favorites = [];
  final int _pageSize = 10;
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  String _searchQuery = '';

  List<Article> get articles => _visibleArticles;
  bool get isLoading => _isLoading;
  List<Article> get favorites => _favorites;

  ArticleProvider() {
    _loadFavoritesFromPrefs();
  }

  Future<void> fetchArticles({bool refresh = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    if (refresh) {
      _allArticles.clear();
      _visibleArticles.clear();
      _currentPage = 0;
      _hasMore = true;
    }

    try {
      if (_allArticles.isEmpty) {
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body) as List;
          _allArticles.addAll(data.map((json) => Article.fromJson(json)).toList());
          _loadFavoritesFromPrefs(); // match favorites again after articles load
        } else {
          throw Exception('Failed to fetch articles');
        }
      }
      _loadNextPage();
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _loadNextPage() {
    if (!_hasMore) return;

    final startIndex = _currentPage * _pageSize;
    final endIndex = startIndex + _pageSize;
    final newItems = _filteredArticles().skip(startIndex).take(_pageSize).toList();

    if (newItems.isEmpty) {
      _hasMore = false;
    } else {
      _visibleArticles.addAll(newItems);
      _currentPage++;
    }
  }

  void search(String query) {
    _searchQuery = query.toLowerCase();
    _visibleArticles.clear();
    _currentPage = 0;
    _hasMore = true;
    _loadNextPage();
    notifyListeners();
  }

  void loadMore() {
    if (!_isLoading && _hasMore) {
      _loadNextPage();
      notifyListeners();
    }
  }

  List<Article> _filteredArticles() {
    if (_searchQuery.isEmpty) return _allArticles;
    return _allArticles.where((article) {
      return article.title.toLowerCase().contains(_searchQuery) ||
          article.body.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  void toggleFavorite(Article article) {
    final exists = _favorites.any((a) => a.id == article.id);
    if (exists) {
      _favorites.removeWhere((a) => a.id == article.id);
    } else {
      _favorites.add(article);
    }
    _saveFavoritesToPrefs();
    notifyListeners();
  }

  bool isFavorite(Article article) => _favorites.any((a) => a.id == article.id);

  Future<void> _saveFavoritesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = _favorites.map((a) => a.id).toList();
    prefs.setString('favorites', jsonEncode(favoriteIds));
  }

  Future<void> _loadFavoritesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString('favorites');
    if (favoritesJson != null) {
      final ids = List<int>.from(jsonDecode(favoritesJson));
      _favorites.clear();
      _favorites.addAll(_allArticles.where((a) => ids.contains(a.id)));
      notifyListeners();
    }
  }
}
