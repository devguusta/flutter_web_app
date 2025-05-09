import 'package:flutter/material.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_daily.dart';

class SliverDailyForecastBlock extends StatelessWidget {
  const SliverDailyForecastBlock({
    super.key,
    required this.daily,
  });

  final List<WeatherDailyDataEntity> daily;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        const SliverToBoxAdapter(
          child: Text(
            '8-day forecast',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 8)),
        WeatherDailyList(
          daily: daily,
        ),
      ],
    );
  }
}
