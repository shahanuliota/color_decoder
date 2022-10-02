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
    coolColors = [
      ColorBase(baseColor: redCool, tag: 'Red'),
      ColorBase(baseColor: yellowCool, tag: 'Yellow'),
      ColorBase(baseColor: blueCool, tag: 'Blue'),
      ColorBase(baseColor: whiteCool, tag: 'White'),
      ColorBase(baseColor: blackCool, tag: 'Black'),
    ];

    warmColors = [
      ColorBase(baseColor: redWarm, tag: 'Red'),
      ColorBase(baseColor: yellowWarm, tag: 'Yellow'),
      ColorBase(baseColor: blueWarm, tag: 'Blue'),
      ColorBase(baseColor: whiteWarm, tag: 'White'),
      ColorBase(baseColor: blackWarm, tag: 'Black'),
    ];

    baseColors = coolColors;
  }

  void setGivenColor(String color) {
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

  void switchBaseColors(int i) {
    if (i == 0) {
      baseColors = coolColors;
    } else {
      baseColors = warmColors;
    }

    update();
  }

  ColorDataModel? decodedColor;
  Color? givenColor;

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

  List<ColorBase> baseColors = <ColorBase>[];
  List<ColorBase> coolColors = <ColorBase>[];
  List<ColorBase> warmColors = <ColorBase>[];
}

class ColorBase {
  Color baseColor;
  String tag;

  ColorBase({required this.tag, required this.baseColor});
}
