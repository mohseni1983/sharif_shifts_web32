import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color(0xFF12c2e9);
  static const Color loginGradientMiddle = const Color(0xFFc471ed);
  static const Color loginGradientEnd = const Color(0xFFf64f59);

  static const Color loginGradientStart2=const Color(0xFF0F2027);
  static const Color loginGradientMiddle2 = const Color(0xFF203A43);
  static const Color loginGradientEnd2 = const Color(0xFF2C5364);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart,loginGradientMiddle, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const secondGradient = const LinearGradient(
    colors: const [loginGradientStart2, loginGradientMiddle2,loginGradientEnd2],
    stops: const [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}