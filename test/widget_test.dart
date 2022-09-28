import 'package:color_decoder/app/data/color.data.model.dart';
import 'package:color_decoder/core/extensions/color.decoder.dart';
import 'package:color_decoder/domain/bindings/color.decoder.repository.bindings.dart';
import 'package:color_decoder/domain/repository/interface/color_repository.interface.dart';
import 'package:color_decoder/domain/service/color/dto/color.decoder.dto.dart';
import 'package:color_decoder/initializer.dart';
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
    print(const Color(0xffD52323).match(targetColor).toStringAsFixed(2));
    expect(true, true);
  });

  test('api deo', () async {
    await Initializer.test();

    IColorDecoderRepository repo = ColorDecoderRepositoryBindings().repository;
    Color targetColor = const Color(0xff83504A);
    Color redCool = const Color(0xff890041);
    Color yellowCool = const Color(0xffFFCE51);
    Color blue = const Color(0xff00224C);
    Color white = const Color(0xffFFFFFF);
    Color black = const Color(0xff21211A);
    List<Color> mixerList = [yellowCool, redCool, blue, white, black];
    ColorDecoderDto dto = ColorDecoderDto(structure: mixerList, hex: targetColor);

    ColorDataModel res = await repo.getColorDecoder(dto);

    print('------------------------------------------------');
    print(res.toString());
    print(res.matchPercentageWith(targetColor));

    expect(true, true);
  });
}
