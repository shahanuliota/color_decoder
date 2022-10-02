import 'dart:ui';

class ColorBase {
  Color baseColor;
  String tag;

  ColorBase({required this.tag, required this.baseColor});
}

class BaseColorGenerator {
  /// cool colors
  final Color redCool = const Color(0xff890041);
  final Color yellowCool = const Color(0xffFFCE51);
  final Color blueCool = const Color(0xff00224C);
  final Color whiteCool = const Color(0xffFFFFFF);
  final Color blackCool = const Color(0xff21211A);

  /// warm colors
  final Color redWarm = const Color(0xffc40d20);
  final Color yellowWarm = const Color(0xffFFCC00);
  final Color blueWarm = const Color(0xff00224C);
  final Color whiteWarm = const Color(0xffFFFFFF);
  final Color blackWarm = const Color(0xff21211a);

  List<ColorBase> getCoolColors() {
    List<ColorBase> coolColors = [
      ColorBase(baseColor: redCool, tag: 'Red'),
      ColorBase(baseColor: yellowCool, tag: 'Yellow'),
      ColorBase(baseColor: blueCool, tag: 'Blue'),
      ColorBase(baseColor: whiteCool, tag: 'White'),
      ColorBase(baseColor: blackCool, tag: 'Black'),
    ];

    return coolColors;
  }

  List<ColorBase> getWarmColors() {
    List<ColorBase> warmColors = [
      ColorBase(baseColor: redWarm, tag: 'Red'),
      ColorBase(baseColor: yellowWarm, tag: 'Yellow'),
      ColorBase(baseColor: blueWarm, tag: 'Blue'),
      ColorBase(baseColor: whiteWarm, tag: 'White'),
      ColorBase(baseColor: blackWarm, tag: 'Black'),
    ];
    return warmColors;
  }
}
