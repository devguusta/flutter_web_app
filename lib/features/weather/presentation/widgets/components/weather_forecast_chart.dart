import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_app/core/theme/theme_extensions.dart';
import 'package:flutter_web_app/features/weather/domain/entities/entities.dart';

class WeatherForecastChart extends StatefulWidget {
  const WeatherForecastChart({
    super.key,
    required this.forecast,
    this.animate = true,
    this.animationDuration = const Duration(seconds: 1),
    this.height = 200,
    this.padding = const EdgeInsets.all(16.0),
  });

  final List<WeatherDataEntity> forecast;
  final bool animate;
  final Duration animationDuration;
  final double height;
  final EdgeInsetsGeometry padding;

  @override
  State<WeatherForecastChart> createState() => _WeatherForecastChartState();
}

class _WeatherForecastChartState extends State<WeatherForecastChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _lineAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
    );

    _lineAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
    );

    if (widget.animate) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _animationController.forward();
        }
      });
    } else {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    return SliverToBoxAdapter(
      child: Container(
        height: widget.height,
        padding: widget.padding,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final dataCount = widget.forecast.isEmpty
                ? 0
                : (_lineAnimation.value * widget.forecast.length)
                    .round()
                    .clamp(0, widget.forecast.length);
            final List<WeatherDataEntity> visibleData =
                dataCount > 0 ? widget.forecast.take(dataCount).toList() : [];

            return FadeTransition(
              opacity: _fadeAnimation,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 5,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: textColor.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              '${value.toInt()}°',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: dataCount > 0 ? dataCount - 1.0 : 0,
                  minY: _getMinY(visibleData),
                  maxY: _getMaxY(visibleData),
                  lineTouchData: LineTouchData(
                    enabled: dataCount > 0,
                    touchTooltipData: LineTouchTooltipData(
                      //    getTooltipColor: context.colors.secondary.withOpacity(0.8),
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final index = spot.x.toInt();
                          if (index >= 0 && index < visibleData.length) {
                            return LineTooltipItem(
                              '${visibleData[index].temperature.toStringAsFixed(1)}°',
                              TextStyle(
                                color: context.colors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                          return null;
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: dataCount > 0
                      ? [
                          LineChartBarData(
                            spots: _createSpots(visibleData),
                            isCurved: true,
                            color: context.colors.primary,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: context.colors.primary,
                                  strokeWidth: 0,
                                );
                              },
                              checkToShowDot: (spot, barData) {
                                return spot.x == 0 ||
                                    spot.x == visibleData.length - 1;
                              },
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: context.colors.primary.withOpacity(0.2),
                            ),
                          ),
                        ]
                      : [],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<FlSpot> _createSpots(List<WeatherDataEntity> data) {
    return List.generate(
      data.length,
      (index) => FlSpot(index.toDouble(), data[index].temperature),
    );
  }

  double _getMinY(List<WeatherDataEntity> data) {
    if (data.isEmpty) return 0;
    final min = data.map((e) => e.temperature).reduce((a, b) => a < b ? a : b);
    // Round down to the nearest 5
    return (min / 5).floor() * 5.0;
  }

  double _getMaxY(List<WeatherDataEntity> data) {
    if (data.isEmpty) return 0;
    final max = data.map((e) => e.temperature).reduce((a, b) => a > b ? a : b);
    // Round up to the nearest 5
    return (max / 5).ceil() * 5.0;
  }
}
