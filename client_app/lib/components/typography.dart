import 'package:client_app/components/colors.dart';
import 'package:flutter/material.dart';

enum Typography { largeTitle, title, headline, body, footnote, caption }

extension TypographyExtension on Typography {
  TextStyle get style {
    switch (this) {
      case Typography.largeTitle:
        return TextStyle(
            fontWeight: FontWeight.bold, color: CColor.largeTitle.color);
      case Typography.title:
        return TextStyle(
            fontWeight: FontWeight.w700, color: CColor.title.color);
      case Typography.headline:
        return TextStyle(
            fontWeight: FontWeight.w600, color: CColor.largeTitle.color);
      case Typography.body:
        return TextStyle(fontWeight: FontWeight.w400, color: CColor.body.color);
      case Typography.footnote:
        return TextStyle(
            fontWeight: FontWeight.w300, color: CColor.footnote.color);
      case Typography.caption:
        return TextStyle(
            fontWeight: FontWeight.w300, color: CColor.caption.color);
    }
  }
}
