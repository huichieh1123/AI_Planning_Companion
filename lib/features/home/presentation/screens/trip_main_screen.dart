import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_planning_companion/core/theme/app_colors.dart';
import 'package:ai_planning_companion/features/home/data/trip_data.dart';
import 'package:ai_planning_companion/features/home/domain/models/trip_info.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/screens/discussion_screen.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/screens/itinerary_screen.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/screens/tasks_screen.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/providers/tasks_provider.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/providers/itinerary_provider.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/providers/discussion_provider.dart';

class TripMainScreen extends StatefulWidget {
  final String tripId;
  const TripMainScreen({super.key, required this.tripId});

  @override
  State<TripMainScreen> createState() => _TripMainScreenState();
}

class _TripMainScreenState extends State<TripMainScreen> {
  int _currentIndex = 1; 
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ChangeNotifierProvider(
        create: (_) => TasksProvider(tripId: widget.tripId),
        child: TasksScreen(tripId: widget.tripId),
      ),
      ChangeNotifierProvider(
        create: (_) => ItineraryProvider(tripId: widget.tripId),
        child: ItineraryScreen(tripId: widget.tripId),
      ),
      ChangeNotifierProvider(
        create: (_) => DiscussionProvider(tripId: widget.tripId),
        child: DiscussionScreen(tripId: widget.tripId),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final trip = tripSamples[widget.tripId] ?? tripSamples['1']!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildStickyHeader(trip),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.surface,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), activeIcon: Icon(Icons.people_alt), label: '分工'),
            BottomNavigationBarItem(icon: Icon(Icons.map_outlined), activeIcon: Icon(Icons.map), label: '行程'),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: '討論'),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyHeader(TripInfo trip) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.only(top: 4, right: 12),
                  child: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.textPrimary),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          '${trip.dateRange} · ${trip.participants.replaceAll(' 人參與', '人')}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.tag, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        const Text(
                          '活動代碼: XJ92KQ',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.copy, size: 12, color: AppColors.primary),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.timer_outlined, size: 14, color: AppColors.textSecondary),
                    SizedBox(width: 4),
                    Text('行前模式', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
