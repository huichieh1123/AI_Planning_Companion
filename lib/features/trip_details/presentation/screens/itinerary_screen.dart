import 'package:flutter/material.dart';
import 'package:ai_planning_companion/features/home/domain/models/trip_info.dart';
import 'package:ai_planning_companion/core/theme/app_colors.dart';

class ItineraryScreen extends StatelessWidget {
  final TripInfo trip;
  const ItineraryScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        Text('行程規劃', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        Text('共 ${trip.itinerary.length} 個活動', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 18),
        ...trip.itinerary.map((item) => _buildItineraryCard(item)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('行程備註', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('記得在出發前一天確認天氣與交通狀況。'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItineraryCard(ItineraryItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(item.icon, color: AppColors.primary),
        ),
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.subtitle),
        trailing: Text(item.time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ),
    );
  }
}
