import 'package:flutter/material.dart';

class DiscussionMessageModel {
  final String id;
  final String sender;
  final Color avatarColor;
  final String message;
  final String time;
  final bool isMe;

  DiscussionMessageModel({
    required this.id,
    required this.sender,
    required this.avatarColor,
    required this.message,
    required this.time,
    required this.isMe,
  });
}
