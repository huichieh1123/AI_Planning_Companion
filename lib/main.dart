import 'package:flutter/material.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Trip App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A65FF)), // 類似你設計圖的藍色
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F6F8), // 淺灰背景
      ),
      routerConfig: appRouter,
    );
  }
}