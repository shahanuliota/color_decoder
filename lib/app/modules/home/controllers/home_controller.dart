import 'dart:ui';

import 'package:get/get.dart';

import '../../../../core/extensions/color.decoder.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    initColor();
    super.onInit();
  }

  @override
  void onClose() {}

  void initColor() {
    baseColors = <ColorBase>[
      ColorBase(baseColor: redCool, tag: 'Red'),
      ColorBase(baseColor: yellowCool, tag: 'Yellow-Cool'),
      ColorBase(baseColor: blue, tag: 'Blue'),
      ColorBase(baseColor: white, tag: 'White'),
      ColorBase(baseColor: black, tag: 'Black'),
    ];
  }

  Color? givenColor;

  setGivenColor(String color) {
    try {
      givenColor = HexColor(color);
      update(['given_color']);
    } catch (_) {}
  }

  final Color redCool = const Color(0xff890041);
  final Color yellowCool = const Color(0xffFFCE51);
  final Color blue = const Color(0xff00224C);
  final Color white = const Color(0xffFFFFFF);
  final Color black = const Color(0xff21211A);
  List<ColorBase> baseColors = <ColorBase>[];
}

class ColorBase {
  Color baseColor;
  String tag;

  ColorBase({required this.tag, required this.baseColor});
}
