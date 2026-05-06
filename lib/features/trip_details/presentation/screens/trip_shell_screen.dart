import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TripShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const TripShellScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), label: '分工'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: '行程'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '討論'),
        ],
      ),
    );
  }
}