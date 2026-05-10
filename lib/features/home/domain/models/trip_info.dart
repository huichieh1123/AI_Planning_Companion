import 'package:flutter/material.dart';

class TripInfo {
  final String id;
  final String title;
  final String dateRange;
  final String participants;
  final String status;
  final Color statusColor;

  TripInfo({
    required this.id,
    required this.title,
    required this.dateRange,
    required this.participants,
    required this.status,
    required this.statusColor,
  });
}
