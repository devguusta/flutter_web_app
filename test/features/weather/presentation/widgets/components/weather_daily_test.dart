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
      // Create mock daily data with multiple items
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

      // Check for all formatted dates
      for (final day in mockDailyMultiple) {
        final formattedDay = DateFormat('EEEE').format(day.date);
        expect(find.text(formattedDay), findsOneWidget);
      }

      // Check for all formatted temperatures
      for (final day in mockDailyMultiple) {
        final maxTemp = day.maximumTemperature.floor();
        final minTemp = day.minimumTemperature.floor();
        expect(find.text('$maxTemp/$minTemp°C'), findsOneWidget);
      }

      // Check for all weather titles
      expect(find.text('Rain'), findsOneWidget);
      expect(find.text('Clouds'), findsOneWidget);
      expect(find.text('Clear'), findsOneWidget);

      // Check for weather icons
      expect(find.byType(WeatherIcon), findsNWidgets(mockDailyMultiple.length));
    });

    testWidgets('Should format temperatures correctly', (tester) async {
      final edgeCaseData = [
        WeatherDailyDataEntity(
          date: DateTime.now(),
          maximumTemperature: 30.9, // Should show as 30
          minimumTemperature: 20.9, // Should show as 20
          weather: current.weather,
        ),
        WeatherDailyDataEntity(
          date: DateTime.now().add(const Duration(days: 1)),
          maximumTemperature: -5.3, // Should show as -5
          minimumTemperature: -10.7, // Should show as -10
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

      // No elements should be found
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

      // Find all expanded widgets
      final expandedWidgets = find.byType(Expanded);

      // Should have 3 expanded widgets per row (1 day × 3 expanded)
      expect(expandedWidgets, findsNWidgets(daily.length * 3));

      // Check the text alignment of the weather title (should be end-aligned)
      final weatherTextWidgets = tester
          .widgetList<Text>(
            find.text('Rain'),
          )
          .toList();

      expect(weatherTextWidgets.first.textAlign, TextAlign.end);
    });

    testWidgets('Should have proper spacing between list items',
        (tester) async {
      // Create a list with at least 2 items to test separators
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

      // Find the separator widgets
      final separators = find.byType(SizedBox);

      // Should have separators between each item
      expect(separators, findsNWidgets(mockMultipleDaily.length - 1));

      // Check the height of the separators
      final sizedBoxes = tester.widgetList<SizedBox>(separators);
      for (final sizedBox in sizedBoxes) {
        expect(sizedBox.height, 8);
      }
    });
  });

  group('WeatherDailyList - Date formatting', () {
    testWidgets('Should format dates correctly using intl package',
        (tester) async {
      // Create date test cases covering different days of the week
      final testDates = [
        DateTime(2023, 1, 1), // Sunday
        DateTime(2023, 1, 2), // Monday
        DateTime(2023, 1, 7), // Saturday
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

      // Check that the dates are formatted correctly
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
