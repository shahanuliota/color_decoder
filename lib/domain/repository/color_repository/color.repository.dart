import 'package:flutter/foundation.dart';

import '../../../app/data/color.data.model.dart';
import '../../../core/extensions/color.decoder.dart';
import '../../service/color/dto/color.decoder.dto.dart';
import '../../service/color/response/color_decoder.response.model.dart';
import '../../service/interface/color.service.interface.dart';
import '../interface/color_repository.interface.dart';

class ColorDecoderRepository extends IColorDecoderRepository {
  final IColorDecoderService _colorDecoderService;

  ColorDecoderRepository({required IColorDecoderService colorDecoderService})
      : _colorDecoderService = colorDecoderService;

  @override
  Future<ColorDataModel> getColorDecoder(ColorDecoderDto dto) async {
    try {
      // print('repository: called');
      // ColorDecoderResponse res = await _colorDecoderService.getColorDecoder(dto);
      ColorDecoderResponse res = await compute(_colorDecoderService.getColorDecoder, dto);

      //print('repository: $res');
      ColorDataModel model = ColorDataModel();
      // res.structure.forEach(
      //   (key, value) {},
      // );

      for (var key in res.structure.keys) {
        var value = res.structure[key];
        for (int i = 0; i < (value?.count ?? 0); i++) {
          model.addColor(HexColor(value!.name!));
        }
      }

      return model;
    } catch (e) {
      rethrow;
    }
  }
}
