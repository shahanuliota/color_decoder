import 'dart:convert';
import 'dart:ui';

import '../extensions/color.decoder.dart';

class ColorPalateReverse {
  ColorPalateReverse({
    required this.baseColors,
    required this.targetColor,
  })  : assert(baseColors.isNotEmpty, 'baseColors must not be empty'),
        _reverserWithDelete = _ColorPalateReverse(
          baseColors: [...baseColors],
          targetColor: targetColor,
        ),
        _reverser = _ColorPalateReverse(
          baseColors: [...baseColors],
          targetColor: targetColor,
        );

  final _ColorPalateReverse _reverserWithDelete;

  final _ColorPalateReverse _reverser;

  //= _ColorPalateReverse(baseColors: baseColors, targetColor: targetColor);

  final List<Color> baseColors;

  final Color targetColor;
  double _globalMaxMatch = 0.0;

  double get globalMaxMatch => _globalMaxMatch;
  List<Color> _bestList = <Color>[];

  List<Color> get bestList => _bestList;
  int _totalStepTook = 0;

  int get totalStepTook => _totalStepTook;

  List<Color> reverse(List<Color> colorsList) {
    List<Color> list = _reverser.reverse(colorsList, false);
    List<Color> listWithDelete = _reverserWithDelete.reverse(colorsList, true);

    Color mixer = mixColors([...list]);
    double temp1 = mixer.match(targetColor);

    Color mixerWithDelete = mixColors([...listWithDelete]);
    double tempWithDelete = mixerWithDelete.match(targetColor);

    List<Color> res = <Color>[];

    print('tempWithDelete $tempWithDelete : temp1 $temp1  ${temp1 > tempWithDelete}');

    if (tempWithDelete == temp1) {
      _totalStepTook = list.length < listWithDelete.length
          ? _reverser.totalStepTook
          : _reverserWithDelete.totalStepTook;

      res = list.length < listWithDelete.length ? list : listWithDelete;
    } else if (temp1 > tempWithDelete) {
      _totalStepTook = _reverser.totalStepTook;
      res = list;
    } else {
      _totalStepTook = _reverserWithDelete.totalStepTook;
      res = listWithDelete;
    }
    Color resMixer = mixColors([...res]);
    _globalMaxMatch = resMixer.match(targetColor);
    _bestList = res;
    return res;
  }
}

class _ColorPalateReverse {
  _ColorPalateReverse({
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

  List<Color> reverse(List<Color> colorsList, bool withDelete) {
    List<Color> rec = _reverse(colorsList, withDelete);
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

  BestMatchList _addColorAndCheckMixers(List<Color> colorsList) {
    double maxMatch = 0.0;
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
        maxMatch = 100.0;
        _setBestMatch(colorsList);
        return BestMatchList(colorsList: [...colorsList, color], match: maxMatch);
      }
    }

    return BestMatchList(colorsList: tempBestMixerList, match: maxMatch);
  }

  BestMatchList _deleteColorAndCheckMixers(List<Color> colorsList) {
    double maxMatch = 0.0;
    List<Color> tempBestMixerList = <Color>[];
    List<Color> tempColor = colorsList.toList();

    for (int i = 0; i < baseColors.length; i++) {
      tempColor = colorsList.toList();
      Color color = baseColors[i];
      bool b = tempColor.remove(color);

      if (tempColor.isNotEmpty && b) {
        /// mix and match
        Color mixer = mixColors([...tempColor]);
        double temp = mixer.match(targetColor);

        if (temp >= maxMatch) {
          maxMatch = temp;
          tempBestMixerList = [...tempColor];
        }

        if (temp >= 100.0) {
          _globalMaxMatch = 100.0;
          maxMatch = 100.0;
          _setBestMatch(colorsList);
          return BestMatchList(colorsList: [...tempColor], match: maxMatch);
        }
      }
    }

    return BestMatchList(colorsList: tempBestMixerList, match: maxMatch);
  }

  List<Color> _reverse(List<Color> colorsList, bool withDelete) {
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
      // for (int i = 0; i < baseColors.length; i++) {
      //   Color color = baseColors[i];
      //
      //   /// mix and match
      //   Color mixer = mixColors([...colorsList, color]);
      //   double temp = mixer.match(targetColor);
      //
      //   if (temp >= maxMatch) {
      //     maxMatch = temp;
      //     tempBestMixerList = [...colorsList, color];
      //   }
      //
      //   if (temp >= 100.0) {
      //     _globalMaxMatch = 100.0;
      //     _setBestMatch(colorsList);
      //     return [...colorsList, color];
      //   }
      // }

      BestMatchList addListModel = _addColorAndCheckMixers([...colorsList]);

      if (maxMatch < addListModel.match) {
        maxMatch = addListModel.match;
        tempBestMixerList = addListModel.colorsList;
      }

      if (withDelete == true) {
        BestMatchList deleteListModel = _deleteColorAndCheckMixers([...colorsList]);
        if (maxMatch < deleteListModel.match) {
          maxMatch = deleteListModel.match;
          tempBestMixerList = deleteListModel.colorsList;
        }
      }

      if (maxMatch > _globalMaxMatch) {
        _globalMaxMatch = maxMatch;
        colorsList = [...compareAndReturnBestList(colorsList, tempBestMixerList)];
        _setBestMatch(colorsList);
      } else {
        List<Color> returnList = [...tempBestMixerList]; //
        // compareAndReturnBestList(colorsList, tempBestMixerList);

        if (_sameStapeCount < 250) {
          _sameStapeCount++;
          colorsList = [...returnList];
        } else {
          return compareAndReturnBestList(colorsList, tempBestMixerList);
          // return [...returnList];
        }
      }
    }

    if (mixColors(colorsList).match(targetColor) >= 100.0) {
      _globalMaxMatch = 100.0;
      _setBestMatch(colorsList);
      return [...colorsList];
    } else {
      return _reverse([...colorsList], withDelete);
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

class BestMatchList {
  List<Color> colorsList;
  double match;

  BestMatchList({required this.colorsList, required this.match});

  Map<String, dynamic> toJson() => {
        'color': colorsList.map((e) => e.toHexString()).toList(),
        'match': match,
      };

  @override
  String toString() {
    // TODO: implement toString
    return const JsonEncoder.withIndent(' ').convert(toJson());
  }
}
