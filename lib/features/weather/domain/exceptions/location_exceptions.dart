abstract class LocationException implements Exception {
  const LocationException();
}

class GpsDisabledException implements LocationException {
  const GpsDisabledException();
}

class LocationPermissionDeniedException implements LocationException {
  const LocationPermissionDeniedException();
}

class LocationPermitionDenieForeverException implements LocationException {
  const LocationPermitionDenieForeverException();
}

class LocationUnknownException implements LocationException {
  const LocationUnknownException();
}
