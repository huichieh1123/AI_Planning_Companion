import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的行程', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      // 👇 就是這個 body 區塊決定了中間的卡片顯示 👇
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTripCard(
            context,
            tripId: 'XJ92KQ',
            title: '宜蘭三天兩夜放鬆行',
            date: '11/24 - 11/26',
            people: '4 人參與',
            status: '規劃中',
            statusColor: Colors.grey,
          ),
          const SizedBox(height: 16),
          _buildTripCard(
            context,
            tripId: 'ABCDEF',
            title: '週末陽明山賞花',
            date: '11/30',
            people: '6 人參與',
            status: '即將出發',
            statusColor: Colors.blue,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  // 獨立出來的卡片 UI 元件
  Widget _buildTripCard(BuildContext context, {
    required String tripId, 
    required String title, 
    required String date, 
    required String people, 
    required String status, 
    required Color statusColor,
  }) {
    return GestureDetector(
      // 點擊卡片跳轉到行程詳細頁 (TripMainScreen)
      onTap: () => context.go('/trip/$tripId'),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 左側灰色圖片佔位區
              Container(
                width: 60, height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              // 中間文字區塊 (Expanded 確保文字不會超出螢幕)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(status, style: TextStyle(color: statusColor, fontSize: 12)),
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('$date • $people', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              // 右側箭頭
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}