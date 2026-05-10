import 'package:flutter/material.dart';
import 'package:ai_planning_companion/features/home/domain/models/trip_info.dart';
import 'package:ai_planning_companion/core/theme/app_colors.dart';

class DiscussionScreen extends StatelessWidget {
  final TripInfo trip;
  const DiscussionScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            children: [
              Text('團隊討論', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              ...trip.chat.map((chat) => _buildChatBubble(chat)),
            ],
          ),
        ),
        Container(
          color: AppColors.background,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '輸入訊息...',
                    prefixIcon: const Icon(Icons.message, color: AppColors.textSecondary),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.send, color: Colors.white),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(message.isMe ? 20 : 4),
            bottomRight: Radius.circular(message.isMe ? 4 : 20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.author, style: TextStyle(fontWeight: FontWeight.bold, color: message.isMe ? Colors.white : AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text(
              message.message,
              style: TextStyle(color: message.isMe ? Colors.white : AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
