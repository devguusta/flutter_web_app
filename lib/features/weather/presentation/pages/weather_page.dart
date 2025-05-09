import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_app/core/presentation/button/custom_button.dart';
import 'package:flutter_web_app/core/presentation/custom_constrained_box.dart';
import 'package:flutter_web_app/core/presentation/layout_break_builder.dart';
import 'package:flutter_web_app/features/weather/domain/entities/entities.dart';
import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';
import 'package:flutter_web_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:flutter_web_app/features/weather/presentation/cubit/weather_state.dart';
import 'package:flutter_web_app/features/weather/presentation/utils/location_error_title.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/current_weather.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_appbar.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_daily.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_daily_forecast.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/components/weather_forecast_chart.dart';
import 'package:flutter_web_app/features/weather/presentation/widgets/dialogs/location_erros_dialog.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  void _listener(BuildContext context, WeatherState state) {
    if (state is WeatherLocationFailureState) {
      LocationErrorsDialog.show(context: context, exception: state.error);
    }
  }

  void _onTryAgain() {
    context.read<WeatherCubit>().getWeather();
  }

  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: _listener,
        builder: (context, state) {
          return switch (state) {
            WeatherLoadingState() =>
              Center(child: CircularProgressIndicator.adaptive()),
            WeatherLocationFailureState(:final LocationException error) =>
              CustomConstrainedBox(
                layoutSize: LayoutSize.mobile,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(LocationErrorTitle.getTitle(error)),
                      SizedBox(
                        height: 16,
                      ),
                      CustonPrimaryButton(
                        onPressed: _onTryAgain,
                        title: 'Try again',
                      )
                    ],
                  ),
                ),
              ),
            WeatherFailureState() => CustomConstrainedBox(
                layoutSize: LayoutSize.mobile,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('An error have ocurred. Please Try again'),
                      SizedBox(
                        height: 16,
                      ),
                      CustonPrimaryButton(
                        onPressed: _onTryAgain,
                        title: 'Try again',
                      )
                    ],
                  ),
                ),
              ),
            WeatherLoadedState(
              :final WeatherStatusReportEntity weatherReport,
              :final AddressEntity address
            ) =>
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutSizeBuilder(
                  builder: (breakpoint) {
                    final nowBlock = CurrentWeather(
                      current: weatherReport.current,
                      address: address,
                    );

                    final dailyForecastBlock = SliverDailyForecastBlock(
                      daily: weatherReport.daily.take(8).toList(),
                    );
                    return switch (breakpoint) {
                      LayoutSize.mobile => CustomConstrainedBox(
                          layoutSize: LayoutSize.mobile,
                          child: CustomScrollView(
                            slivers: [
                              WeatherDailyList(
                                daily: weatherReport.daily,
                              )
                            ],
                          ),
                        ),
                      LayoutSize.tablet => CustomScrollView(
                          slivers: [
                            SliverCrossAxisGroup(
                              slivers: [
                                nowBlock,
                                WeatherForecastChart(
                                  forecast:
                                      weatherReport.hourly.take(24).toList(),
                                ),
                              ],
                            ),
                            dailyForecastBlock,
                          ],
                        ),
                      LayoutSize.desktop => CustomConstrainedBox(
                          layoutSize: LayoutSize.desktop,
                          child: CustomScrollView(
                            slivers: [
                              WeatherAppBar(),
                              SliverCrossAxisGroup(
                                slivers: [
                                  SliverCrossAxisExpanded(
                                    flex: 1,
                                    sliver: nowBlock,
                                  ),
                                  SliverCrossAxisExpanded(
                                    flex: 2,
                                    sliver: SliverPadding(
                                      padding: const EdgeInsets.only(right: 32),
                                      sliver: WeatherForecastChart(
                                        forecast: weatherReport.hourly
                                            .take(24)
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  SliverCrossAxisExpanded(
                                    flex: 1,
                                    sliver: dailyForecastBlock,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    };
                  },
                ),
              ),
            _ => SizedBox.shrink(
                key: Key('weather_page'),
              ),
          };
        },
      ),
    );
  }
}
