import 'package:dio/dio.dart';

/// This class is responsible for creating a custom Dio instance with specific configurations.
/// It extends the DioMixin class and sets up interceptors, options, and timeouts.
/// The interceptors are used for logging requests and responses.
/// The options include the base URL, connection timeout, receive timeout, send timeout,
/// response type, and status validation.
class CustomDio extends DioMixin {
  CustomDio() {
    interceptors.add(
      LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        error: true,
      ),
    );

    options = BaseOptions(
      baseUrl: 'https://api.example.com',
      connectTimeout: Duration(
        milliseconds: 3000,
      ),
      receiveTimeout: Duration(
        milliseconds: 3000,
      ),
      sendTimeout: Duration(
        milliseconds: 3000,
      ),
      responseType: ResponseType.json,
      validateStatus: (status) => status! < 500,
    );
  }
}
