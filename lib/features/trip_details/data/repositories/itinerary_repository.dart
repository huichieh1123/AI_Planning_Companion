import 'package:ai_planning_companion/core/theme/app_colors.dart';
import '../../domain/models/itinerary_item_model.dart';

class ItineraryRepository {
  Future<List<ItineraryItemModel>> getItinerary(String tripId, int dayIndex) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return dummy data based on day index (simplified for demo)
    return [
      ItineraryItemModel(
        id: '1',
        type: ItineraryItemType.item,
        time: '11:30',
        title: '抵達宜蘭 - 租機車',
        duration: '1h',
        aiSuggestion: '交通風險：易塞車',
        aiSuggestionColor: AppColors.warning,
        aiBackup: 'AI 備案：提前出發或安排替換方案',
      ),
      ItineraryItemModel(
        id: 'spacer_1',
        type: ItineraryItemType.spacer,
        label: '0m',
      ),
      ItineraryItemModel(
        id: '2',
        type: ItineraryItemType.item,
        time: '12:30',
        title: '午餐 - 蘭城晶英烤鴨',
        duration: '2h',
        aiSuggestion: '人潮風險：需排隊久候',
        aiSuggestionColor: AppColors.error,
        aiBackup: 'AI 備案：新月廣場美食街',
        assignee: 'Andy 預約過',
      ),
      ItineraryItemModel(
        id: 'btn_1',
        type: ItineraryItemType.button,
      ),
      ItineraryItemModel(
        id: '3',
        type: ItineraryItemType.item,
        time: '18:00',
        title: '頭城外澳沙灘踏浪',
        duration: '2h',
        aiSuggestion: '天氣風險：預測有雨',
        aiSuggestionColor: AppColors.primary,
        aiBackup: 'AI 備案：蘭陽博物館',
      ),
    ];
  }

  Future<void> deleteItineraryItem(String itemId) async {
    // Simulate API call to delete
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
