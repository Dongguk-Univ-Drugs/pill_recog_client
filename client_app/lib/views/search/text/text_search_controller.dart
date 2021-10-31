import 'package:get/get.dart';

class TextSearchController extends GetxController {
  String text = '';
  String? color;
  String? shape;
  String? character;
  String? divider;

  /// just for easy-use, no difference in performance
  static TextSearchController get to => Get.find();

  void setText(String t) {
    text = t;
    update();
  }

  void setColor(String c) {
    color = c;
    update();
  }

  void setShape(String s) {
    shape = s;
    update();
  }

  void setCharacter(String c) {
    character = c;
    update();
  }

  void setDivider(String d) {
    divider = d;
    update();
  }
}
