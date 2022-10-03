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

  RxBool isCompletedUpload = false.obs;

  Future<void> palateDecoder(List<Color> colors) async {
    try {
      isCompletedUpload.value = false;
      DateTime start = DateTime.now();
      print(start.toString());

      List<Color> coolBaseColors = _colorGenerator.getCoolColors().map((e) => e.baseColor).toList();
      List<Color> warmBaseColors = _colorGenerator.getWarmColors().map((e) => e.baseColor).toList();

      for (int i = 0; i < colors.length; i++) {
        Color color = colors[i];
        if (i > 10) continue;
        print(color.toHexString() + ' ' + i.toString());

        ColorDecoderDto warmDto = ColorDecoderDto(
          structure: warmBaseColors,
          hex: color,
        );
        ColorDataModel warmData = await _colorDecoderRepository.getColorDecoder(warmDto);
        warmColorsDataModel.add(ColorPalletMixer(targetColor: color, result: warmData));

        ColorDecoderDto coolDto = ColorDecoderDto(
          structure: coolBaseColors,
          hex: color,
        );
        ColorDataModel coolData = await _colorDecoderRepository.getColorDecoder(coolDto);
        coolColorsDataModel.add(ColorPalletMixer(targetColor: color, result: coolData));
        update(['table']);
      }

      DateTime end = DateTime.now();

      Duration d = end.difference(start);

      update();

      print('time count => ${d.inMilliseconds} ms');

      isCompletedUpload.value = true;
    } catch (e, t) {
      isCompletedUpload.value = false;
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
  }

  List<ColorPalletMixer> coolColorsDataModel = <ColorPalletMixer>[].obs;
  List<ColorPalletMixer> warmColorsDataModel = <ColorPalletMixer>[].obs;
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
