/// 用户/成员相关模型
class User {
  final String id;
  final String name;
  final String avatar;
  final String? email;

  User({
    required this.id,
    required this.name,
    required this.avatar,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      if (email != null) 'email': email,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? avatar,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
    );
  }
}

/// 行程成员
enum MemberRole { leader, member }

class TripMember extends User {
  final MemberRole role;
  final DateTime joinedAt;
  final bool isActive;
  final String? location;

  TripMember({
    required String id,
    required String name,
    required String avatar,
    required this.role,
    required this.joinedAt,
    this.isActive = true,
    this.location,
    String? email,
  }) : super(id: id, name: name, avatar: avatar, email: email);

  factory TripMember.fromJson(Map<String, dynamic> json) {
    return TripMember(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'],
      role: (json['role'] ?? 'member') == 'leader' ? MemberRole.leader : MemberRole.member,
      joinedAt: DateTime.parse(json['joinedAt'] ?? DateTime.now().toIso8601String()),
      isActive: json['isActive'] ?? true,
      location: json['location'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'role': role == MemberRole.leader ? 'leader' : 'member',
      'joinedAt': joinedAt.toIso8601String(),
      'isActive': isActive,
      if (location != null) 'location': location,
    };
  }

  TripMember copyWith({
    String? id,
    String? name,
    String? avatar,
    String? email,
    MemberRole? role,
    DateTime? joinedAt,
    bool? isActive,
    String? location,
  }) {
    return TripMember(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
      location: location ?? this.location,
    );
  }
}
