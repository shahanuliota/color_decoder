import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/extensions/color.decoder.dart';
import '../../../../domain/repository/interface/color_repository.interface.dart';
import '../../../../domain/service/color/dto/color.decoder.dto.dart';
import '../../../data/color.data.model.dart';
import '../../../data/color.generator.dart';

class UploadColorsController extends GetxController {
  final IColorDecoderRepository _colorDecoderRepository;

  UploadColorsController({required IColorDecoderRepository colorDecoderRepository})
      : _colorDecoderRepository = colorDecoderRepository;

  List<ColorBase> baseColors = <ColorBase>[];
  BaseColorGenerator _colorGenerator = BaseColorGenerator();

  Future<void> palateDecoder(List<Color> colors) async {
    try {
      DateTime start = DateTime.now();
      print(start.toString());

      for (int i = 0; i < colors.length; i++) {
        Color color = colors[i];
        print(color.toHexString() + ' ' + i.toString());
        ColorDecoderDto dto = ColorDecoderDto(
          structure: _colorGenerator.getCoolColors().map((e) => e.baseColor).toList(),
          hex: color,
        );
        ColorDataModel data = await _colorDecoderRepository.getColorDecoder(dto);
        colorsDataModel.add(ColorPalletMixer(targetColor: color, result: data));
        update(['table']);
        if (i % 100 == 0) {
          update(['table']);
          await 50.milliseconds.delay();
        }
      }

      DateTime end = DateTime.now();

      Duration d = end.difference(start);

      update();

      print('time count => ${d.inMilliseconds} ms');
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
  }

  List<ColorPalletMixer> colorsDataModel = <ColorPalletMixer>[].obs;
}

class ColorPalletMixer {
  final Color targetColor;
  final ColorDataModel result;

  ColorPalletMixer({required this.targetColor, required this.result});

  int colorCount(Color c) {
    return result.colorCnt(c);
  }

  double matchWithTarget(Color c) {
    return result.matchPercentageWith(c);
  }
}
