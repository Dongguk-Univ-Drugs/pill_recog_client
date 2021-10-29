import 'package:flutter/material.dart';
import './text_search_data.dart';

import '../../components/components.dart';

Widget textColorPicker(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: padding(horizontal: 8.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: CColor.white.color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),

      /// make picker
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemCount: textColorNames.length,
        itemBuilder: (BuildContext context, int index) => Column(
          children: [
            FloatingActionButton(
              onPressed: () => {},
              backgroundColor: textColorValues[index],
            ),
            blankBox(height: 10),
            Text(textColorNames[index])
          ],
        ),
      ),
    );
