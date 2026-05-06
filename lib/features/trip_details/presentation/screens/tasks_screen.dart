import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  final String tripId;
  const TasksScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('分工清單 (Dummy)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CheckboxListTile(value: false, onChanged: (v){}, title: const Text('建立 Splitwise 群組'), subtitle: const Text('統一記帳，減少混亂')),
          CheckboxListTile(value: false, onChanged: (v){}, title: const Text('買共用零食跟飲料'), subtitle: const Text('出發前去全聯買齊')),
          CheckboxListTile(value: true, onChanged: (v){}, title: const Text('預訂龜山島賞鯨船票'), subtitle: const Text('確認大家會不會暈船')),
        ],
      ),
    );
  }
}