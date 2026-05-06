import 'package:flutter/material.dart';

import 'package:ai_planning_companion/features/trip_details/presentation/screens/discussion_screen.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/screens/itinerary_screen.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/screens/tasks_screen.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/screens/trip_shell_screen.dart';


class TripMainScreen extends StatefulWidget {
  final String tripId;
  const TripMainScreen({super.key, required this.tripId});

  @override
  State<TripMainScreen> createState() => _TripMainScreenState();
}

class _TripMainScreenState extends State<TripMainScreen> {
  // 預設選擇 Index 1 (對應中間的 P2 行程頁面)
  int _currentIndex = 1; 

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // 初始化三個子頁面，並將 tripId 傳遞給它們
    _pages = [
      TasksScreen(tripId: widget.tripId),      // Index 0
      ItineraryScreen(tripId: widget.tripId),  // Index 1
      DiscussionScreen(tripId: widget.tripId), // Index 2
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用 IndexedStack 可以把所有頁面「疊」起來，切換時不會銷毀先前的狀態
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 點擊時更新當前選中的 Tab
          });
        },
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