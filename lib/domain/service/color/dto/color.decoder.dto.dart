import 'dart:convert';
import 'dart:ui';

import '../../../../core/extensions/color.decoder.dart';

class ColorDecoderDto {
  final List<Color> structure;

  final Color hex;

  ColorDecoderDto({required this.structure, required this.hex});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> mp = <String, dynamic>{};
    Map<String, dynamic> structureMp = <String, dynamic>{};
    for (Color c in structure) {
      structureMp[c.toHexString()] = <String, dynamic>{
        'hex': c.toHexString(),
        'name': c.toHexString(),
        'count': 1
      };
    }

    mp['structure'] = structureMp;
    mp['hex'] = hex.toHexString();

    return mp;
  }

  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(toJson());
  }
}
