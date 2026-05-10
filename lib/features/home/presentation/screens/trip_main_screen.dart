import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_planning_companion/features/home/data/trip_data.dart';
import 'package:ai_planning_companion/features/home/domain/models/trip_info.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/screens/chat_tab_new.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/screens/itinerary_tab_new.dart';
import 'package:ai_planning_companion/features/trip_details/presentation/screens/tasks_tab_new.dart';
import 'package:ai_planning_companion/core/theme/app_colors.dart';

class TripMainScreen extends StatefulWidget {
  final String tripId;
  const TripMainScreen({super.key, required this.tripId});

  @override
  State<TripMainScreen> createState() => _TripMainScreenState();
}

class _TripMainScreenState extends State<TripMainScreen> {
  int _currentIndex = 1;
  late final TripInfo _trip;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _trip = tripSamples[widget.tripId] ?? tripSamples.values.first;
    _pages = [
      TasksTab(trip: _trip),
      ItineraryTab(trip: _trip),
      ChatTab(trip: _trip),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_trip.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(_trip.location, style: const TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.more_vert, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.04 * 255).round()),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatusBadge(_trip.status, _trip.statusColor),
                        Row(
                          children: [
                            const CircleAvatar(radius: 14, backgroundColor: AppColors.primary, child: Icon(Icons.person, size: 16, color: Colors.white)),
                            const SizedBox(width: 8),
                            Text(_trip.participants, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(_trip.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(_trip.description, style: const TextStyle(color: AppColors.textSecondary)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18, color: AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Text(_trip.dateRange, style: const TextStyle(color: AppColors.textSecondary)),
                        const SizedBox(width: 16),
                        const Icon(Icons.location_on, size: 18, color: AppColors.textSecondary),
                        const SizedBox(width: 8),
                        Text(_trip.location, style: const TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: _trip.highlights
                          .map((label) => Chip(
                                label: Text(label, style: const TextStyle(fontSize: 12)),
                                backgroundColor: AppColors.background,
                                side: BorderSide.none,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), label: '分工'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: '行程'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '討論'),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha((0.15 * 255).round()),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}
