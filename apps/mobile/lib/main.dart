import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/pages/Home.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S.E.A System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const HomePage(),
    );
  }
}
