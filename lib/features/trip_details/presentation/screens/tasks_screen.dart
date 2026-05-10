import 'package:flutter/material.dart';
import 'package:ai_planning_companion/features/home/domain/models/trip_info.dart';
import 'package:ai_planning_companion/core/theme/app_colors.dart';

class TasksScreen extends StatelessWidget {
  final TripInfo trip;
  const TasksScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final completeCount = trip.tasks.where((task) => task.completed).length;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        Text('任務分工', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        Text('已完成 $completeCount / ${trip.tasks.length} 項', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 18),
        ...trip.tasks.map((item) => _buildTaskCard(item)),
        const SizedBox(height: 24),
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
              Text('建議小提醒', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('用 AI 自動整理任務清單，減少溝通等待。'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(TaskItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: item.completed ? AppColors.primary : AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: item.completed ? AppColors.primary : AppColors.textSecondary),
            ),
            child: item.completed ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(item.subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
