import 'package:client_app/components/components.dart';
import 'package:flutter/material.dart';

RichText highlightedText({required String text}) => RichText(
      textScaleFactor: 1.25,
      text: TextSpan(
        text: text,
        style: TextStyle(
            color: CColor.largeTitle.color,
            fontWeight: FontWeight.bold,
            decorationColor: CColor.secondary.color,
            decorationThickness: 3,
            decoration: TextDecoration.underline),
      ),
    );
