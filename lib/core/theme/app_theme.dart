import 'package:flutter/material.dart';
import 'color_palette.dart';

ThemeData buildIponTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: IponColors.bgVoid,
    primaryColor: IponColors.frameOuter,
    colorScheme: const ColorScheme.dark(
      primary: IponColors.frameOuter,
      secondary: IponColors.accentActive,
      surface: IponColors.bgIndigo,
      error: IponColors.danger,
      onPrimary: IponColors.textPrimary,
      onSecondary: IponColors.textPrimary,
      onSurface: IponColors.textPrimary,
      onError: IponColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: IponColors.bgVoid,
      foregroundColor: IponColors.textPrimary,
      elevation: 0,
    ),
    useMaterial3: true,
  );
}
