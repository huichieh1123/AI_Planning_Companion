import 'package:flutter/material.dart';
import '../../domain/models/discussion_message_model.dart';

class DiscussionRepository {
  // Simulate network delay and fetch discussion history
  Future<List<DiscussionMessageModel>> getDiscussionHistory(String tripId) async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate API delay

    return [
      DiscussionMessageModel(
        id: '1',
        sender: 'David',
        avatarColor: Colors.purple,
        message: '讚！我帶狼人殺',
        time: '09:30',
        isMe: false,
      ),
      DiscussionMessageModel(
        id: '2',
        sender: 'Cindy',
        avatarColor: Colors.orange,
        message: '有人要先去買喝的嗎？',
        time: '10:15',
        isMe: false,
      ),
      DiscussionMessageModel(
        id: '3',
        sender: 'Bob',
        avatarColor: Colors.green,
        message: '有人負責訂票了嗎？',
        time: '11:20',
        isMe: false,
      ),
      DiscussionMessageModel(
        id: '4',
        sender: 'Me',
        avatarColor: Colors.blue,
        message: '我來負責！我剛在分工那邊認領了',
        time: '11:22',
        isMe: true,
      ),
      DiscussionMessageModel(
        id: '5',
        sender: 'Bob',
        avatarColor: Colors.green,
        message: '📍 正在找車位，大約需要 5 分鐘',
        time: '11:28',
        isMe: false,
      ),
      DiscussionMessageModel(
        id: '6',
        sender: 'Bob',
        avatarColor: Colors.green,
        message: '✅ 已確認這間租車有兩台空車可租！',
        time: '11:30',
        isMe: false,
      ),
    ];
  }

  // Simulate sending a message to an API
  Future<DiscussionMessageModel> sendMessage(String tripId, String message) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate API delay

    // Return the created message mock
    return DiscussionMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: 'Me', // Assuming logged in user
      avatarColor: Colors.blue,
      message: message,
      time: _formatTime(DateTime.now()),
      isMe: true,
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
