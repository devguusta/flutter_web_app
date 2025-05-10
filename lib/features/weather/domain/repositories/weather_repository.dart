import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_status_report.dart';

/// Interface for retrieving weather data based on location.
///
/// This repository acts as a gateway to weather data sources, abstracting
/// the details of API calls from the rest of the application. Implementations
/// of this interface may use different data sources such as remote APIs,
/// local databases, or mock data for testing.
abstract interface class WeatherRepository {
  /// Retrieves comprehensive weather data for a specific location.
  ///
  /// Makes an asynchronous request to fetch current conditions, hourly forecasts,
  /// and daily forecasts for the provided geographical coordinates.
  ///
  /// Parameters:
  ///   [location] - The geographical location (latitude/longitude) for the weather data
  ///
  /// Returns:
  ///   A [Future] that resolves to a [WeatherStatusReportEntity] containing
  ///   current, hourly, and daily weather data
  ///
  /// Throws:
  ///   [Exception] - If the data cannot be retrieved due to network issues,
  ///   API errors, or other failures
  Future<WeatherStatusReportEntity> getWeatherByLocation({
    required LocationEntity location,
  });
}
