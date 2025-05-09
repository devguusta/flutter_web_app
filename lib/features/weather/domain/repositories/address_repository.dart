import 'package:flutter_web_app/features/weather/domain/entities/address_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/location_entity.dart';

/// This is an abstract interface class for the AddressRepository.
/// It defines the methods that any concrete implementation of this repository must provide.
abstract interface class AddressRepository {
  /// Returns the address corresponding to the given location.
  Future<AddressEntity> getAddressFromLocation({
    required LocationEntity location,
  });
}
