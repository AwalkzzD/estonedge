import 'package:dio/dio.dart';
import 'package:estonedge/base/constants/app_constants.dart';

class DioManager {
  DioManager._();

  static Dio? _instance;

  static Future<Dio?> getInstance() async {
    _instance ??= Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: connectionTimeout),
        receiveTimeout: const Duration(seconds: readTimeout),
        sendTimeout: const Duration(seconds: writeTimeout),
      ),
    );
    return _instance;
  }
}
