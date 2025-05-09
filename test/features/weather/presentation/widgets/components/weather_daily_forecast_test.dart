import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/core/theme/theme.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_daily.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_daily_forecast.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../../mocks/weather_mock.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: CustomTheme.themeData,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [child],
        ),
      ),
    );
  }

  group('SliverDailyForecastBlock - UI rendering', () {
    testWidgets('Should render forecast items correctly', (tester) async {
      final mockDailyMultiple = [
        ...daily,
        WeatherDailyDataEntity(
          date: DateTime.fromMillisecondsSinceEpoch(1685037600 * 1000),
          minimumTemperature: 292.5,
          maximumTemperature: 302.1,
          weather: current.weather,
        ),
      ];

      await mockNetworkImagesFor(() => tester.pumpWidget(
            buildTestableWidget(
              SliverDailyForecastBlock(
                daily: mockDailyMultiple,
              ),
            ),
          ));
      await tester.pumpAndSettle();

      expect(find.text('8-day forecast'), findsOneWidget);

      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is SliverPadding &&
                widget.padding == EdgeInsets.only(bottom: 8),
          ),
          findsOneWidget);
      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is WeatherDailyList && widget.daily == mockDailyMultiple,
          ),
          findsOneWidget);
    });
  });
}
