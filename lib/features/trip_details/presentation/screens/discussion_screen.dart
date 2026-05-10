import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_planning_companion/core/theme/app_colors.dart';
import '../providers/discussion_provider.dart';

class DiscussionScreen extends StatefulWidget {
  final String tripId;
  const DiscussionScreen({super.key, required this.tripId});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSendMessage(BuildContext context) {
    final text = _messageController.text;
    if (text.isNotEmpty) {
      context.read<DiscussionProvider>().sendMessage(text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Consumer<DiscussionProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemCount: provider.messages.length,
                  itemBuilder: (context, index) {
                    final message = provider.messages[index];
                    return _buildMessageBubble(
                      sender: message.sender,
                      avatarColor: message.avatarColor,
                      message: message.message,
                      time: message.time,
                      isMe: message.isMe,
                    );
                  },
                );
              },
            ),
          ),
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required String sender,
    required Color avatarColor,
    required String message,
    required String time,
    required bool isMe,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: avatarColor.withOpacity(0.2),
              child: Text(sender[0], style: TextStyle(color: avatarColor, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe) ...[
                  Text(sender, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                ],
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isMe ? 16 : 0),
                      bottomRight: Radius.circular(isMe ? 0 : 16),
                    ),
                    border: isMe ? null : Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(color: isMe ? Colors.white : AppColors.textPrimary),
                  ),
                ),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              ],
            ),
          ),
          if (isMe) const SizedBox(width: 24), // Spacer for self messages to align better visually
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.surface,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                onSubmitted: (_) => _handleSendMessage(context),
                decoration: InputDecoration(
                  hintText: '輸入訊息或輸入 @AI 呼叫助手...',
                  hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () => _handleSendMessage(context),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white, size: 18),
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
