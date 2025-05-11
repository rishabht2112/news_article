import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  static const _url = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
