import 'package:flutter/material.dart';
import 'package:flutter_web_app/core/presentation/layout_size_builder.dart';

/// A widget that constrains its child to a specific layout size.
/// It uses the [LayoutSize] class to determine the minimum width of the child.
/// This is useful for responsive design, where you want to ensure that
/// the child does not exceed a certain width based on the layout size.

class CustomConstrainedBox extends StatelessWidget {
  const CustomConstrainedBox({
    required this.layoutSize,
    required this.child,
    super.key,
  });

  final LayoutSize layoutSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(
          Size.fromWidth(layoutSize.minimumWidth),
        ),
        child: child,
      ),
    );
  }
}
