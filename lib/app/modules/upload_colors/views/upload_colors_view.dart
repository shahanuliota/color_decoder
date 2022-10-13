import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

import '../../../../core/extensions/color.decoder.dart';
import '../../../../core/extensions/extensions.dart';

// Local import
import '../../../../core/helper/save_file_mobile.dart'
    if (dart.library.html) '../../../../core/helper/save_file_web.dart' as helper;
import '../../../../core/utils/color.decompile.dart';
import '../../../../core/utils/excle_to_color_list.dart';
import '../../../data/color.generator.dart';
import '../../home/componenet/submit.button.view.dart';
import '../controllers/upload_colors_controller.dart';

class UploadColorsView extends GetView<UploadColorsController> {
  UploadColorsView();

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  final DataGridController _controller = DataGridController();

  Future<void> _exportDataGridToExcel() async {
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await helper.saveAndLaunchFile(bytes, 'color_pallet.xlsx');
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('upload colors'.toUpperCase()),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints bsx) {
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: min(Get.width, 1000),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 200,
                          child: Center(
                            child: ElevatedButton(
                              child:
                                  Text('Upload csv'.toUpperCase(), style: TextStyle(fontSize: 14)),
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: BorderSide(color: Colors.red)))),
                              onPressed: () async {
                                try {
                                  controller.isCompletedUpload.value = TaskStatus.started;
                                  List<Color> colors = await ExcelToColors().pickAndGetColors();
                                  controller.palateDecoder(colors);
                                } catch (e, t) {
                                  controller.isCompletedUpload.value = TaskStatus.failed;
                                  print(e.toString());
                                  print(t.toString());
                                }
                              },
                            ),
                          ),
                        ),
                        Obx(
                          () {
                            if (controller.isCompletedUpload.value == TaskStatus.started) {
                              return LinearPercentIndicator(
                                // width: MediaQuery.of(context).size.width - 100,
                                animation: false,
                                lineHeight: 10.0,
                                animationDuration: 2500,
                                percent: controller.taskPercentage.value,
                                center: Text(
                                  (controller.taskPercentage.value * 100.0).toStringAsFixed(3),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                                barRadius: Radius.circular(10),
                                progressColor: Colors.green,
                              );
                            } else if (controller.isCompletedUpload.value == TaskStatus.completed) {
                              return SubmitButton(
                                activeColor: Colors.greenAccent,
                                focusNode: FocusNode(),
                                title: 'EXPORT csv'.toUpperCase(),
                                onTap: _exportDataGridToExcel,
                              );
                            } else if (controller.isCompletedUpload.value == TaskStatus.failed) {
                              return Text('file upload failed');
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        // width: min(Get.width, 1000),
                        child: GetBuilder<UploadColorsController>(
                          id: 'table',
                          builder: (logic) {
                            return SfDataGrid(
                              key: _key,
                              controller: _controller,
                              source: ColorDataSource(
                                coolColors: logic.coolColorsDataModel,
                                warmColors: logic.warmColorsDataModel,
                              ),
                              columns: <GridColumn>[
                                GridColumn(
                                  columnName: 'ID-COOL',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'ID',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.fill,
                                  columnName: 'HEX-COOL',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'COLOR-COOL',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'RED-COOL',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'RED-COOL',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'YELLOW-COOL',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'YELLOW',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.none,
                                  columnName: 'BLUE-COOL',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'BLUE',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.none,
                                  columnName: 'WHITE-COOL',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'WHITE',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.none,
                                  columnName: 'BLACK-COOL',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'BLACK',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.auto,
                                  columnName: 'MATCH-COOL',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'MATCH',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // GridColumn(
                                //   columnWidthMode: ColumnWidthMode.fill,
                                //   columnName: 'ID-WARM',
                                //   label: Container(
                                //     padding: const EdgeInsets.all(16.0),
                                //     alignment: Alignment.center,
                                //     child: const Text(
                                //       'ID',
                                //       style: TextStyle(
                                //         fontSize: 14,
                                //         color: Colors.white,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.fill,
                                  columnName: 'HEX-WARM',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'COLOR-WARM',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.none,
                                  columnName: 'RED-WARM',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'RED',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.none,
                                  columnName: 'YELLOW-WARM',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'YELLOW',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.none,
                                  columnName: 'BLUE-WARM',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'BLUE',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.auto,
                                  columnName: 'WHITE-WARM',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'WHITE',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.auto,
                                  columnName: 'BLACK-WARM',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'BLACK',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnWidthMode: ColumnWidthMode.auto,
                                  columnName: 'MATCH-WARM',
                                  label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'MATCH',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ColorDataSource extends DataGridSource {
  ColorDataSource({
    required this.coolColors,
    required this.warmColors,
  });

  final List<ColorPalletMixer> coolColors;
  final List<ColorPalletMixer> warmColors;

  final BaseColorGenerator baseColorGenerator = BaseColorGenerator();
  int id = 0;

  @override
  List<DataGridRow> get rows {
    id = 0;
    List<DataGridRow> rows = <DataGridRow>[];

    for (int i = 0; i < coolColors.length; i++) {
      var dataRow = coolColors[i];
      var warmRow = warmColors[i];
      var d = DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'ID-COOL',
            value: (id++).toString(),
          ),
          DataGridCell<String>(
            columnName: 'HEX-COOL',
            value: dataRow.targetColor.toHexString(),
          ),
          DataGridCell<String>(
            columnName: 'RED-COOL',
            value: dataRow.colorCount(baseColorGenerator.getRed(ColorType.cool)).toString(),
          ),
          DataGridCell<String>(
            columnName: 'YELLOW-COOL',
            value: dataRow.colorCount(baseColorGenerator.getYellow(ColorType.cool)).toString(),
          ),
          DataGridCell<String>(
            columnName: 'BLUE-COOL',
            value: dataRow.colorCount(baseColorGenerator.getBlue(ColorType.cool)).toString(),
          ),
          DataGridCell<String>(
            columnName: 'WHITE-COOL',
            value: dataRow.colorCount(baseColorGenerator.getWhite(ColorType.cool)).toString(),
          ),
          DataGridCell<String>(
            columnName: 'BLACK-COOL',
            value: dataRow.colorCount(baseColorGenerator.getBlack(ColorType.cool)).toString(),
          ),
          DataGridCell<String>(
            columnName: 'MATCH-COOL',
            value: dataRow.matchWithTarget(dataRow.targetColor).toStringAsFixed(2) + '%',
          ),

          /// warm rows
          DataGridCell<String>(
            columnName: 'HEX-WARM',
            value: warmRow.targetColor.toHexString(),
          ),
          DataGridCell<String>(
            columnName: 'RED-WARM',
            value: warmRow.colorCount(baseColorGenerator.getRed(ColorType.warm)).toString(),
          ),
          DataGridCell<String>(
            columnName: 'YELLOW-WARM',
            value: warmRow.colorCount(baseColorGenerator.getYellow(ColorType.warm)).toString(),
          ),
          DataGridCell<String>(
            columnName: 'BLUE-WARM',
            value: warmRow.colorCount(baseColorGenerator.getBlue(ColorType.warm)).toString(),
          ),
          DataGridCell<String>(
            columnName: 'WHITE-WARM',
            value: warmRow.colorCount(baseColorGenerator.getWhite(ColorType.warm)).toString(),
          ),
          DataGridCell<String>(
            columnName: 'BLACK-WARM',
            value: warmRow.colorCount(baseColorGenerator.getBlack(ColorType.warm)).toString(),
          ),
          DataGridCell<String>(
            columnName: 'MATCH-WARM',
            value: warmRow.matchWithTarget(warmRow.targetColor).toStringAsFixed(2) + '%',
          ),
        ],
      );

      rows.add(d);
    }

    print(' id $id: rows: ${rows.length}');
    return rows;
  }

  @override
  bool shouldRecalculateColumnWidths() {
    return true;
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'HEX-WARM' || dataCell.columnName == 'HEX-COOL') {
          return Container(
            color: HexColor(dataCell.value),
            child: Center(
              child: Text(
                dataCell.value.toString(),
                style: TextStyle(
                  color: HexColor(dataCell.value).computeLuminance() > 0.6
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          );
        }

        return Center(
          child: Text(
            dataCell.value.toString(),
            style: TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
