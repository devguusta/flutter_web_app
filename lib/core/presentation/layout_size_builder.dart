import 'package:flutter/material.dart';

/// Represents different layout sizes for responsive design.
///
/// This enum defines breakpoints for different screen sizes, with each size
/// having a minimum width that determines when it should be applied.
enum LayoutSize {
  /// Desktop layout (1024px or wider)
  desktop(1024),

  /// Tablet layout (768px to 1023px)
  tablet(768),

  /// Mobile layout (up to 767px)
  mobile(480);

  const LayoutSize(this.minimumWidth);

  /// The minimum width in pixels for this layout size
  final double minimumWidth;
}

/// A widget that builds different layouts based on screen size.
///
/// This widget determines the current layout size based on the screen width
/// and calls the provided builder function with the appropriate layout size.
class LayoutSizeBuilder extends StatelessWidget {
  /// Builder function that creates a widget based on the determined layout size
  final Widget Function(LayoutSize breakpoint) builder;

  const LayoutSizeBuilder({
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    LayoutSize layoutSize;

    // Determine the appropriate layout size based on screen width
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
