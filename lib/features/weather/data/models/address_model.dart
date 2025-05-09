import 'package:flutter_web_app/features/weather/domain/entities/address_entity.dart';

final class AddressModel {
  final String city;
  final String state;
  const AddressModel({
    required this.city,
    required this.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['address']['city'],
      state: json['address']['state'],
    );
  }

  AddressEntity toEntity() {
    return AddressEntity(
      city: city,
      state: state,
    );
  }
}
