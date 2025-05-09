import 'dart:convert';

import 'package:flutter_web_app/core/http/http_client.dart';
import 'package:http/http.dart' as http;

class HttpClientImplementation implements HttpClient {
  HttpClientImplementation();

  @override
  Future<dynamic> get(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    final uri = Uri.parse(url).replace(
      queryParameters: queryParameters,
    );
    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    return data;
  }
}
