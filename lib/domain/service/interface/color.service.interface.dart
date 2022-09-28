import '../color/dto/color.decoder.dto.dart';
import '../color/response/color_decoder.response.model.dart';

abstract class IColorDecoderService {
  Future<ColorDecoderResponse> getColorDecoder(ColorDecoderDto dto);
}
