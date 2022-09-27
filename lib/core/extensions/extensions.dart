import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PercentSized on num {
  // height: 50.0.hp = 50%
  double get hp => (Get.height * (toDouble() / 100));

  // width: 30.0.hp = 30%
  double get wp => (Get.width * (toDouble() / 100));

  Widget get verticalSpace => SizedBox(height: toDouble());
  Widget get horizontalSpace => SizedBox(width: toDouble());
}
