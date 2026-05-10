/// Mock 数据 - 开发用

import '../models/index.dart';

// 模拟成员
final mockMembers = [
  TripMember(
    id: '1',
    name: 'Andy',
    avatar: 'https://images.unsplash.com/photo-1611095006856-19f5ffdca7f1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg',
    email: 'andy@example.com',
    role: MemberRole.leader,
    joinedAt: DateTime(2024, 11, 20),
    isActive: true,
  ),
  TripMember(
    id: '2',
    name: 'Bob',
    avatar: 'https://images.unsplash.com/photo-1624343787706-138ae7da787b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg',
    email: 'bob@example.com',
    role: MemberRole.member,
    joinedAt: DateTime(2024, 11, 21),
    isActive: true,
    location: '達伯租車',
  ),
  TripMember(
    id: '3',
    name: 'Cindy',
    avatar: 'https://images.unsplash.com/photo-1630939687530-241d630735df?crop=entropy&cs=tinysrgb&fit=max&fm=jpg',
    email: 'cindy@example.com',
    role: MemberRole.member,
    joinedAt: DateTime(2024, 11, 21),
    isActive: true,
    location: '北車東三門',
  ),
];

// 模拟行程
final mockTrips = <Trip>[
  Trip(
    id: 'trip-1',
    name: '宜蘭三天兩夜放鬆行',
    destination: '宜蘭',
    startDate: DateTime(2024, 11, 24),
    endDate: DateTime(2024, 11, 26),
    coverImage: 'https://images.unsplash.com/photo-1558904541-efa843a96f09?crop=entropy&cs=tinysrgb&fit=max&fm=jpg',
    members: mockMembers.map((m) => m.toJson()).toList(),
    status: TripStatus.planning,
    code: 'XJ92KQ',
    createdBy: '1',
    createdAt: DateTime(2024, 11, 20, 10, 0),
    updatedAt: DateTime(2024, 11, 20, 10, 0),
  ),
  Trip(
    id: 'trip-2',
    name: '週末陽明山賞花',
    destination: '台北',
    startDate: DateTime(2024, 11, 30),
    endDate: DateTime(2024, 11, 30),
    coverImage: 'https://images.unsplash.com/photo-1576485290814-1c72ea428614?crop=entropy&cs=tinysrgb&fit=max&fm=jpg',
    members: mockMembers.sublist(0, 2).map((m) => m.toJson()).toList(),
    status: TripStatus.startingSoon,
    code: 'AB12CD',
    createdBy: '1',
    createdAt: DateTime(2024, 11, 15, 14, 30),
    updatedAt: DateTime(2024, 11, 15, 14, 30),
  ),
];
