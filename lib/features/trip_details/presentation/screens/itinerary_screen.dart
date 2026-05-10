import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_planning_companion/core/theme/app_colors.dart';
import '../providers/itinerary_provider.dart';
import '../../domain/models/itinerary_item_model.dart';

class ItineraryScreen extends StatelessWidget {
  final String tripId;
  const ItineraryScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ItineraryProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildDayTabs(provider),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    itemCount: provider.itineraryItems.length,
                    itemBuilder: (context, index) {
                      final item = provider.itineraryItems[index];
                      if (item.type == ItineraryItemType.spacer) {
                        return _buildTimelineSpacer(item.label ?? '');
                      } else if (item.type == ItineraryItemType.button) {
                        return _buildAiInsertButton();
                      } else {
                        return _buildTimelineItem(
                          context: context,
                          provider: provider,
                          item: item,
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDayTabs(ItineraryProvider provider) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(provider.days.length, (index) {
          final isSelected = index == provider.selectedDayIndex;
          return GestureDetector(
            onTap: () => provider.selectDay(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.textPrimary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                provider.days[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTimelineItem({
    required BuildContext context,
    required ItineraryProvider provider,
    required ItineraryItemModel item,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Column(
            children: [
              Text(item.time ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 100, // Fixed height for demo
                color: AppColors.border,
              ),
            ],
          ),
        ),
        Expanded(
          child: Dismissible(
            key: Key(item.id),
            direction: DismissDirection.horizontal,
            background: Container(
              margin: const EdgeInsets.only(bottom: 16, left: 8),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.delete_outline, color: Colors.white),
                  Icon(Icons.delete_outline, color: Colors.white),
                ],
              ),
            ),
            onDismissed: (_) {
              provider.deleteItem(item);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('已刪除行程：${item.title}'), duration: const Duration(seconds: 2)),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16, left: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.assignee != null) ...[
                    Row(
                      children: [
                        const Icon(Icons.check_circle, size: 14, color: AppColors.success),
                        const SizedBox(width: 4),
                        Text(item.assignee!, style: const TextStyle(fontSize: 12, color: AppColors.success)),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.title ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      if (item.duration != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(item.duration!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        ),
                    ],
                  ),
                  if (item.aiSuggestion != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, size: 14, color: item.aiSuggestionColor),
                        const SizedBox(width: 4),
                        Text(item.aiSuggestion!, style: TextStyle(fontSize: 12, color: item.aiSuggestionColor)),
                      ],
                    ),
                  ],
                  if (item.aiBackup != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(item.aiBackup!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineSpacer(String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Column(
            children: [
              const Icon(Icons.directions_walk, size: 16, color: AppColors.textSecondary),
              Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              Container(
                width: 2,
                height: 20,
                color: AppColors.border,
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _buildAiInsertButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Center(
            child: Container(
              width: 2,
              height: 60,
              color: AppColors.border,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16, left: 8, right: 32),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.auto_awesome, color: Colors.purpleAccent, size: 18),
              label: const Text('AI 插入行程建議', style: TextStyle(color: Colors.purpleAccent)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.purpleAccent, style: BorderStyle.solid),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
