import 'package:flutter/material.dart';

class TaskItem {
  final String title;
  final String subtitle;
  final bool completed;
  final String? assignee;

  const TaskItem({
    required this.title,
    required this.subtitle,
    required this.completed,
    this.assignee,
  });
}

class ItineraryItem {
  final int day;
  final String time;
  final String title;
  final String subtitle;
  final IconData icon;

  const ItineraryItem({
    required this.day,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class ChatMessage {
  final String author;
  final String message;
  final bool isMe;

  const ChatMessage({
    required this.author,
    required this.message,
    required this.isMe,
  });
}

class TripInfo {
  final String id;
  final String title;
  final String location;
  final String dateRange;
  final String status;
  final String participants;
  final String description;
  final Color statusColor;
  final List<String> highlights;
  final List<TaskItem> tasks;
  final List<ItineraryItem> itinerary;
  final List<ChatMessage> chat;

  const TripInfo({
    required this.id,
    required this.title,
    required this.location,
    required this.dateRange,
    required this.status,
    required this.participants,
    required this.description,
    required this.statusColor,
    required this.highlights,
    required this.tasks,
    required this.itinerary,
    required this.chat,
  });
}
