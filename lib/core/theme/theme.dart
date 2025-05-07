import 'package:flutter/material.dart';
import 'package:flutter_web_app/core/theme/colors.dart';
import 'package:flutter_web_app/core/theme/custom_text_styles.dart';
import 'package:flutter_web_app/core/theme/sizes.dart';

class CustomTheme extends ThemeExtension<CustomTheme> {
  final CustomColors colors;
  final CustomSizes sizes;
  final CustomTextStyles textStyles;

  const CustomTheme({
    required this.colors,
    required this.sizes,
    required this.textStyles,
  });

  @override
  ThemeExtension<CustomTheme> copyWith({
    CustomColors? colors,
    CustomSizes? sizes,
    CustomTextStyles? textStyles,
  }) {
    return CustomTheme(
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      textStyles: textStyles ?? this.textStyles,
    );
  }

  @override
  ThemeExtension<CustomTheme> lerp(
      ThemeExtension<CustomTheme>? other, double t) {
    if (other is! CustomTheme) {
      return this;
    }
    return this;
  }

  static final _theme = CustomTheme(
    colors: CustomColors(),
    sizes: CustomSizes(),
    textStyles: CustomTextStyles(
      sizes: CustomSizes(),
      colors: CustomColors(),
    ),
  );

  static final themeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
  ).copyWith(
    textTheme: const TextTheme().apply(
      bodyColor: _theme.colors.white,
    ),
    scaffoldBackgroundColor: _theme.colors.background,
    cardTheme: CardTheme(
      surfaceTintColor: _theme.colors.black87,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: _theme.colors.black,
      labelTextStyle: WidgetStatePropertyAll(
        _theme.textStyles.body,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: _theme.colors.blue,
      selectedItemColor: _theme.colors.amber,
      backgroundColor: _theme.colors.background,
    ),
    dialogBackgroundColor: _theme.colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: _theme.colors.background,
      titleTextStyle: _theme.textStyles.heading4.copyWith(
        color: _theme.colors.primary,
        fontWeight: FontWeight.w800,
      ),
      actionsIconTheme: IconThemeData(
        color: _theme.colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          _theme.colors.blue300,
        ),
        backgroundColor: WidgetStateProperty.all(
          _theme.colors.black87,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: _theme.colors.primary,
        ),
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: _theme.colors.primary,
      secondary: _theme.colors.secondary,
      inversePrimary: _theme.colors.white,
      tertiary: const Color(0xffC1FD72),
      outline: _theme.colors.blue.withOpacity(0.5),
    ),
    extensions: <ThemeExtension<dynamic>>[_theme],
  );
}
