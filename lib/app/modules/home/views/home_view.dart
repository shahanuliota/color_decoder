import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/extensions/clickable_extensions.dart';
import '../../../../core/extensions/color.decoder.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/color.decompile.dart';
import '../../../data/color.generator.dart';
import '../../../routes/app_pages.dart';
import '../componenet/color.box.view.dart';
import '../componenet/submit.button.view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({super.key});

  final TextEditingController colorInputController = TextEditingController();

  final RxBool submitButtonState = false.obs;
  final FocusNode submitButtonNode = FocusNode();
  final FocusNode colorTextNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget? desktop() {
    // TODO: implement desktop
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('color blend'.toUpperCase()),
          centerTitle: true,
          actions: [
            SizedBox(
              width: 200,
              height: 50,
              child: Center(
                child: Material(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.UPLOAD_COLORS);
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        'BULK UPLOAD',
                        style: TextStyle(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            20.horizontalSpace,
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: ToggleSwitch(
                  minWidth: 100.0,
                  initialLabelIndex: 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 4,
                  labels: const ['Cool', 'Warm', 'Cool-Purple', 'Warm-Purple'],
                  activeBgColors: const [
                    [Color(0xff00224c)],
                    [Color(0xff9C0F48)],
                    [Colors.purple],
                    [Colors.purpleAccent],
                  ],
                  onToggle: (index) {
                    controller.switchBaseColors(index ?? 0);
                    print('switched to: $index');
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: min(Get.width, 1000),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          20.verticalSpace,
                          const Text(
                            'Color Cool pallet',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          20.verticalSpace,
                          GetBuilder<HomeController>(
                            builder: (logic) {
                              return Wrap(
                                children: [
                                  for (ColorBase color in logic.baseColors)
                                    ColorBox(
                                      color: color.baseColor,
                                      tag: color.tag,
                                    ),
                                ],
                              );
                            },
                          ),
                          20.verticalSpace,
                          const Text(
                            'Enter Color Code',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          20.verticalSpace,
                          TextFormField(
                            focusNode: colorTextNode,
                            controller: colorInputController,
                            cursorColor: Colors.white,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              border:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
                              focusedBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
                            ),
                            validator: (v) {
                              if (GetUtils.isHexadecimal(v ?? '') == false ||
                                  (v ?? '').length < 6) {
                                return 'please enter a hexadecimal color code';
                              }
                              return null;
                            },
                            onChanged: (v) {
                              if (GetUtils.isHexadecimal(v) == false || (v).length < 6) {
                                submitButtonState.value = false;
                              } else {
                                submitButtonState.value = true;
                              }
                            },
                            onFieldSubmitted: (v) async {
                              await 50.milliseconds.delay();
                              colorTextNode.unfocus();
                              submitButtonNode.requestFocus();
                            },
                          ),
                          20.verticalSpace,
                          Obx(
                            () {
                              return SubmitButton(
                                focusNode: submitButtonNode,
                                onTap: submitButtonState.value == false
                                    ? null
                                    : () {
                                        controller.setGivenColor(colorInputController.text);
                                        // print('submit');
                                      },
                              );
                            },
                          ),
                          20.verticalSpace,
                          GetBuilder<HomeController>(
                            id: 'given_color',
                            builder: (logic) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (controller.givenColor != null)
                                    Text(
                                      'Given color: ${controller.givenColor!.toHexString().toUpperCase()}   ${controller.givenColor!.toRGBString().toUpperCase()}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        //color: controller.givenColor,
                                      ),
                                    ),
                                  20.verticalSpace,
                                  if (controller.givenColor != null)
                                    ColorBox(
                                      color: controller.givenColor!,
                                      tag: 'Given Color',
                                      width: min(Get.width, 1000),
                                    )
                                ],
                              );
                            },
                          ),
                          20.verticalSpace,
                          GetBuilder<HomeController>(
                            id: 'match_color',
                            builder: (logic) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (controller.decodedColor != null)
                                    Text(
                                      'Percentage: ${controller.decodedColor!.matchPercentageWith(controller.givenColor!).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        //color: controller.givenColor,
                                      ),
                                    ),
                                  20.verticalSpace,
                                  if (controller.decodedColor != null)
                                    Text(
                                      'Match color: ${controller.decodedColor!.mixColor.toHexString().toUpperCase()}  ${controller.decodedColor!.mixColor.toRGBString().toUpperCase()}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        //color: controller.givenColor,
                                      ),
                                    ),
                                  20.verticalSpace,
                                  if (controller.decodedColor != null)
                                    ColorBox(
                                      color: controller.decodedColor!.mixColor,
                                      tag: 'Match Color',
                                      width: min(Get.width, 1000),
                                    ),
                                  20.verticalSpace,
                                  if (controller.decodedColor != null)
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        for (String key
                                            in (controller.decodedColor?.colorCounterMap.keys ??
                                                <String>[]))
                                          CircularColorBox(
                                            color: HexColor(key),
                                            count: controller.decodedColor!
                                                .colorCnt(HexColor(key))
                                                .toString(),
                                            percentage: controller.decodedColor!
                                                .getPercent(HexColor(key))
                                                .toStringAsFixed(2)
                                                .toString(),
                                          ),
                                      ],
                                    )
                                ],
                              );
                            },
                          ),
                          40.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? phone() {
    // TODO: implement phone
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: desktop(),
    );
  }
}

class CircularColorBox extends StatelessWidget {
  const CircularColorBox({
    Key? key,
    required this.color,
    required this.count,
    required this.percentage,
    this.width = 200.0,
    this.height = 200.0,
  }) : super(key: key);

  final Color color;
  final String count;
  final String percentage;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count,
                style: TextStyle(
                  color: color.computeLuminance() > 0.6 ? Colors.black : Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ).clickable(
          () {
            Clipboard.setData(
              ClipboardData(text: color.toHexString()),
            );
          },
        ),
        10.verticalSpace,
        Text(
          '$percentage %',
        ),
      ],
    );
  }
}
