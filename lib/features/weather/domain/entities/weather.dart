import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather({
    required this.title,
    required this.icon,
  });

  final String title;
  final String icon;

  @override
  List<Object?> get props => [
        title,
        icon,
      ];
}
