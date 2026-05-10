import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_planning_companion/core/theme/app_colors.dart';
import 'package:ai_planning_companion/features/home/data/trip_data.dart';
import 'package:ai_planning_companion/features/home/domain/models/trip_info.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<TripInfo> get _tripList => tripSamples.values.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            _buildTopRow(context),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B), // Dark slate color from Figma
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add, color: Colors.white, size: 28),
                        SizedBox(height: 8),
                        Text('發起新行程', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.link, size: 18, color: AppColors.textSecondary),
                            SizedBox(width: 6),
                            Text('加入行程', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            Text('輸入 6 碼代碼 ', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                            Icon(Icons.arrow_forward, size: 14, color: AppColors.primary),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Icon(Icons.map_outlined, size: 20, color: AppColors.primary),
                const SizedBox(width: 8),
                Text('我的行程', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            ..._tripList
                .map((trip) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildTripCard(context, trip: trip),
                    )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('我的行程', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('專屬朋友圈的出遊規劃工具', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(Icons.help_outline, color: AppColors.textSecondary, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.surface,
                  child: Text('A', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 4),
                const Text('Andy', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
        hintText: '搜尋行程、目的地或 AI 建議',
        filled: true,
        fillColor: AppColors.surface,
      ),
    );
  }

  Widget _buildAiSuggestionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha((0.16 * 255).round()),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AI 智能行程建議', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          const Text(
            '讓 AI 幫你生成適合團體的路線、景點與餐飲安排。',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {},
                child: const Text('開始規劃'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {},
                child: const Text('查看範例', style: TextStyle(color: Colors.white70)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, {required TripInfo trip}) {
    return GestureDetector(
      onTap: () => context.push('/trip/${trip.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(trip.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                _buildStatusChip(trip.status, trip.statusColor),
              ],
            ),
            const SizedBox(height: 12),
            Text(trip.description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(Icons.calendar_month, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(trip.dateRange, style: const TextStyle(color: AppColors.textSecondary)),
                const SizedBox(width: 14),
                const Icon(Icons.people, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(trip.participants, style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              children: trip.highlights
                  .map((label) => Chip(
                        label: Text(label, style: const TextStyle(fontSize: 12)),
                        backgroundColor: AppColors.background,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha((0.15 * 255).round()),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
    );
  }
}
