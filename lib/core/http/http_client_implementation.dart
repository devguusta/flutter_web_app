import 'package:dio/dio.dart';
import 'package:flutter_web_app/core/http/http_client.dart';

class HttpClientImplementation implements HttpClient {
  final Dio dio;

  HttpClientImplementation(this.dio);

  @override
  Future<T> get<T>(String url,
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) {
    throw UnimplementedError();
  }
}
