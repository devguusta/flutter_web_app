import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';

class SystemLocationRepository implements LocationRepository {
  @override
  Future<LocationEntity> getCurrentLocation() async {
    try {
      Geolocator.requestPermission();
      final gpsEnabled = await Geolocator.isLocationServiceEnabled();
      if (!gpsEnabled) {
        throw GpsDisabledException();
      }
      var permission = await Geolocator.checkPermission();
      if (!_hasPermission(permission)) {
        throw LocationPermissionDeniedException();
      }
      if (permission == LocationPermission.deniedForever) {
        throw LocationPermitionDenieForeverException();
      }
      final position = await Geolocator.getCurrentPosition();
      return LocationEntity(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } on LocationException catch (_) {
      rethrow;
    } catch (_) {
      throw LocationUnknownException();
    }
  }

  bool _hasPermission(LocationPermission permission) => switch (permission) {
        LocationPermission.always || LocationPermission.whileInUse => true,
        _ => false,
      };
}
