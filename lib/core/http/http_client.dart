/// HttpClient interface
/// This interface defines the methods for making HTTP requests.
/// It includes the GET method for fetching data from a URL,
///
/// In the future it includes methods for GET, POST, PUT, and DELETE requests.
library;

abstract interface class HttpClient {
  Future get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });
}
