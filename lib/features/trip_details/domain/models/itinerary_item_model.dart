import 'package:flutter/material.dart';

enum ItineraryItemType {
  item,
  spacer,
  button,
}

class ItineraryItemModel {
  final String id;
  final ItineraryItemType type;
  final String? time;
  final String? title;
  final String? duration;
  final String? aiSuggestion;
  final Color? aiSuggestionColor;
  final String? aiBackup;
  final String? label;
  final String? assignee;

  ItineraryItemModel({
    required this.id,
    required this.type,
    this.time,
    this.title,
    this.duration,
    this.aiSuggestion,
    this.aiSuggestionColor,
    this.aiBackup,
    this.label,
    this.assignee,
  });
}
