import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/clickable_extensions.dart';
import '../../../../core/extensions/color.decoder.dart';

class ColorBox extends StatelessWidget {
  const ColorBox({
    Key? key,
    required this.color,
    required this.tag,
    this.width = 200.0,
    this.height = 100.0,
  }) : super(key: key);

  final Color color;
  final String tag;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tag,
            style: TextStyle(
              color: color.computeLuminance() > 0.6 ? Colors.black : Colors.white,
            ),
          ),
          Text(
            color.toHexString().toUpperCase(),
            style: TextStyle(
              color: color.computeLuminance() > 0.6 ? Colors.black : Colors.white,
            ),
          ),
          Text(
            color.toRGBString().toUpperCase(),
            style: TextStyle(
              color: color.computeLuminance() > 0.6 ? Colors.black : Colors.white,
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
    );
  }
}
