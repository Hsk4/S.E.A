// ─────────────────────────────────────────────────────────────────────────
// app_typography.dart
// AUTO-GENERATED — do not edit manually.
// Source: packages/shared/src/tokens.ts → typography
// Generated: 2026-05-31T17:39:03.438Z
// Run `pnpm generate:tokens` to regenerate.
// ─────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

class AppTypography {

  AppTypography._();

  // Font sizes
  static const double fontSizeXs = 8;
  static const double fontSizeSm = 9;
  static const double fontSizeBase = 10;
  static const double fontSizeMd = 11;
  static const double fontSizeLg = 12;
  static const double fontSizeXl = 13;
  static const double fontSizeS2xl = 15;
  static const double fontSizeS3xl = 16;
  static const double fontSizeS4xl = 20;
  static const double fontSizeS5xl = 26;
  static const double fontSizeS6xl = 32;

  // Font weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;

  // Line heights
  static const double lineHeightTight = 1.3;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.7;

  // Letter spacing
  static const double letterSpacingTight = -0.2;
  static const double letterSpacingNormal = 0;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingWider = 0.8;

  // Preset TextStyles
  static const TextStyle labelXs = TextStyle(fontSize: fontSizeXs, fontWeight: regular);
  static const TextStyle labelSm = TextStyle(fontSize: fontSizeSm, fontWeight: regular);
  static const TextStyle body = TextStyle(fontSize: fontSizeMd, fontWeight: regular, height: lineHeightNormal);
  static const TextStyle bodyMedium = TextStyle(fontSize: fontSizeMd, fontWeight: medium);
  static const TextStyle label = TextStyle(fontSize: fontSizeLg, fontWeight: regular);
  static const TextStyle labelMedium = TextStyle(fontSize: fontSizeLg, fontWeight: medium);
  static const TextStyle title = TextStyle(fontSize: fontSizeXl, fontWeight: medium);
  static const TextStyle sectionHeader = TextStyle(fontSize: fontSizeS2xl, fontWeight: medium);
  static const TextStyle statValue = TextStyle(fontSize: fontSizeS4xl, fontWeight: medium);
  static const TextStyle countdown = TextStyle(fontSize: fontSizeS5xl, fontWeight: medium);
  static const TextStyle badgeLabel = TextStyle(fontSize: fontSizeSm, fontWeight: medium, letterSpacing: letterSpacingWide);
  static const TextStyle sectionTag = TextStyle(fontSize: fontSizeSm, fontWeight: regular, letterSpacing: letterSpacingWider);

}