import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';

/// Interface for retrieving a device's geographical location.
///
/// This repository abstracts the details of accessing device location services,
/// handling permissions, and providing location data to the application.
abstract interface class LocationRepository {
  /// Retrieves the current geographical location of the device.
  ///
  /// This method handles the complexities of accessing device location services,
  /// including requesting permissions and handling various error conditions.
  ///
  /// Returns:
  ///   A [Future] that resolves to a [LocationEntity] containing the
  ///   latitude and longitude of the device's current position
  ///
  /// Throws:
  ///   [GpsDisabledException] - When the device's location services are disabled
  ///   [LocationPermissionDeniedException] - When the user denies location permission
  ///   [LocationPermitionDenieForeverException] - When the user has permanently denied location permission
  ///   [LocationUnknownException] - When the location cannot be determined for unspecified reasons
  Future<LocationEntity> getCurrentLocation();
}
