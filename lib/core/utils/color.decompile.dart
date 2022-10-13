// import 'package:flutter/material.dart';
//
// class ColorDeCoder {
//   Map<Color, int> colorCnt = <Color, int>{};
//
//   decoder({required Color target, required List<Color> baseColors}) {}
// }
import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  Color get toColor => this;

  @override
  Type get runtimeType => Color;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Color && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
