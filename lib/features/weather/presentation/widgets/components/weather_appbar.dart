import 'package:flutter/material.dart';

/// This widget is used to display the app bar for the weather page.
/// It is a [SliverAppBar].
class WeatherAppBar extends StatelessWidget {
  const WeatherAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      title: Text('Open Weather'),
      snap: true,
      floating: true,
    );
  }
}
