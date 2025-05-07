import 'package:flutter_web_app/core/http/http_client.dart';
import 'package:flutter_web_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:mocktail/mocktail.dart';

// This file contains mock classes for testing purposes.
class HttpClientMock extends Mock implements HttpClient {}

class AuthenticationRepositoryMock extends Mock
    implements AuthenticationRepository {}
