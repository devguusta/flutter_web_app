import 'package:flutter/material.dart';
import 'package:flutter_web_app/features/weather/domain/entities/address_entity.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_data_entity.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/icons/icon_list.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/icons/weather_icon.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/icons/wind_icon.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    required this.current,
    this.address,
    super.key,
  });

  final WeatherDataEntity current;
  final AddressEntity? address;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: [
      const SliverToBoxAdapter(
        child: Text(
          'Now',
          style: TextStyle(fontSize: 20),
        ),
      ),
      const SliverPadding(
        padding: EdgeInsets.only(bottom: 8),
      ),
      if (address != null)
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              '${address!.city}, ${address!.state}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${current.temperature}°C',
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
                Flexible(
                  child: WeatherIcon(
                    size: 64,
                    icon: current.weather.icon,
                  ),
                ),
              ],
            ),
            IconListItem(
              icon: const Icon(Icons.water_drop_outlined),
              label: 'Humidity: ${current.humidity}%',
            ),
            IconListItem(
              icon: const Icon(Icons.thermostat_outlined),
              label: 'Pressure: ${current.pressure}hPa',
            ),
            IconListItem(
              icon: WindIcon(
                degrees: current.windDegrees,
              ),
              label: '${current.windSpeed}m/s',
            ),
          ],
        ),
      ),
    ]);
  }
}
