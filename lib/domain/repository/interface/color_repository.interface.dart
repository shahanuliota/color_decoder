import '../../../app/data/color.data.model.dart';
import '../../service/color/dto/color.decoder.dto.dart';

abstract class IColorDecoderRepository {
  Future<ColorDataModel> getColorDecoder(ColorDecoderDto dto);
}
