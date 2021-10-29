import 'package:client_app/components/colors.dart';
import 'package:flutter/material.dart';

enum CTypography { largeTitle, title, headline, body, footnote, caption }

extension TypographyExtension on CTypography {
  TextStyle get style {
    switch (this) {
      case CTypography.largeTitle:
        return TextStyle(
            fontWeight: FontWeight.bold, color: CColor.largeTitle.color);
      case CTypography.title:
        return TextStyle(
            fontWeight: FontWeight.w700, color: CColor.title.color);
      case CTypography.headline:
        return TextStyle(
            fontWeight: FontWeight.w600, color: CColor.largeTitle.color);
      case CTypography.body:
        return TextStyle(fontWeight: FontWeight.w400, color: CColor.body.color);
      case CTypography.footnote:
        return TextStyle(
            fontWeight: FontWeight.w300, color: CColor.footnote.color);
      case CTypography.caption:
        return TextStyle(
            fontWeight: FontWeight.w300, color: CColor.caption.color);
    }
  }
}
