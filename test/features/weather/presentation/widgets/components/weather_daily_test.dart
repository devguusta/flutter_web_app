import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/core/theme/theme.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather.dart';
import 'package:flutter_web_app/features/weather/domain/entities/weather_daily_data_entity.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_daily.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/icons/weather_icon.dart';
import 'package:intl/intl.dart';
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

  group('WeatherDailyList - UI rendering', () {
    testWidgets('Should render all days in the list correctly', (tester) async {
      final mockDailyMultiple = [
        ...daily,
        WeatherDailyDataEntity(
          date: DateTime.fromMillisecondsSinceEpoch(1685037600 * 1000),
          minimumTemperature: 292.5,
          maximumTemperature: 302.1,
          weather: const Weather(
            title: "Clouds",
            icon: "04d",
          ),
        ),
        WeatherDailyDataEntity(
          date: DateTime.fromMillisecondsSinceEpoch(1685124000 * 1000),
          minimumTemperature: 288.3,
          maximumTemperature: 298.7,
          weather: const Weather(
            title: "Clear",
            icon: "01d",
          ),
        ),
      ];

      await mockNetworkImagesFor(() => tester.pumpWidget(
            buildTestableWidget(
              WeatherDailyList(
                daily: mockDailyMultiple,
              ),
            ),
          ));
      await tester.pumpAndSettle();

      for (final day in mockDailyMultiple) {
        final formattedDay = DateFormat('EEEE').format(day.date);
        expect(find.text(formattedDay), findsOneWidget);
      }

      for (final day in mockDailyMultiple) {
        final maxTemp = day.maximumTemperature.floor();
        final minTemp = day.minimumTemperature.floor();
        expect(find.text('$maxTemp/$minTemp°C'), findsOneWidget);
      }

      expect(find.text('Rain'), findsOneWidget);
      expect(find.text('Clouds'), findsOneWidget);
      expect(find.text('Clear'), findsOneWidget);

      expect(find.byType(WeatherIcon), findsNWidgets(mockDailyMultiple.length));
    });

    testWidgets('Should format temperatures correctly', (tester) async {
      final edgeCaseData = [
        WeatherDailyDataEntity(
          date: DateTime.now(),
          maximumTemperature: 30.9,
          minimumTemperature: 20.9,
          weather: current.weather,
        ),
        WeatherDailyDataEntity(
          date: DateTime.now().add(const Duration(days: 1)),
          maximumTemperature: -5.3,
          minimumTemperature: -10.7,
          weather: const Weather(
            title: 'Snow',
            icon: '13d',
          ),
        ),
      ];

      await mockNetworkImagesFor(() => tester.pumpWidget(
            buildTestableWidget(
              WeatherDailyList(
                daily: edgeCaseData,
              ),
            ),
          ));
      await tester.pumpAndSettle();

      expect(find.text('30/20°C'), findsOneWidget);
      expect(find.text('-5/-10°C'), findsOneWidget);
    });

    testWidgets('Should handle empty list gracefully', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
            buildTestableWidget(
              const WeatherDailyList(
                daily: [],
              ),
            ),
          ));
      await tester.pumpAndSettle();

      expect(find.byType(Row), findsNothing);
      expect(find.byType(WeatherIcon), findsNothing);
    });
  });

  group('WeatherDailyList - Layout', () {
    testWidgets('Should use correct layout with expanded widgets',
        (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
            buildTestableWidget(
              WeatherDailyList(
                daily: daily,
              ),
            ),
          ));
      await tester.pumpAndSettle();

      final expandedWidgets = find.byType(Expanded);

      expect(expandedWidgets, findsNWidgets(daily.length * 3));

      final weatherTextWidgets = tester
          .widgetList<Text>(
            find.text('Rain'),
          )
          .toList();

      expect(weatherTextWidgets.first.textAlign, TextAlign.end);
    });

    testWidgets('Should have proper spacing between list items',
        (tester) async {
      final mockMultipleDaily = [
        ...daily,
        WeatherDailyDataEntity(
          date: DateTime.now().add(const Duration(days: 1)),
          minimumTemperature: 291.5,
          maximumTemperature: 301.2,
          weather: current.weather,
        ),
      ];

      await mockNetworkImagesFor(() => tester.pumpWidget(
            buildTestableWidget(
              WeatherDailyList(
                daily: mockMultipleDaily,
              ),
            ),
          ));
      await tester.pumpAndSettle();

      final separators = find.byType(SizedBox);

      expect(separators, findsNWidgets(mockMultipleDaily.length - 1));

      final sizedBoxes = tester.widgetList<SizedBox>(separators);
      for (final sizedBox in sizedBoxes) {
        expect(sizedBox.height, 8);
      }
    });
  });

  group('WeatherDailyList - Date formatting', () {
    testWidgets('Should format dates correctly using intl package',
        (tester) async {
      final testDates = [
        DateTime(2023, 1, 1),
        DateTime(2023, 1, 2),
        DateTime(2023, 1, 7),
      ];

      final dateFormattedData = testDates
          .map((date) => WeatherDailyDataEntity(
                date: date,
                maximumTemperature: 25.0,
                minimumTemperature: 18.0,
                weather: current.weather,
              ))
          .toList();

      await mockNetworkImagesFor(() => tester.pumpWidget(
            buildTestableWidget(
              WeatherDailyList(
                daily: dateFormattedData,
              ),
            ),
          ));
      await tester.pumpAndSettle();

      for (final date in testDates) {
        final formattedDate = DateFormat('EEEE').format(date);
        expect(find.text(formattedDate), findsOneWidget);
      }

      expect(find.text('Sunday'), findsOneWidget);
      expect(find.text('Monday'), findsOneWidget);
      expect(find.text('Saturday'), findsOneWidget);
    });
  });
}
