import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';

abstract interface class LocationRepository {
  /// Returns the current location of the user.
  Future<LocationEntity> getCurrentLocation();
}
