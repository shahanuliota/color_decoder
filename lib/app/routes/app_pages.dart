import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/upload_colors/bindings/upload_colors_binding.dart';
import '../modules/upload_colors/views/upload_colors_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.UPLOAD_COLORS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD_COLORS,
      page: () => UploadColorsView(),
      binding: UploadColorsBinding(),
    ),
  ];
}
