import '../repository/color_repository/color.repository.dart';
import '../repository/interface/color_repository.interface.dart';
import '../service/color/color.decoder.local.service.dart';

class ColorDecoderRepositoryBindings {
  late IColorDecoderRepository _repository;

  IColorDecoderRepository get repository => _repository;

  ColorDecoderRepositoryBindings() {
    // final GetConnect getConnect = Get.find<GetConnect>();
    // final Connect connect = Connect(connect: getConnect);
    // final service = ColorDecoderNetworkService(connect);
    final service = ColorDecoderLocalService();
    _repository = ColorDecoderRepository(colorDecoderService: service);
  }
}
