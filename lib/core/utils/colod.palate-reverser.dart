import 'dart:convert';
import 'dart:ui';

import '../extensions/color.decoder.dart';

class ColorPalateReverse {
  ColorPalateReverse({
    required this.baseColors,
    required this.targetColor,
  }) : assert(baseColors.isNotEmpty, 'baseColors must not be empty');

  final List<Color> baseColors;

  final Color targetColor;
  double _globalMaxMatch = 0.0;

  double get globalMaxMatch => _globalMaxMatch;

  BestMatch _bestMatchFromList(List<Color> list) {
    assert(list.isNotEmpty, 'list must not be empty');
    double match = 0.0;
    Color bestMatchColor = list.first;
    for (int i = 0; i < list.length; i++) {
      Color color = list[i];
      double temp = color.match(targetColor);
      if (temp > match) {
        match = temp;
        bestMatchColor = color;
      }
    }

    return BestMatch(
      color: bestMatchColor,
      match: match,
    );
  }

  int _totalStepTook = 0;
  int _sameStapeCount = 0;

  int get totalStepTook => _totalStepTook;
  List<Color> _bestList = <Color>[];

  List<Color> get bestList => _bestList;

  double _matchFromList(List<Color> list) {
    Color mixer = mixColors(list);
    double temp = mixer.match(targetColor);
    return temp;
  }

  List<Color> compareAndReturnBestList(List<Color> colorsList, List<Color> tempBestMixerList) {
    //return [...tempBestMixerList];
    double colorListMatch = _matchFromList(colorsList);
    double tempBestMixerListMatch = _matchFromList(tempBestMixerList);
    if (colorListMatch > tempBestMixerListMatch) {
      return [...colorsList];
    } else {
      return [...tempBestMixerList];
    }
  }

  void _setBestMatch(List<Color> colorList) {
    _bestList = colorList;
  }

  List<Color> reverse(List<Color> colorsList) {
    List<Color> rec = _reverse(colorsList);
    // _bestList = [
    //   ...compareAndReturnBestList([...bestList], rec)
    // ];
    // return _bestList;

    Color mixer = mixColors([...rec]);
    double temp = mixer.match(targetColor);

    Color mixer2 = mixColors([..._bestList]);
    double temp2 = mixer2.match(targetColor);
    List<Color> l = temp > temp2 ? rec : bestList;
    _setBestMatch(l);

    return l;
  }

  List<Color> _reverse(List<Color> colorsList) {
    _totalStepTook++;
    // print(
    //     'totalStepTook: $totalStepTook  => bestMatchColor: $_globalMaxMatch colorsList=> ${colorsList.length}');
    double maxMatch = 0.0;

    if (colorsList.isEmpty) {
      BestMatch bestMatch = _bestMatchFromList(baseColors);
      colorsList = [bestMatch.color];
      _globalMaxMatch = bestMatch.match;
    } else {
      List<Color> tempBestMixerList = <Color>[];
      for (int i = 0; i < baseColors.length; i++) {
        Color color = baseColors[i];

        /// mix and match
        Color mixer = mixColors([...colorsList, color]);
        double temp = mixer.match(targetColor);

        if (temp >= maxMatch) {
          maxMatch = temp;
          tempBestMixerList = [...colorsList, color];
        }

        if (temp >= 100.0) {
          _globalMaxMatch = 100.0;
          _setBestMatch(colorsList);
          return [...colorsList, color];
        }
      }

      // print(
      //     'maxMatch > globalMaxMatch = $maxMatch > $_globalMaxMatch => ${maxMatch > _globalMaxMatch} ');
      if (maxMatch > _globalMaxMatch) {
        _globalMaxMatch = maxMatch;
        colorsList = [...compareAndReturnBestList(colorsList, tempBestMixerList)];
        _setBestMatch(colorsList);
      } else {
        List<Color> returnList = [
          ...tempBestMixerList
        ]; //compareAndReturnBestList(colorsList, tempBestMixerList);

        if (_sameStapeCount < 100) {
          _sameStapeCount++;
          colorsList = [...returnList];
        } else {
          return [...returnList];
        }
      }
    }

    if (mixColors(colorsList).match(targetColor) >= 100.0) {
      _globalMaxMatch = 100.0;
      _setBestMatch(colorsList);
      return [...colorsList];
    } else {
      return _reverse([...colorsList]);
    }
  }
}

class BestMatch {
  Color color;
  double match;

  BestMatch({required this.color, required this.match});

  Map<String, dynamic> toJson() => {
        'color': color.toHexString(),
        'match': match,
      };

  @override
  String toString() {
    // TODO: implement toString
    return const JsonEncoder.withIndent(' ').convert(toJson());
  }
}
