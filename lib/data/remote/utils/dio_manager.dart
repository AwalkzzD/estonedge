import 'package:dio/dio.dart';
import 'package:estonedge/base/constants/api_constants.dart';

class DioManager {
  DioManager._();

  static Dio? _instance;

  static Future<Dio?> getInstance() async {
    _instance ??= Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: ApiConstants.connectionTimeout),
        receiveTimeout: const Duration(seconds: ApiConstants.readTimeout),
        sendTimeout: const Duration(seconds: ApiConstants.writeTimeout),
      ),
    );
    return _instance;
  }
}
