/// 行程服务层
/// 封装所有与行程相关的业务逻辑

import '../api/index.dart';
import '../models/index.dart';

/// 行程服务
class TripService {
  final ITripApi _api;
  
  // 缓存
  final Map<String, Trip> _cache = {};
  DateTime? _lastFetchTime;
  final Duration _cacheExpiry = const Duration(minutes: 5);

  TripService({required ITripApi api}) : _api = api;

  /// 获取所有行程列表
  /// 支持缓存，5分钟内不重新获取
  Future<List<Trip>> getMyTrips({bool forceRefresh = false}) async {
    final now = DateTime.now();
    
    if (!forceRefresh && 
        _lastFetchTime != null && 
        now.difference(_lastFetchTime!) < _cacheExpiry) {
      // 返回缓存数据
      return _cache.values.toList();
    }

    try {
      final trips = await _api.getTrips();
      
      // 清空旧缓存，存入新数据
      _cache.clear();
      for (var trip in trips) {
        _cache[trip.id] = trip;
      }
      _lastFetchTime = now;

      return trips;
    } catch (e) {
      // 如果有缓存，返回缓存而不是抛出错误
      if (_cache.isNotEmpty) {
        print('Failed to fetch trips, returning cached data');
        return _cache.values.toList();
      }
      rethrow;
    }
  }

  /// 获取行程详情
  Future<Trip> getTripDetail(String tripId, {bool forceRefresh = false}) async {
    if (!forceRefresh && _cache.containsKey(tripId)) {
      return _cache[tripId]!;
    }

    final trip = await _api.getTripDetail(tripId);
    _cache[tripId] = trip;
    return trip;
  }

  /// 创建新行程
  Future<Trip> createTrip(CreateTripRequest request) async {
    final trip = await _api.createTrip(request);
    _cache[trip.id] = trip;
    _lastFetchTime = null; // 清除列表缓存，下次会重新获取
    return trip;
  }

  /// 更新行程信息
  Future<Trip> updateTrip(String tripId, UpdateTripRequest request) async {
    final trip = await _api.updateTrip(tripId, request);
    _cache[tripId] = trip;
    _lastFetchTime = null; // 清除列表缓存
    return trip;
  }

  /// 删除行程
  Future<void> deleteTrip(String tripId) async {
    await _api.deleteTrip(tripId);
    _cache.remove(tripId);
    _lastFetchTime = null; // 清除列表缓存
  }

  /// 加入行程
  Future<Trip> joinTrip(String tripId, String code) async {
    final trip = await _api.joinTrip(tripId, code);
    _cache[tripId] = trip;
    _lastFetchTime = null; // 清除列表缓存
    return trip;
  }

  /// 清除所有缓存
  void clearCache() {
    _cache.clear();
    _lastFetchTime = null;
  }
}
