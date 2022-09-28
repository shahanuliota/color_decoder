import 'package:get/get.dart';

import '../../../../domain/bindings/color.decoder.repository.bindings.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        colorDecoderRepository: ColorDecoderRepositoryBindings().repository,
      ),
    );
  }
}
