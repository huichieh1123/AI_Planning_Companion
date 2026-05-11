import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/api/index.dart';
import 'core/services/index.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ITripApi>(
          create: (_) => ApiConfig.useMock ? MockTripApi() : TripApi(baseUrl: ApiConfig.baseUrl),
        ),
        ProxyProvider<ITripApi, TripService>(
          update: (_, api, __) => TripService(api: api),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Trip App',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}

