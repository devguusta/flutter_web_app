import 'package:flutter/material.dart';

/// An enum representing different layout sizes for a responsive design.
/// Each layout size has a minimum width that determines when it is applied.
/// The sizes are defined as follows:
/// - desktop: 1024 pixels
/// - tablet: 768 pixels
/// - mobile: 480 pixels
enum LayoutSize {
  desktop(1024),
  tablet(768),
  mobile(480);

  const LayoutSize(this.minimumWidth);

  final double minimumWidth;
}

/// A widget that builds its child based on the current layout size.
/// It uses the [LayoutSize] enum to determine the layout size based on the
/// width of the screen.
/// The builder function is called with the current layout size, allowing
/// the child to be built accordingly.
class LayoutSizeBuilder extends StatelessWidget {
  const LayoutSizeBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(LayoutSize breakpoint) builder;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    LayoutSize layoutSize;
    if (size.width < LayoutSize.tablet.minimumWidth) {
      layoutSize = LayoutSize.mobile;
    } else if (size.width < LayoutSize.desktop.minimumWidth) {
      layoutSize = LayoutSize.tablet;
    } else {
      layoutSize = LayoutSize.desktop;
    }
    return builder(layoutSize);
  }
}
