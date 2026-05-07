import 'package:flutter/material.dart';
import '../domain/models/trip_info.dart';

const Map<String, TripInfo> tripSamples = {
  'XJ92KQ': TripInfo(
    id: 'XJ92KQ',
    title: '宜蘭三天兩夜放鬆行',
    location: '宜蘭',
    dateRange: '11/24 - 11/26',
    status: '規劃中',
    participants: '4 人',
    description: '海景民宿、溫泉、慢活美食。',
    statusColor: Color(0xFF64748B),
    highlights: ['溫泉下午茶', '龜山島賞鯨', '羅東夜市'],
    tasks: [
      TaskItem(title: '預訂民宿', subtitle: '完成 80%：確認房型與折扣', completed: true, assignee: '大衛'),
      TaskItem(title: '餐廳名單', subtitle: '新增 5 個口袋名單', completed: false, assignee: '小美'),
      TaskItem(title: '交通安排', subtitle: '租車或火車待確認', completed: false, assignee: '你'),
    ],
    itinerary: [
      ItineraryItem(day: 1, time: '09:30', title: '台北出發', subtitle: '火車前往宜蘭', icon: Icons.train),
      ItineraryItem(day: 1, time: '13:00', title: '海景民宿入住', subtitle: '拍照、休息、溫泉', icon: Icons.hotel),
      ItineraryItem(day: 2, time: '10:00', title: '龜山島賞鯨', subtitle: '船票、暈船藥', icon: Icons.directions_boat),
      ItineraryItem(day: 3, time: '15:30', title: '羅東夜市', subtitle: '必吃三星蔥餅', icon: Icons.local_dining),
    ],
    chat: [
      ChatMessage(author: '大衛', message: '我已經幫大家看好民宿了！', isMe: false),
      ChatMessage(author: '小美', message: '是否要加一個烤肉行程？', isMe: false),
      ChatMessage(author: '你', message: '我可以負責訂船票。', isMe: true),
    ],
  ),
  'ABCDEF': TripInfo(
    id: 'ABCDEF',
    title: '週末陽明山賞花',
    location: '陽明山',
    dateRange: '11/30',
    status: '即將出發',
    participants: '6 人',
    description: '賞花、野餐、放鬆散步輕旅行。',
    statusColor: Color(0xFF2563EB),
    highlights: ['櫻花大道', '草山夜景', '溫泉泡湯'],
    tasks: [
      TaskItem(title: '準備野餐籃', subtitle: '確認餐點與野餐墊', completed: true, assignee: 'Jessie'),
      TaskItem(title: '交通公車', subtitle: '預留停車位或公車資訊', completed: false, assignee: 'Kevin'),
      TaskItem(title: '行程快照', subtitle: '整理旅程摘要給大家', completed: false, assignee: '你'),
    ],
    itinerary: [
      ItineraryItem(day: 1, time: '09:00', title: '出發集合', subtitle: '台北西門町集合', icon: Icons.group),
      ItineraryItem(day: 1, time: '10:30', title: '花季步道', subtitle: '沿途賞花與拍照', icon: Icons.local_florist),
      ItineraryItem(day: 1, time: '13:00', title: '野餐午餐', subtitle: '薄餅、水果、飲料', icon: Icons.lunch_dining),
      ItineraryItem(day: 1, time: '15:00', title: '山景咖啡', subtitle: '喝一杯熱拿鐵', icon: Icons.local_cafe),
    ],
    chat: [
      ChatMessage(author: 'Jessie', message: '大家要帶雨衣嗎？', isMe: false),
      ChatMessage(author: '你', message: '我這邊天氣預報說晴天 ✅', isMe: true),
      ChatMessage(author: 'Kevin', message: '我來準備水果吧', isMe: false),
    ],
  ),
};
