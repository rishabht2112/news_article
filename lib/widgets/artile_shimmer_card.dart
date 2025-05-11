import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArticleShimmerCard extends StatelessWidget {
  const ArticleShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20, width: double.infinity, color: Colors.white),
            const SizedBox(height: 8),
            Container(height: 16, width: double.infinity, color: Colors.white),
            const SizedBox(height: 8),
            Container(height: 16, width: double.infinity, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
