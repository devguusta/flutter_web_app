import 'package:equatable/equatable.dart';

/// AddressEntity is a data class that represents an address with a city and state.
/// It is used to encapsulate the address information in a structured way.
class AddressEntity extends Equatable {
  const AddressEntity({
    required this.city,
    required this.state,
  });

  final String city;
  final String state;

  @override
  List<Object?> get props => [
        city,
        state,
      ];
}
