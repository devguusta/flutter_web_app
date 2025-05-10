import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';
import 'package:flutter_web_app/features/weather/domain/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';

/// Implementation of [LocationRepository] that uses the system's location services.
///
/// This class uses the Geolocator package to access the device's GPS and
/// provide geographical coordinates after handling permissions and error cases.
class SystemLocationRepository implements LocationRepository {
  @override
  Future<LocationEntity> getCurrentLocation() async {
    try {
      // Request location permission from the user
      Geolocator.requestPermission();

      // Check if location services are enabled
      final gpsEnabled = await Geolocator.isLocationServiceEnabled();
      if (!gpsEnabled) {
        throw GpsDisabledException();
      }

      // Check location permission status
      var permission = await Geolocator.checkPermission();
      if (!_hasPermission(permission)) {
        throw LocationPermissionDeniedException();
      }
      if (permission == LocationPermission.deniedForever) {
        throw LocationPermitionDenieForeverException();
      }

      // Get the current position
      final position = await Geolocator.getCurrentPosition();
      return LocationEntity(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } on LocationException catch (_) {
      // Re-throw location-specific exceptions
      rethrow;
    } catch (_) {
      // Wrap unknown exceptions
      throw LocationUnknownException();
    }
  }

  /// Determines if the given permission level allows location access.
  ///
  /// Parameters:
  ///   [permission] - The permission level to check
  ///
  /// Returns:
  ///   [bool] - True if the permission allows location access, false otherwise
  bool _hasPermission(LocationPermission permission) => switch (permission) {
        LocationPermission.always || LocationPermission.whileInUse => true,
        _ => false,
      };
}
