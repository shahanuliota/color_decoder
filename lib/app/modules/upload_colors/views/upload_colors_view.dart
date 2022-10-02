import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/excle_to_color_list.dart';
import '../controllers/upload_colors_controller.dart';

class UploadColorsView extends GetView<UploadColorsController> {
  UploadColorsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('upload colors'.toUpperCase()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: min(Get.width, 1000),
              child: Column(
                children: [
                  min(Get.width, 1000).horizontalSpace,
                  Center(
                    child: ElevatedButton(
                      child: Text('Upload csv'.toUpperCase(), style: TextStyle(fontSize: 14)),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.red)))),
                      onPressed: () async {
                        try {
                          List<Color> colors = await ExcelToColors().pickAndGetColors();
                          print('colors.length');
                          print(colors.length);
                        } catch (e, t) {
                          print(e.toString());
                          print(t.toString());
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
