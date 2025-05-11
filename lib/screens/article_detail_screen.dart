import 'package:flutter/material.dart';
import 'package:news_article/widgets/custom_app_bar.dart';
import '../models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Article article = ModalRoute.of(context)!.settings.arguments as Article;

    return Scaffold(
     appBar: buildAppBar('Article Detail'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  article.body,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  