import 'package:color_decoder/app/data/color.data.model.dart';
import 'package:color_decoder/core/extensions/color.decoder.dart';
import 'package:color_decoder/core/utils/colod.palate-reverser.dart';
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

    print(Colors.transparent.match(targetColor).toStringAsFixed(2));
    expect(true, true);
  });

  test('reverse from palate', () {
    Color redCool = const Color(0xffc40d20);
    Color yellowCool = const Color(0xffffcc00);
    Color blue = const Color(0xff00224c);
    Color white = const Color(0xffffffff);
    Color black = const Color(0xff21211a);

    //Color targetColor = const Color(0xff83504A);
    //Color targetColor = const Color(0xff886F67);
    // Color targetColor = const Color(0xff595150);
    // Color targetColor = const Color(0xffE53F2D);
    // Color targetColor = const Color(0xff888459);
    Color targetColor = const Color(0xffE4D30F);
    // Color targetColor = const Color(0xff9A281B);
    // Color targetColor = const Color(0xff8E2C3D);
    //Color targetColor = const Color(0xff890041);

    List<Color> baseList = [
      yellowCool,
      redCool,
      blue,
      white,
      black,
    ];

    ColorPalateReverse reverser =
        ColorPalateReverse(baseColors: baseList, targetColor: targetColor);

    var list = reverser.reverse(<Color>[]);

    expect(list == reverser.bestList, true);
    expect(list.length == reverser.bestList.length, true);

    print('reversed list ->');
    ColorDataModel model = ColorDataModel();
    for (var c in list) {
      model.addColor(c);
    }

    print(model.toString());
    print(model.matchPercentageWith(targetColor));
    print('Total recursion count: ${reverser.totalStepTook}');
    print(reverser.globalMaxMatch);
    print('----- all percentage -------');

    for (String key in model.colorCounterMap.keys) {
      print('$key => ${model.getPercent(HexColor(key))}');
    }
  });

  // test('api deo', () async {
  //   await Initializer.test();
  //
  //   IColorDecoderRepository repo = ColorDecoderRepositoryBindings().repository;
  //   Color targetColor = const Color(0xff83504A);
  //   Color redCool = const Color(0xff890041);
  //   Color yellowCool = const Color(0xffFFCE51);
  //   Color blue = const Color(0xff00224C);
  //   Color white = const Color(0xffFFFFFF);
  //   Color black = const Color(0xff21211A);
  //   List<Color> mixerList = [yellowCool, redCool, blue, white, black];
  //   ColorDecoderDto dto = ColorDecoderDto(structure: mixerList, hex: targetColor);
  //
  //   ColorDataModel res = await repo.getColorDecoder(dto);
  //
  //   print('------------------------------------------------');
  //   print(res.toString());
  //   print(res.matchPercentageWith(targetColor));
  //
  //   expect(true, true);
  // });

  test('colors optimal solution', () {
    Color redCool = const Color(0xffc40d20);
    Color yellowCool = const Color(0xffffcc00);
    Color blue = const Color(0xff00224c);
    Color white = const Color(0xffffffff);
    Color black = const Color(0xff21211a);

    List<Color> mixerList = [redCool, yellowCool, blue, white, black];
  });
}

List getAllSubsets(List l) => l.fold<List>([[]], (subLists, element) {
      return subLists
          .map((subList) => [
                subList,
                subList + [element]
              ])
          .expand((element) => element)
          .toList();
    });
