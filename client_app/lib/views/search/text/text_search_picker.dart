import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './text_search_data.dart';
import './text_search_controller.dart';
import '../../../components/components.dart';

void showTextSearchPicker({required String type}) {
  Get.bottomSheet(
    Container(
      height: Get.height * 0.6,
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
        itemCount: type == 'color'
            ? textColorNames.length
            : type == 'shape'
                ? textShapes.length
                : type == 'character'
                    ? textCharacters.length
                    : type == 'divider'
                        ? textDividers.length
                        : 0,
        itemBuilder: (BuildContext context, int index) => Column(
          children: [
            FloatingActionButton(
              onPressed: () {
                switch (type) {
                  case 'color':
                    return TextSearchController.to
                        .setColor(textColorNames[index]);
                  case 'shape':
                    return TextSearchController.to.setShape(textShapes[index]);
                  case 'character':
                    return TextSearchController.to
                        .setCharacter(textCharacters[index]);
                  case 'divider':
                    return TextSearchController.to
                        .setDivider(textDividers[index]);
                  default:
                }
              },
              backgroundColor: type == 'color'
                  ? textColorValues[index]
                  : const Color(0x00FFFFFF),
            ),
            blankBox(height: 10),
            if (type == 'color')
              Text(textColorNames[index])
            else if (type == 'shape')
              Text(textShapes[index])
            else if (type == 'character')
              Text(textCharacters[index])
            else if (type == 'divider')
              Text(textDividers[index])
          ],
        ),
      ),
    ),
  );
}
