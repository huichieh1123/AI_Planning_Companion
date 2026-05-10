import 'package:flutter/material.dart';

class MessageModel {
  final String id;
  final String sender;
  final String message;
  final String time;
  final bool isMe;
  final Color avatarColor;

  MessageModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.time,
    required this.isMe,
    required this.avatarColor,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      sender: json['sender'],
      message: json['message'],
      time: json['time'],
      isMe: json['isMe'] ?? false,
      avatarColor: Colors.blue, // Simplified for demo
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'message': message,
      'time': time,
      'isMe': isMe,
    };
  }
}
