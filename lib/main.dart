import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'initializer.dart';

void main() async {
  await Initializer.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: InitialBindings(),
    ),
  );
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
  }
}
