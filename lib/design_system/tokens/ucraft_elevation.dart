import 'package:flutter/widgets.dart';

/// Border widths and elevation shadow tokens for uCraft Design System 1.0.
abstract final class UcraftElevation {
  static const double borderDefault = 1.0;
  static const double borderStrong = 1.5;
  static const double borderFocus = 2.0;
  static const double dividerWidth = 1.0;

  static const List<BoxShadow> level0 = [];

  static const List<BoxShadow> level1 = [
    BoxShadow(color: Color(0x0D000000), offset: Offset(0, 2), blurRadius: 8),
  ];

  static const List<BoxShadow> level2 = [
    BoxShadow(color: Color(0x14000000), offset: Offset(0, 6), blurRadius: 20),
  ];

  static const List<BoxShadow> level3 = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 12), blurRadius: 32),
  ];
}
