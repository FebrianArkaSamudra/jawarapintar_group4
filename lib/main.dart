import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jawara Pintar',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MyHomePage(),
    );
  }
}
