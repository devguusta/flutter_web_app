import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/core/presentation/button/custom_button.dart';
import 'package:flutter_web_app/core/theme/theme.dart';
import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';
import 'package:flutter_web_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:flutter_web_app/features/weather/presentation/cubit/weather_state.dart';
import 'package:flutter_web_app/features/weather/presentation/pages/weather_page.dart';
import 'package:flutter_web_app/features/weather/presentation/utils/location_error_title.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/current_weather.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_appbar.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_daily.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_forecast_chart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../mocks/mock_class.dart';
import '../../../../mocks/weather_mock.dart';

void main() {
  final cubit = WeatherCubitMock();
  tearDown(() {
    cubit.close();
  });

  setUp(() {
    whenListen<WeatherState>(
      cubit,
      Stream.empty(),
      initialState: WeatherInitialState(),
    );
  });
  Widget buildTestableWidget({Size? size}) {
    return MaterialApp(
      theme: CustomTheme.themeData,
      home: MediaQuery(
        data: MediaQueryData(
          size: size ?? const Size(800, 600),
          devicePixelRatio: 1.0,
        ),
        child: BlocProvider<WeatherCubit>(
          create: (context) => cubit,
          child: const WeatherPage(),
        ),
      ),
    );
  }

  group('Weather page - interface', () {
    testWidgets('Should render loading interface', (tester) async {
      whenListen<WeatherState>(
        cubit,
        Stream.empty(),
        initialState: WeatherLoadingState(),
      );
      when(() => cubit.getWeather()).thenAnswer((_) async => {});

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should render error interface', (tester) async {
      whenListen<WeatherState>(
        cubit,
        Stream.empty(),
        initialState: WeatherFailureState(),
      );
      when(() => cubit.getWeather()).thenAnswer((_) async => {});

      await tester.pumpWidget(buildTestableWidget());

      expect(
          find.text('An error have ocurred. Please Try again'), findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is CustonPrimaryButton && widget.title == "Try again"),
          findsOneWidget);
    });

    testWidgets(
        'Should render error interface when state is WeatherLocationFailureState ',
        (tester) async {
      final error = GpsDisabledException();
      whenListen<WeatherState>(
        cubit,
        Stream.empty(),
        initialState: WeatherLocationFailureState(error: error),
      );
      when(() => cubit.getWeather()).thenAnswer((_) async => {});

      await tester.pumpWidget(buildTestableWidget());

      expect(find.text(LocationErrorTitle.getTitle(error)), findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is CustonPrimaryButton && widget.title == "Try again"),
          findsOneWidget);
    });
    testWidgets(
        'Should render success interface when state is WeatherLoadedState - mobile',
        (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      tester.view.resetPhysicalSize();

      whenListen<WeatherState>(
        cubit,
        Stream.empty(),
        initialState: WeatherLoadedState(
          weatherReport: weatherStatusReport,
          address: address,
        ),
      );
      when(() => cubit.getWeather()).thenAnswer((_) async => {});

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildTestableWidget(
          size: const Size(400, 800),
        ));
      });
      expect(
        find.byType(WeatherAppBar),
        findsOneWidget,
      );
      expect(
          find.descendant(
              of: find.byType(CustomScrollView),
              matching: find.byType(WeatherDailyList)),
          findsOneWidget,
          reason: 'Should find WeatherDailyList inside CustomScrollView');
    });

    testWidgets(
        'Should render success interface when state is WeatherLoadedState - tablet',
        (tester) async {
      tester.view.physicalSize = const Size(800, 800);
      tester.view.devicePixelRatio = 1.0;
      tester.view.resetPhysicalSize();

      whenListen<WeatherState>(
        cubit,
        Stream.empty(),
        initialState: WeatherLoadedState(
          weatherReport: weatherStatusReport,
          address: address,
        ),
      );
      when(() => cubit.getWeather()).thenAnswer((_) async => {});

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildTestableWidget(
          size: const Size(800, 800),
        ));
      });

      await tester.pumpAndSettle();

      expect(
          find.descendant(
              of: find.byType(CustomScrollView),
              matching: find.byType(WeatherDailyList)),
          findsOneWidget,
          reason: 'Should find WeatherDailyList inside CustomScrollView');

      expect(
        find.byWidgetPredicate((widget) =>
            widget is CurrentWeather &&
            widget.current == weatherStatusReport.current &&
            widget.address == address),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((widget) => widget is WeatherForecastChart),
        findsOneWidget,
      );
      expect(
        find.byType(WeatherAppBar),
        findsOneWidget,
      );
    });

    testWidgets(
        'Should render success interface when state is WeatherLoadedState - desktop',
        (tester) async {
      tester.view.physicalSize = const Size(1220, 1220);
      tester.view.devicePixelRatio = 1.0;
      tester.view.resetPhysicalSize();

      whenListen<WeatherState>(
        cubit,
        Stream.empty(),
        initialState: WeatherLoadedState(
          weatherReport: weatherStatusReport,
          address: address,
        ),
      );
      when(() => cubit.getWeather()).thenAnswer((_) async => {});

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildTestableWidget(
          size: const Size(1220, 1450),
        ));
      });

      await tester.pumpAndSettle();
      expect(
        find.byType(WeatherAppBar),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((widget) =>
            widget is SliverCrossAxisExpanded &&
            widget.child is CurrentWeather &&
            widget.flex == 1),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((widget) =>
            widget is SliverPadding && widget.child is WeatherForecastChart),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate((widget) => widget is WeatherForecastChart),
        findsOneWidget,
      );
    });
  });
}
