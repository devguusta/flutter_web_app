import 'package:flutter/material.dart';
import 'package:flutter_web_app/core/theme/colors.dart';
import 'package:flutter_web_app/core/theme/custom_text_styles.dart';
import 'package:flutter_web_app/core/theme/sizes.dart';
import 'package:flutter_web_app/core/theme/theme.dart';

extension CustomThemeExtension on BuildContext {
  CustomTheme get customTheme {
    return Theme.of(this).extension<CustomTheme>()!;
  }

  CustomColors get colors {
    return Theme.of(this).extension<CustomTheme>()!.colors;
  }

  CustomSizes get sizes {
    return Theme.of(this).extension<CustomTheme>()!.sizes;
  }

  CustomTextStyles get textStyles {
    return Theme.of(this).extension<CustomTheme>()!.textStyles;
  }
}
