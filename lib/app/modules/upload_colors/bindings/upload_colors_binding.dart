import 'package:get/get.dart';

import '../controllers/upload_colors_controller.dart';

class UploadColorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadColorsController>(
      () => UploadColorsController(),
    );
  }
}
