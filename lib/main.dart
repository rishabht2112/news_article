import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/article_detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'providers/article_providers.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ArticleProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Articles',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routes: {
        '/': (_) => const HomeScreen(),
        '/details': (_) => ArticleDetailScreen(),
        '/favorites': (_) => FavoritesScreen(),
      },
    );
  }
}
