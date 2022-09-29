import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/extensions/color.decoder.dart';
import '../../../../domain/repository/interface/color_repository.interface.dart';
import '../../../../domain/service/color/dto/color.decoder.dto.dart';
import '../../../data/color.data.model.dart';

class HomeController extends GetxController {
  final IColorDecoderRepository _colorDecoderRepository;

  HomeController({required IColorDecoderRepository colorDecoderRepository})
      : _colorDecoderRepository = colorDecoderRepository;

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

  setGivenColor(String color) {
    try {
      givenColor = HexColor(color);
      update(['given_color']);
      decodeColor();
    } catch (_) {}
  }

  Future<void> decodeColor() async {
    try {
      if (givenColor != null) {
        List<Color> list = baseColors.map((e) => e.baseColor).toList();
        ColorDecoderDto dto = ColorDecoderDto(
          structure: list,
          hex: givenColor!,
        );

        // Dio dio = Dio();
        // var res = await dio.post(
        //   'https://trycolors.com/api/mix',
        //   data: dto.toString(),
        // );
        //
        // print(res.data);

        ColorDataModel colorDataModel = await _colorDecoderRepository.getColorDecoder(dto);
        decodedColor = colorDataModel;
        update(['match_color']);
      }
    } catch (e, t) {
      debugPrint('---------');
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
  }

  ColorDataModel? decodedColor;
  Color? givenColor;
  final Color redCool = const Color(0xffc40d20);
  final Color yellowCool = const Color(0xffffcc00);
  final Color blue = const Color(0xff00224c);
  final Color white = const Color(0xffFFFFFF);
  final Color black = const Color(0xff21211a);
  List<ColorBase> baseColors = <ColorBase>[];
}

class ColorBase {
  Color baseColor;
  String tag;

  ColorBase({required this.tag, required this.baseColor});
}
