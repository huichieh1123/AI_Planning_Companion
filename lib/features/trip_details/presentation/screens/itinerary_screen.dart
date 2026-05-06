import 'package:flutter/material.dart';

class ItineraryScreen extends StatelessWidget {
  final String tripId;
  const ItineraryScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('行程規劃 (Dummy)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(leading: Icon(Icons.location_on), title: Text('10:00 台北車站東三門集合'))),
          Card(child: ListTile(leading: Icon(Icons.motorcycle), title: Text('11:30 抵達宜蘭 - 租機車'))),
        ],
      ),
    );
  }
}