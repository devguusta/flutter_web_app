import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/core/http/http_configs.dart';
import 'package:flutter_web_app/features/weather/data/repositories/remote/remote_address_repository_impl.dart';
import 'package:flutter_web_app/features/weather/domain/entities/address_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mock_class.dart';

void main() {
  final client = HttpClientMock();

  final repository = RemoteAddressRepositoryImpl(
    httpClient: client,
  );
  const location = LocationEntity(latitude: 30, longitude: 30);

  final queryParameters = {
    'lat': location.latitude.toString(),
    'lon': location.longitude.toString(),
    'format': 'json',
  };

  tearDown(() {
    reset(client);
  });
  group('Remote address repository', () {
    test('Should return address entity when api return success', () async {
      when(
        () => client.get(
          HttpConfigs.reverseAddressUrl,
          queryParameters: queryParameters,
        ),
      ).thenAnswer((_) async => {
            'address': {
              'city': 'Nova iguacu',
              'state': 'Rio de Janeiro',
            }
          });

      final result =
          await repository.getAddressFromLocation(location: location);
      expect(
        result,
        AddressEntity(city: 'Nova iguacu', state: 'Rio de Janeiro'),
      );
    });

    test('Should throw exception when api return error', () async {
      when(
        () => client.get(
          HttpConfigs.reverseAddressUrl,
          queryParameters: queryParameters,
        ),
      ).thenThrow(Exception('Error'));

      expect(
        () async => await repository.getAddressFromLocation(location: location),
        throwsA(isA<Exception>()),
      );
    });
  });
}
