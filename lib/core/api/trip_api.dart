/// 行程 API 接口定义
/// 支持依赖注入，便于快速切换 Mock 或真实 API

import '../models/index.dart';

/// 行程 API 接口
abstract class ITripApi {
  Future<List<Trip>> getTrips();
  Future<Trip> getTripDetail(String tripId);
  Future<Trip> createTrip(CreateTripRequest request);
  Future<Trip> updateTrip(String tripId, UpdateTripRequest request);
  Future<void> deleteTrip(String tripId);
  Future<Trip> joinTrip(String tripId, String code);
}

/// 真实 API 实现（待实现）
class TripApi implements ITripApi {
  final String baseUrl;

  TripApi({required this.baseUrl});

  @override
  Future<List<Trip>> getTrips() async {
    // TODO: 实现真实 API 调用
    throw UnimplementedError('Real API not yet implemented');
  }

  @override
  Future<Trip> getTripDetail(String tripId) async {
    // TODO: 实现真实 API 调用
    throw UnimplementedError('Real API not yet implemented');
  }

  @override
  Future<Trip> createTrip(CreateTripRequest request) async {
    // TODO: 实现真实 API 调用
    throw UnimplementedError('Real API not yet implemented');
  }

  @override
  Future<Trip> updateTrip(String tripId, UpdateTripRequest request) async {
    // TODO: 实现真实 API 调用
    throw UnimplementedError('Real API not yet implemented');
  }

  @override
  Future<void> deleteTrip(String tripId) async {
    // TODO: 实现真实 API 调用
    throw UnimplementedError('Real API not yet implemented');
  }

  @override
  Future<Trip> joinTrip(String tripId, String code) async {
    // TODO: 实现真实 API 调用
    throw UnimplementedError('Real API not yet implemented');
  }
}
