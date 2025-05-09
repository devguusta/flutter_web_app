import 'package:flutter/material.dart';
import 'package:flutter_web_app/core/constants/assets_constants.dart';
import 'package:flutter_web_app/core/presentation/custom_constrained_box.dart';
import 'package:flutter_web_app/core/presentation/layout_break_builder.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final ValueNotifier<double> _opacity = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();

      Future.delayed(const Duration(milliseconds: 1200), () {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, '/login');
      });
    });
  }

  @override
  void dispose() {
    _opacity.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _opacity.value = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomConstrainedBox(
        layoutSize: LayoutSize.mobile,
        child: Center(
          child: ValueListenableBuilder<double>(
            valueListenable: _opacity,
            builder: (context, value, child) {
              return AnimatedOpacity(
                opacity: value,
                duration: const Duration(milliseconds: 1200),
                child: Image.asset(
                  AssetsConstants.logoApp,
                  width: 100,
                  height: 100,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
