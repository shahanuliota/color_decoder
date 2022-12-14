import '../../../app/data/color.data.model.dart';
import '../../service/color/dto/color.decoder.dto.dart';
import '../../service/color/response/color_decoder.response.model.dart';

abstract class IColorDecoderRepository {
  Future<ColorDataModel> getColorDecoder(ColorDecoderDto dto);
}
