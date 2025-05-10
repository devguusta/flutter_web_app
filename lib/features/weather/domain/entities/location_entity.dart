/// Represents a location with geographical coordinates.
///
/// This class encapsulates latitude and longitude values that identify
/// a specific position on Earth's surface, used for weather data retrieval
/// and reverse geocoding operations.
final class LocationEntity {
  /// Latitude coordinate in decimal degrees
  /// Positive values represent north, negative values represent south
  final double latitude;

  /// Longitude coordinate in decimal degrees
  /// Positive values represent east, negative values represent south
  final double longitude;

  const LocationEntity({
    required this.latitude,
    required this.longitude,
  });
}
