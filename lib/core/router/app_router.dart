// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_planning_companion/features/home/presentation/screens/trip_main_screen.dart';
import 'package:ai_planning_companion/features/home/presentation/screens/home_screen.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    // 只需要這一個路由！把 tripId 傳給 TripMainScreen
    GoRoute(
      path: '/trip/:tripId',
      builder: (context, state) => TripMainScreen(
        tripId: state.pathParameters['tripId']!,
      ),
    ),
  ],
);