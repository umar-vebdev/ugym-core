import 'package:flutter/widgets.dart';

/// Corner radius tokens for uCraft Design System 1.0.
abstract final class UcraftRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double full = 999;

  static const BorderRadius borderXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius borderSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius borderMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius borderXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius border2xl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius borderFull = BorderRadius.all(
    Radius.circular(full),
  );
}
