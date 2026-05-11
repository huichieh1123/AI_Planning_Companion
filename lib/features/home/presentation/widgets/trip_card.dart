import 'package:flutter/material.dart';
import 'package:ai_planning_companion/core/models/index.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onRestore;

  const TripCard({
    Key? key,
    required this.trip,
    required this.onTap,
    this.onDelete,
    this.onRestore,
  }) : super(key: key);

  String _getStatusLabel() {
    switch (trip.status) {
      case TripStatus.planning:
        return '規劃中';
      case TripStatus.startingSoon:
        return '即將出發';
      case TripStatus.inProgress:
        return '進行中';
      case TripStatus.completed:
        return '已完成';
      case TripStatus.cancelled:
        return '已取消';
    }
  }

  Color _getStatusColor() {
    switch (trip.status) {
      case TripStatus.planning:
        return Colors.blue;
      case TripStatus.startingSoon:
        return Colors.green;
      case TripStatus.inProgress:
        return Colors.orange;
      case TripStatus.completed:
        return Colors.grey;
      case TripStatus.cancelled:
        return Colors.red;
    }
  }

  String get _dateRange {
    final start = '${trip.startDate.month}/${trip.startDate.day}';
    final end = '${trip.endDate.month}/${trip.endDate.day}';
    return start == end ? start : '$start - $end';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面图
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                trip.coverImage ?? '',
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.image_outlined, color: Colors.grey)),
                  );
                },
              ),
            ),
            // 内容
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题 + 状态
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          trip.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor().withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getStatusLabel(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 日期 + 人数
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        _dateRange,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${trip.members?.length ?? 0} 人參與',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
