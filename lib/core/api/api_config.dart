/// API 配置

class ApiConfig {
  static const String baseUrl = 'http://localhost:3000/api';
  static const Duration timeout = Duration(seconds: 30);
  static const bool useMock = true; // 开发时使用 Mock 数据

  // 重试配置
  static const int retryAttempts = 3;
  static const Duration retryDelay = Duration(milliseconds: 100);
}
