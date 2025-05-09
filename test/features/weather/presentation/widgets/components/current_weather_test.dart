import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/core/theme/theme.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/current_weather.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/icons/icon_list.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/icons/weather_icon.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/icons/wind_icon.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../../mocks/weather_mock.dart';

void main() {
  final mockWeatherData = current;

  final mockAddress = address;

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

  group('CurrentWeather - with address', () {
    testWidgets('Should render all UI elements correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          buildTestableWidget(
            CurrentWeather(
              current: mockWeatherData,
              address: mockAddress,
            ),
          ),
        );
      });
      await tester.pumpAndSettle();

      expect(find.text('Now'), findsOneWidget);

      expect(find.text('NOVA IGUACU, RJ'), findsOneWidget);

      expect(find.text('292.55°C'), findsOneWidget);

      expect(
        find.byWidgetPredicate((widget) =>
            widget is WeatherIcon &&
            widget.icon == mockWeatherData.weather.icon &&
            widget.size == 64),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate((widget) =>
            widget is IconListItem && widget.label == 'Humidity: 89%'),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate((widget) =>
            widget is IconListItem && widget.label == 'Pressure: 1014hPa'),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
            (widget) => widget is IconListItem && widget.label == '3.13m/s'),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
            (widget) => widget is WindIcon && widget.degrees == 93),
        findsOneWidget,
      );
    });
  });

  group('CurrentWeather - without address', () {
    testWidgets('Should not display location when address is null',
        (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          buildTestableWidget(
            CurrentWeather(
              current: mockWeatherData,
              address: mockAddress,
            ),
          ),
        );
      });
      await tester.pumpAndSettle();

      expect(find.text('Now'), findsOneWidget);

      expect(find.text('292.55°C'), findsOneWidget);

      expect(
        find.byWidgetPredicate((widget) =>
            widget is WeatherIcon &&
            widget.icon == mockWeatherData.weather.icon &&
            widget.size == 64),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate((widget) =>
            widget is IconListItem && widget.label == 'Humidity: 89%'),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate((widget) =>
            widget is IconListItem && widget.label == 'Pressure: 1014hPa'),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
            (widget) => widget is IconListItem && widget.label == '3.13m/s'),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
            (widget) => widget is WindIcon && widget.degrees == 93),
        findsOneWidget,
      );
    });
  });
}
