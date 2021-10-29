import 'package:flutter/material.dart';

enum CColor {
  primary,
  secondary,
  largeTitle,
  title,
  body,
  footnote,
  caption,
  white,
  primaryGradient
}

extension CColorExtension on CColor {
  dynamic get color {
    switch (this) {
      case CColor.primary:
        return const Color(0xFF11998E);
      case CColor.secondary:
        return const Color(0xFF38EF7D);
      case CColor.largeTitle:
        return const Color(0xFF000000);
      case CColor.title:
        return const Color(0xFF333333);
      case CColor.body:
        return const Color(0xFF777777);
      case CColor.footnote:
        return const Color(0xFFCCCCCC);
      case CColor.caption:
        return const Color(0xFFEEEEEE);
      case CColor.white:
        return const Color(0xFFFFFFFF);
      case CColor.primaryGradient:
        return const LinearGradient(
          colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
          stops: [0.3, 0.9],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}
