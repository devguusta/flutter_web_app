import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';

sealed class LocationErrorTitle {
  static String getTitle(LocationException exception) {
    return switch (exception) {
      GpsDisabledException() => 'GPS is disabled.',
      LocationPermissionDeniedException() => 'Permission was denied.',
      LocationPermitionDenieForeverException() =>
        'Permission was denied forever!',
      _ => 'Ops, something went wrong!',
    };
  }
}
