import 'package:flutter/material.dart';

EdgeInsets padding({double? vertical, double? horizontal}) =>
    EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    );

EdgeInsets margin({double? vertical, double? horizontal}) =>
    EdgeInsets.symmetric(
      vertical: vertical ?? 0,
      horizontal: horizontal ?? 0,
    );
