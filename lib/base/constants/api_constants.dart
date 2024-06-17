class ApiConstants {
  ApiConstants._();

  // Timeout Constants
  static const int connectionTimeout = 10;
  static const int readTimeout = 10;
  static const int writeTimeout = 10;

  // API BaseUrl
  static const String baseUrl =
      'https://qc9wlso2vh.execute-api.eu-north-1.amazonaws.com/v1/';

  // API Endpoints
  static const String getUsers = 'users';
}
