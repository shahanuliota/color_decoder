import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

import '../extensions/color.decoder.dart';

class ExcelToColors {
  Future<List<Color>> pickAndGetColors() async {
    try {
      List<int> bytes = await _pickExcelFile();
      List<List> rows = _convertBytesToExcel(bytes);
      return _rowsFromColor(rows);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<int>> _pickExcelFile() async {
    try {
      FilePickerResult? file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'csv', 'xls'],
      );

      if (file != null) {
        final List<int> bytes = file.files.first.bytes ?? [];
        print(bytes.length);
        return bytes;
      }
      throw new Exception('file not found');
    } catch (e) {
      rethrow;
    }
  }

  List<List> _convertBytesToExcel(List<int> bytes) {
    try {
      var target = 'All Hex codes';
      var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
      print(decoder.tables);
      SpreadsheetTable table = decoder.tables[target]!;
      return table.rows;
    } catch (e) {
      rethrow;
    }
  }

  List<Color> _rowsFromColor(List<List> rows) {
    try {
      List<Color> colors = [];

      int rowLength = rows.length;

      for (int i = 0; i < rowLength; i++) {
        var row = rows[i];
        String? xString = row[0];

        if (xString != null) {
          if (GetUtils.isHexadecimal(xString) == true &&
              (xString).length == 7 &&
              xString.startsWith('#')) {
            // print(xString);
            Color color = HexColor(xString);
            colors.add(color);
          }
        }
      }

      return colors;
    } catch (e) {
      rethrow;
    }
  }
}
