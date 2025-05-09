import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/core/theme/theme.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_appbar.dart';
import 'package:network_image_mock/network_image_mock.dart';

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

  group('WeatherAppBar - UI elements', () {
    testWidgets('Should render app bar with correct title', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
            buildTestableWidget(
              const WeatherAppBar(),
            ),
          ));
      await tester.pumpAndSettle();

      expect(find.text('Open Weather'), findsOneWidget);

      expect(
        find.byWidgetPredicate((widget) => widget is SliverAppBar),
        findsOneWidget,
      );
      final appBarFinder = find.byType(SliverAppBar);
      expect(appBarFinder, findsOneWidget);

      final SliverAppBar appBar = tester.widget(appBarFinder);

      expect(appBar.snap, isTrue);
      expect(appBar.floating, isTrue);
      expect(appBar.pinned, isFalse);
      expect(appBar.expandedHeight, isNull);
    });
  });

  group('WeatherAppBar - properties', () {
    testWidgets('Should have correct SliverAppBar properties', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
            buildTestableWidget(
              const WeatherAppBar(),
            ),
          ));
      await tester.pumpAndSettle();

      final appBarFinder = find.byType(SliverAppBar);
      expect(appBarFinder, findsOneWidget);

      final SliverAppBar appBar = tester.widget(appBarFinder);

      expect(appBar.snap, isTrue);
      expect(appBar.floating, isTrue);
      expect(appBar.pinned, isFalse);
      expect(appBar.expandedHeight, isNull);
    });
  });
}
