import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

import '../../../../core/extensions/color.decoder.dart';
import '../../../../core/extensions/extensions.dart';

// Local import
import '../../../../core/helper/save_file_mobile.dart'
    if (dart.library.html) '../../../../core/helper/save_file_web.dart' as helper;
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
        body: SafeArea(
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
                              controller.palateDecoder(colors);
                            } catch (e, t) {
                              print(e.toString());
                              print(t.toString());
                            }
                          },
                        ),
                      ),
                    ),
                    Obx(() {
                      return SubmitButton(
                        focusNode: FocusNode(),
                        title: 'EXPORT csv'.toUpperCase(),
                        onTap: controller.isCompletedUpload.value == false
                            ? null
                            : _exportDataGridToExcel,
                      );
                    }),
                  ],
                ),
              ),
              20.verticalSpace,
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: min(Get.width, 1000),
                    child: GetBuilder<UploadColorsController>(
                      id: 'table',
                      builder: (logic) {
                        return SfDataGrid(
                          key: _key,
                          controller: _controller,
                          source:
                              ColorDataSource(colors: logic.colorsDataModel, type: ColorType.cool),
                          columns: <GridColumn>[
                            GridColumn(
                              columnWidthMode: ColumnWidthMode.fill,
                              columnName: 'ID',
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
                              columnName: 'HEX',
                              label: Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'COLOR',
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
                              columnName: 'RED',
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
                              columnWidthMode: ColumnWidthMode.auto,
                              columnName: 'YELLOW',
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
                              columnWidthMode: ColumnWidthMode.auto,
                              columnName: 'BLUE',
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
                              columnName: 'WHITE',
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
                              columnName: 'BLACK',
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
                              columnName: 'MATCH',
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
        ),
      ),
    );
  }
}

class ColorDataSource extends DataGridSource {
  ColorDataSource({required this.colors, required this.type});

  final List<ColorPalletMixer> colors;
  final ColorType type;
  final BaseColorGenerator baseColorGenerator = BaseColorGenerator();
  int id = 0;

  @override
  List<DataGridRow> get rows {
    id = 0;
    return colors
        .map<DataGridRow>(
          (dataRow) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'ID',
                value: (id++).toString(),
              ),
              DataGridCell<String>(
                columnName: 'HEX',
                value: dataRow.targetColor.toHexString(),
              ),
              DataGridCell<String>(
                columnName: 'RED',
                value: dataRow.colorCount(baseColorGenerator.getRed(type)).toString(),
              ),
              DataGridCell<String>(
                columnName: 'YELLOW',
                value: dataRow.colorCount(baseColorGenerator.getYellow(type)).toString(),
              ),
              DataGridCell<String>(
                columnName: 'BLUE',
                value: dataRow.colorCount(baseColorGenerator.getBlue(type)).toString(),
              ),
              DataGridCell<String>(
                columnName: 'WHITE',
                value: dataRow.colorCount(baseColorGenerator.getWhite(type)).toString(),
              ),
              DataGridCell<String>(
                columnName: 'BLACK',
                value: dataRow.colorCount(baseColorGenerator.getBlack(type)).toString(),
              ),
              DataGridCell<String>(
                columnName: 'MATCH',
                value: dataRow.matchWithTarget(dataRow.targetColor).toStringAsFixed(2) + '%',
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  bool shouldRecalculateColumnWidths() {
    return true;
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'HEX') {
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
