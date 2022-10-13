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

  List<String> get colorNames => _colorCounter.keys.toList();

  List<int> get colorValues => _colorCounter.values.toList();

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

class NormalizedColorData extends ColorDataModel {
  final List<Color> baseColors;

  NormalizedColorData({required this.baseColors});

  final Map<String, int> _normalizedStep1 = <String, int>{};
  final Map<String, int> _normalizedStep2 = <String, int>{};
  final Map<String, int> _normalizedStep3 = <String, int>{};

  Map<String, int> get normalizedStep1 => _normalizedStep1;

  @override
  Map<String, int> get colorCounterMap => _normalizedStep2;

  @override
  int colorCnt(Color c) {
    return _normalizedStep3[c.toHexString()] ?? 0;
  }

  int _stepTwoCalculate(int colorNo) {
    if (colorNo == 0) return 0;

    // print('----------------------Start 2------$colorNo--------------------------------');
    int countZero = 0;

    List<int> list = <int>[];

    for (int i = 0; i < baseColors.length; i++) {
      Color color = baseColors[i];

      int count = _normalizedStep1[color.toHexString()] ?? 0;
      list.add(count);

      if (count == 0) {
        countZero++;
      }
    }

    int small = SMALL(list, countZero);
    return (colorNo / small).round();
  }

  int SMALL(List<int> list, int kth) {
    list.sort();
    // print('small kth: $kth value: ${list[kth]}');
    return list[kth];
  }

  void step1() {
    for (int i = 0; i < baseColors.length; i++) {
      Color color = baseColors[i];
      int count = super.colorCnt(color);

      if (i % 2 == 0) {
        count = (count ~/ 4);
      }
      _normalizedStep1[color.toHexString()] = count;
    }

    print('_normalizedStep1=> $_normalizedStep1');
  }

  void step2() {
    for (int i = 0; i < baseColors.length; i++) {
      Color color = baseColors[i];
      int count = _normalizedStep1[color.toHexString()] ?? 0;
      _normalizedStep2[color.toHexString()] = _stepTwoCalculate(count);
    }

    print('_normalizedStep2=> $_normalizedStep2');
  }

  int _stepThreeCalculate(int colorNo) {
    int max = 0;
    for (int i = 0; i < baseColors.length; i++) {
      Color color = baseColors[i];
      int count = _normalizedStep2[color.toHexString()] ?? 0;
      if (count > max) {
        max = count;
      }
    }

    int round = (max / 10).round();
    return (colorNo / round).round();
  }

  void normalized() {
    step1();
    step2();
    step3();
  }

  void step3() {
    int max = 0;
    for (int i = 0; i < baseColors.length; i++) {
      Color color = baseColors[i];
      int count = _normalizedStep2[color.toHexString()] ?? 0;
      if (count > max) {
        max = count;
      }
    }

    if (max < 11) {
      _normalizedStep3.addAll(_normalizedStep2);
    } else {
      for (int i = 0; i < baseColors.length; i++) {
        Color color = baseColors[i];
        int count = _normalizedStep2[color.toHexString()] ?? 0;
        _normalizedStep3[color.toHexString()] = _stepThreeCalculate(count);
      }
    }
  }
}
