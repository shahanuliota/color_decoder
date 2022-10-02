import 'dart:convert';
import 'dart:ui';

import '../../core/extensions/color.decoder.dart';

class ColorDataModel {
  ColorDataModel();

  void addColor(Color c) {
    _colors.add(c);
    if (_colorCounter.containsKey(c.toHexString())) {
      _colorCounter[c.toHexString()] = (_colorCounter[c.toHexString()]!) + 1;
    } else {
      _colorCounter[c.toHexString()] = 1;
    }
  }

  final List<Color> _colors = <Color>[];
  final Map<String, int> _colorCounter = <String, int>{};

  List<Color> get colors => _colors;

  Map<String, int> get colorCounterMap => _colorCounter;

  int colorCnt(Color c) {
    return _colorCounter[c.toHexString()] ?? 0;
  }

  double getPercent(Color c) {
    try {
      double count = (colorCounterMap[c.toHexString()] ?? 0).toDouble();

      return (count * 100) / _colors.length;
    } catch (e) {
      return 0.0;
    }
  }

  Color get mixColor => mixColors(_colors);

  double matchPercentageWith(Color c) => mixColor.match(c);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['colors'] = _colors.map((e) => e.toHexString()).toList();
    map['colors_cnt'] = _colorCounter;
    return map;
  }

  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(toJson());
  }
}
