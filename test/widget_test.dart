import 'package:color_decoder/core/extensions/color.decoder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('color', () async {
    Color redCool = const Color(0xff890041);
    Color yellowCool = const Color(0xffFFCE51);
    Color blue = const Color(0xff00224C);
    Color white = const Color(0xffFFFFFF);
    Color black = const Color(0xff21211A);
    Color targetColor = const Color(0xff83504A);

    List<Color> mixerList = [yellowCool, redCool, blue];

    Color mix = mixColors(mixerList);

    colorPrint(redCool, name: 'Red');
    colorPrint(yellowCool, name: 'Yellow');
    colorPrint(blue, name: 'blue');
    colorPrint(mix, name: 'mix');
    print(mix == targetColor);
    print(mix.value);

    var p = const Color(0xffABC453).match(const Color(0xffFFCE51));
    print(p);
    print(blue.value.toRadixString(16).padLeft(8, '0'));

    expect(true, true);
  });
}
