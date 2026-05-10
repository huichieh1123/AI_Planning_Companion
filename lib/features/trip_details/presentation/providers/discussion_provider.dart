import 'package:flutter/material.dart';
import '../../domain/models/discussion_message_model.dart';
import '../../data/repositories/discussion_repository.dart';

class DiscussionProvider extends ChangeNotifier {
  final DiscussionRepository _repository = DiscussionRepository();
  final String tripId;

  bool isLoading = false;
  List<DiscussionMessageModel> messages = [];

  DiscussionProvider({required this.tripId}) {
    loadMessages();
  }

  Future<void> loadMessages() async {
    isLoading = true;
    notifyListeners();

    try {
      messages = await _repository.getDiscussionHistory(tripId);
    } catch (e) {
      debugPrint('Error loading messages: \$e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Optimistic update
    final optimisticMessage = DiscussionMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // temporary ID
      sender: 'Me',
      avatarColor: Colors.blue,
      message: text,
      time: 'Sending...',
      isMe: true,
    );
    
    messages.add(optimisticMessage);
    notifyListeners();

    try {
      final confirmedMessage = await _repository.sendMessage(tripId, text);
      
      // Replace optimistic message with confirmed one
      final index = messages.indexWhere((m) => m.id == optimisticMessage.id);
      if (index != -1) {
        messages[index] = confirmedMessage;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error sending message: \$e');
      // Revert optimistic update on failure
      messages.removeWhere((m) => m.id == optimisticMessage.id);
      notifyListeners();
    }
  }
}
