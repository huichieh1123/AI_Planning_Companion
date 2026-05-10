import 'package:flutter/material.dart';
import '../../domain/models/itinerary_item_model.dart';
import '../../data/repositories/itinerary_repository.dart';

class ItineraryProvider extends ChangeNotifier {
  final ItineraryRepository _repository = ItineraryRepository();
  final String tripId;

  bool isLoading = false;
  List<ItineraryItemModel> itineraryItems = [];
  int selectedDayIndex = 0;
  
  final List<String> days = ['Day 1 (11/24)', 'Day 2 (11/25)', 'Day 3 (11/26)'];

  ItineraryProvider({required this.tripId}) {
    loadItinerary();
  }

  void selectDay(int index) {
    selectedDayIndex = index;
    loadItinerary();
  }

  Future<void> loadItinerary() async {
    isLoading = true;
    notifyListeners();

    try {
      itineraryItems = await _repository.getItinerary(tripId, selectedDayIndex);
    } catch (e) {
      debugPrint('Error loading itinerary: \$e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteItem(ItineraryItemModel item) async {
    final index = itineraryItems.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      itineraryItems.removeAt(index);
      notifyListeners();

      try {
        await _repository.deleteItineraryItem(item.id);
      } catch (e) {
        // Revert on error
        loadItinerary();
      }
    }
  }
}
