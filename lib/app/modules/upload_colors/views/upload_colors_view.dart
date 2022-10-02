import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/extensions/color.decoder.dart';
import '../../../../core/utils/excle_to_color_list.dart';
import '../controllers/upload_colors_controller.dart';

class UploadColorsView extends GetView<UploadColorsController> {
  UploadColorsView();

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  final DataGridController _controller = DataGridController();

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
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: min(Get.width, 1000),
                  child: SfDataGrid(
                    key: _key,
                    controller: _controller,
                    source: ColorDataSource(
                      colors: <Color>[
                        Colors.red,
                        Colors.red,
                        Colors.red,
                      ],
                    ),
                    columns: <GridColumn>[
                      GridColumn(
                        columnName: 'Color',
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
                        columnName: 'Color',
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorDataSource extends DataGridSource {
  ColorDataSource({required this.colors});

  final List<Color> colors;

  @override
  List<DataGridRow> get rows => colors
      .map<DataGridRow>(
        (dataRow) => DataGridRow(
          cells: [
            DataGridCell<String>(
              columnName: 'Hex',
              value: dataRow.toHexString(),
            ),
            DataGridCell<String>(columnName: 'name', value: dataRow.value.toString()),
            // DataGridCell<String>(columnName: 'designation', value: dataRow.designation),
            // DataGridCell<int>(columnName: 'salary', value: dataRow.salary),
          ],
        ),
      )
      .toList();

  @override
  bool shouldRecalculateColumnWidths() {
    return true;
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
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
