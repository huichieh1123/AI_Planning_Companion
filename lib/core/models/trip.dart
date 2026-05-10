/// 行程相关模型

enum TripStatus { planning, startingSoon, inProgress, completed, cancelled }

class Trip {
  final String id;
  final String name;
  final String? description;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String coverImage;
  final List<Map<String, dynamic>>? members; // 简化版成员列表
  final TripStatus status;
  final String? code;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Trip({
    required this.id,
    required this.name,
    this.description,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.coverImage,
    this.members,
    required this.status,
    this.code,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      destination: json['destination'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      coverImage: json['coverImage'] ?? '',
      members: (json['members'] as List?)?.cast<Map<String, dynamic>>(),
      status: _parseStatus(json['status'] ?? 'planning'),
      code: json['code'],
      createdBy: json['createdBy'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  static TripStatus _parseStatus(String status) {
    switch (status) {
      case 'planning':
        return TripStatus.planning;
      case 'starting_soon':
        return TripStatus.startingSoon;
      case 'in_progress':
        return TripStatus.inProgress;
      case 'completed':
        return TripStatus.completed;
      case 'cancelled':
        return TripStatus.cancelled;
      default:
        return TripStatus.planning;
    }
  }

  static String _statusToString(TripStatus status) {
    switch (status) {
      case TripStatus.planning:
        return 'planning';
      case TripStatus.startingSoon:
        return 'starting_soon';
      case TripStatus.inProgress:
        return 'in_progress';
      case TripStatus.completed:
        return 'completed';
      case TripStatus.cancelled:
        return 'cancelled';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (description != null) 'description': description,
      'destination': destination,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'coverImage': coverImage,
      if (members != null) 'members': members,
      'status': _statusToString(status),
      if (code != null) 'code': code,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Trip copyWith({
    String? id,
    String? name,
    String? description,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    String? coverImage,
    List<Map<String, dynamic>>? members,
    TripStatus? status,
    String? code,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      coverImage: coverImage ?? this.coverImage,
      members: members ?? this.members,
      status: status ?? this.status,
      code: code ?? this.code,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get daysCount {
    return (endDate.difference(startDate).inDays + 1).toString();
  }

  String get dateRange {
    final startMonth = startDate.month;
    final startDay = startDate.day;
    final endMonth = endDate.month;
    final endDay = endDate.day;

    if (startMonth == endMonth && startDay == endDay) {
      return '$startMonth/$startDay';
    }
    return '$startMonth/$startDay - $endMonth/$endDay';
  }
}

class CreateTripRequest {
  final String name;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String? description;
  final List<String>? memberIds;

  CreateTripRequest({
    required this.name,
    required this.destination,
    required this.startDate,
    required this.endDate,
    this.description,
    this.memberIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'destination': destination,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      if (description != null) 'description': description,
      if (memberIds != null) 'memberIds': memberIds,
    };
  }
}

class UpdateTripRequest {
  final String? name;
  final String? destination;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? description;
  final TripStatus? status;

  UpdateTripRequest({
    this.name,
    this.destination,
    this.startDate,
    this.endDate,
    this.description,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (destination != null) 'destination': destination,
      if (startDate != null) 'startDate': startDate!.toIso8601String(),
      if (endDate != null) 'endDate': endDate!.toIso8601String(),
      if (description != null) 'description': description,
      if (status != null) 'status': Trip._statusToString(status!),
    };
  }
}
