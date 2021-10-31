import 'package:flutter/material.dart';
import './colors.dart';

SizedBox blankBox({double? height, double? width}) =>
    SizedBox(height: height ?? 0, width: width ?? 0);

InputDecoration roundedInputDecoration({
  String? labelText,
  String? helperText,
  Icon? icon,
}) =>
    InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: CColor.caption.color),
      ),
      helperText: helperText ?? '',
      labelText: labelText ?? '',
      icon: icon,
    );
