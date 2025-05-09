import 'package:flutter_web_app/core/http/http_client.dart';
import 'package:flutter_web_app/core/http/http_configs.dart';
import 'package:flutter_web_app/features/weather/data/models/address_model.dart';
import 'package:flutter_web_app/features/weather/domain/entities/address_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/address_repository.dart';

class RemoteAddressRepositoryImpl implements AddressRepository {
  const RemoteAddressRepositoryImpl({required this.httpClient});

  final HttpClient httpClient;

  @override
  Future<AddressEntity> getAddressFromLocation({
    required LocationEntity location,
  }) async {
    final response =
        await httpClient.get(HttpConfigs.reverseAddressUrl, queryParameters: {
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'format': 'json',
    });
    final address = AddressModel.fromJson(response as Map<String, dynamic>);
    return address.toEntity();
  }
}
