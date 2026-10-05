import 'package:flutter/material.dart';
import 'color_palette.dart';

class IponTypography {
  IponTypography._();

  static const String orbitron = 'Orbitron';
  static const String rajdhani = 'Rajdhani';
  static const String jetbrainsMono = 'JetBrainsMono';

  static const TextStyle windowTitle = TextStyle(
    fontFamily: orbitron,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: 3.0,
    color: IponColors.textPrimary,
  );

  static const TextStyle header = TextStyle(
    fontFamily: rajdhani,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    letterSpacing: 2.0,
    color: IponColors.textPrimary,
  );

  static const TextStyle label = TextStyle(
    fontFamily: rajdhani,
    fontWeight: FontWeight.w500,
    fontSize: 13,
    letterSpacing: 1.5,
    color: IponColors.textSecondary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: rajdhani,
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: IponColors.textSecondary,
  );

  static const TextStyle bigNumber = TextStyle(
    fontFamily: jetbrainsMono,
    fontWeight: FontWeight.w700,
    fontSize: 48,
    color: IponColors.textPrimary,
  );

  static const TextStyle value = TextStyle(
    fontFamily: jetbrainsMono,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: IponColors.textPrimary,
  );
}
