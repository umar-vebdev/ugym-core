import 'package:flutter/animation.dart';

/// Functional motion and duration tokens for uCraft Design System 1.0.
abstract final class UcraftMotion {
  static const Duration buttonFeedback = Duration(milliseconds: 100);
  static const Duration smallTransition = Duration(milliseconds: 150);
  static const Duration standardTransition = Duration(milliseconds: 200);
  static const Duration screenTransition = Duration(milliseconds: 250);
  static const Duration bottomSheet = Duration(milliseconds: 300);

  static const Curve enterCurve = Curves.easeOut;
  static const Curve exitCurve = Curves.easeIn;
}
