import 'package:flutter/material.dart';

/// Espaçamentos e raios extraídos dos mocks Stitch.
abstract final class StreamingTokens {
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;

  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;

  static const double miniPlayerHeight = 56;
  static const double bottomNavHeight = 72;
  static const double categoryCardHeight = 96;
  static const double trackArtSize = 56;
  static const double horizontalCarouselItemWidth = 140;

  static BorderRadius get cardRadius => BorderRadius.circular(radiusMd);
  static BorderRadius get sheetRadius =>
      const BorderRadius.vertical(top: Radius.circular(radiusXl));
}
