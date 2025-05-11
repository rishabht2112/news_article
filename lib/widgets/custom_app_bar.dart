import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        letterSpacing: 0.5,
      ),
    ),
    backgroundColor: Colors.indigo.shade600,
    foregroundColor: Colors.white,
    elevation: 3,
    centerTitle: true,
  );
}
