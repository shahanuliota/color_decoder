import 'dart:ui';

import '../../../app/data/color.data.model.dart';
import '../../../core/extensions/color.decoder.dart';
import '../../../core/utils/colod.palate-reverser.dart';
import '../interface/color.service.interface.dart';
import 'dto/color.decoder.dto.dart';
import 'response/color_decoder.response.model.dart';

class ColorDecoderLocalService extends IColorDecoderService {
  @override
  Future<ColorDecoderResponse> getColorDecoder(ColorDecoderDto dto) async {
    try {
      ColorPalateReverse reverser =
          ColorPalateReverse(baseColors: dto.structure, targetColor: dto.hex);
      List<Color> list = reverser.reverse(<Color>[]);
      Map<String, ColorData> structure = <String, ColorData>{};
      NormalizedColorData model = NormalizedColorData(baseColors: dto.structure);
      for (var c in list) {
        model.addColor(c);
      }

      model.step1();
      model.step2();
      model.step3();

      for (String key in model.normalizedStep2.keys) {
        // print('$key => ${model.getPercent(HexColor(key))}');
        ColorData v = ColorData(
          hex: key,
          name: key,
          count: model.colorCnt(HexColor(key)),
        );
        structure[key] = v;
      }

      return ColorDecoderResponse(structure: structure);
    } catch (e) {
      rethrow;
    }
  }
}
