import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/extensions/color.decoder.dart';
import '../../../../domain/repository/interface/color_repository.interface.dart';
import '../../../../domain/service/color/dto/color.decoder.dto.dart';
import '../../../data/color.data.model.dart';
import '../../../data/color.generator.dart';

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
    baseColors = _colorGenerator.getCoolColors();
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

  BaseColorGenerator _colorGenerator = BaseColorGenerator();

  void switchBaseColors(int i) {
    if (i == 0) {
      baseColors = _colorGenerator.getCoolColors();
    } else {
      baseColors = _colorGenerator.getWarmColors();
    }

    update();
  }

  ColorDataModel? decodedColor;
  Color? givenColor;

  List<ColorBase> baseColors = <ColorBase>[];
}
