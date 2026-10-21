
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/app_theme_mode.dart';
import 'package:hiddify/core/theme/theme_extensions.dart';

class AppTheme {
  AppTheme(this.mode, this.fontFamily);

  final AppThemeMode mode;
  final String fontFamily;

  static const Color gamingBlue = Color(0xFF168BFF);
  static const Color gamingBackground = Color(0xFF070B14);
  static const Color gamingSurface = Color(0xFF101827);

  ColorScheme _gamingScheme(Brightness brightness) {
    return ColorScheme.fromSeed(
      seedColor: gamingBlue,
      brightness: brightness,
      surface: brightness == Brightness.dark
          ? gamingSurface
          : const Color(0xFFF5F8FF),
    );
  }

  ThemeData lightTheme(ColorScheme? lightColorScheme) {
    final scheme = _gamingScheme(Brightness.light).copyWith(
      primary: gamingBlue,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme ?? scheme,
      fontFamily: fontFamily,
      extensions: const <ThemeExtension<dynamic>>{
        ConnectionButtonTheme.light,
      },
    );
  }

  ThemeData darkTheme(ColorScheme? darkColorScheme) {
    final scheme = _gamingScheme(Brightness.dark).copyWith(
      primary: gamingBlue,
      secondary: const Color(0xFF00C8FF),
      surface: gamingSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme ?? scheme,
      scaffoldBackgroundColor: mode.trueBlack
          ? Colors.black
          : gamingBackground,
      fontFamily: fontFamily,
      extensions: const <ThemeExtension<dynamic>>{
        ConnectionButtonTheme.light,
      },
    );
  }

  CupertinoThemeData cupertinoThemeData(
    bool sysDark,
    ColorScheme? lightColorScheme,
    ColorScheme? darkColorScheme,
  ) {
    final bool isDark = switch (mode) {
      AppThemeMode.system => sysDark,
      AppThemeMode.light => false,
      AppThemeMode.dark => true,
      AppThemeMode.black => true,
    };

    final def = CupertinoThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: gamingBlue,
    );

    final defaultMaterialTheme = isDark
        ? darkTheme(darkColorScheme)
        : lightTheme(lightColorScheme);

    return MaterialBasedCupertinoThemeData(
      materialTheme: defaultMaterialTheme.copyWith(
        cupertinoOverrideTheme: def.copyWith(
          textTheme: CupertinoTextThemeData(
            textStyle: def.textTheme.textStyle.copyWith(
              fontFamily: fontFamily,
            ),
            actionTextStyle: def.textTheme.actionTextStyle.copyWith(
              fontFamily: fontFamily,
            ),
            navActionTextStyle: def.textTheme.navActionTextStyle.copyWith(
              fontFamily: fontFamily,
            ),
            navTitleTextStyle: def.textTheme.navTitleTextStyle.copyWith(
              fontFamily: fontFamily,
            ),
            navLargeTitleTextStyle: def.textTheme.navLargeTitleTextStyle.copyWith(
              fontFamily: fontFamily,
            ),
            pickerTextStyle: def.textTheme.pickerTextStyle.copyWith(
              fontFamily: fontFamily,
            ),
            dateTimePickerTextStyle: def.textTheme.dateTimePickerTextStyle.copyWith(
              fontFamily: fontFamily,
            ),
            tabLabelTextStyle: def.textTheme.tabLabelTextStyle.copyWith(
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
