import 'dart:convert';

class ColorDecoderResponse {
  Map<String, ColorData> structure = <String, ColorData>{};
  String message = '';

  ColorDecoderResponse({
    this.structure = const <String, ColorData>{},
  });

  ColorDecoderResponse.fromJson(Map<String, dynamic> json) {
    if (json['structure'] is Map) {
      json['structure'].forEach(
        (key, value) {
          structure[key] = ColorData.fromJson(value);
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'structure': structure};
  }

  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(toJson());
  }
}

class ColorData {
  String? hex;
  String? name;
  int? count;

  ColorData({this.hex, this.name, this.count});

  ColorData.fromJson(Map<String, dynamic> json) {
    hex = json['hex'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hex'] = hex;
    data['name'] = name;
    data['count'] = count;
    return data;
  }

  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(toJson());
  }
}
