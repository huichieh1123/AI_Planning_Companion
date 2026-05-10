/// Mock API 实现
/// 用于开发和测试，无需真实后端

import '../models/index.dart';
import '../constants/mock_data.dart';
import 'trip_api.dart';

/// Mock API 实现
class MockTripApi implements ITripApi {
  // 模拟网络延迟
  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<List<Trip>> getTrips() async {
    await _delay();
    return mockTrips;
  }

  @override
  Future<Trip> getTripDetail(String tripId) async {
    await _delay();
    try {
      return mockTrips.firstWhere((trip) => trip.id == tripId);
    } catch (e) {
      throw Exception('Trip $tripId not found');
    }
  }

  @override
  Future<Trip> createTrip(CreateTripRequest request) async {
    await _delay();
    final newTrip = Trip(
      id: 'trip-${DateTime.now().millisecondsSinceEpoch}',
      name: request.name,
      destination: request.destination,
      startDate: request.startDate,
      endDate: request.endDate,
      coverImage: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg',
      status: TripStatus.planning,
      code: _generateCode(),
      createdBy: '1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    mockTrips.add(newTrip);
    return newTrip;
  }

  @override
  Future<Trip> updateTrip(String tripId, UpdateTripRequest request) async {
    await _delay();
    final index = mockTrips.indexWhere((trip) => trip.id == tripId);
    if (index == -1) throw Exception('Trip $tripId not found');

    final updated = mockTrips[index].copyWith(
      name: request.name,
      destination: request.destination,
      startDate: request.startDate,
      endDate: request.endDate,
      description: request.description,
      status: request.status,
    );
    mockTrips[index] = updated;
    return updated;
  }

  @override
  Future<void> deleteTrip(String tripId) async {
    await _delay();
    mockTrips.removeWhere((trip) => trip.id == tripId);
  }

  @override
  Future<Trip> joinTrip(String tripId, String code) async {
    await _delay();
    try {
      final trip = mockTrips.firstWhere(
        (trip) => trip.id == tripId && trip.code == code,
      );
      return trip;
    } catch (e) {
      throw Exception('Invalid trip code');
    }
  }

  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String result = '';
    for (int i = 0; i < 6; i++) {
      result += chars[(DateTime.now().millisecond + i) % chars.length];
    }
    return result;
  }
}
