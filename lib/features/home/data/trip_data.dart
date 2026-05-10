import 'package:ai_planning_companion/core/theme/app_colors.dart';
import 'package:ai_planning_companion/features/home/domain/models/trip_info.dart';

final Map<String, TripInfo> tripSamples = {
  '1': TripInfo(
    id: '1',
    title: '宜蘭三天兩夜放鬆行',
    dateRange: '11/24 - 11/26',
    participants: '4 人參與',
    status: '規劃中',
    statusColor: AppColors.primary,
  ),
  '2': TripInfo(
    id: '2',
    title: '週末陽明山賞花',
    dateRange: '11/30',
    participants: '6 人參與',
    status: '即將出發',
    statusColor: AppColors.success,
  ),
};
