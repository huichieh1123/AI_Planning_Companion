import 'package:flutter/material.dart';

class DiscussionScreen extends StatelessWidget {
  final String tripId;
  const DiscussionScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('聊天室 (Dummy)')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                Align(alignment: Alignment.centerLeft, child: Chip(label: Text('大衛: 讚！我帶狼人殺'))),
                Align(alignment: Alignment.centerLeft, child: Chip(label: Text('Bob: 有人負責訂票了嗎？'))),
                Align(alignment: Alignment.centerRight, child: Chip(label: Text('我來負責！', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '輸入訊息...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                suffixIcon: const Icon(Icons.send, color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }
}