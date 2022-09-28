import 'dart:convert';

import '../../../core/abstractions/http_connect.interface.dart';
import '../../../core/exceptions/default.exception.dart';
import '../../../core/exceptions/forbidden.exception.dart';
import '../../../core/exceptions/invalid_token.exception.dart';
import '../../../core/exceptions/not_found.exception.dart';
import '../interface/color.service.interface.dart';
import 'dto/color.decoder.dto.dart';
import 'response/color_decoder.response.model.dart';

class ColorDecoderNetworkService extends IColorDecoderService {
  final IHttpConnect _connect;

  String get _prefix => 'api';

  ColorDecoderNetworkService(IHttpConnect connect) : _connect = connect;

  @override
  Future<ColorDecoderResponse> getColorDecoder(ColorDecoderDto dto) async {
    try {
      final response = await _connect.post<ColorDecoderResponse>(
        '$_prefix/mix',
        dto.toString(),
        headers: {
          'Accept': 'application/json',
          // 'Content-Type': 'application/json',
        },
        decoder: (value) {
          return ColorDecoderResponse.fromJson(
            value is String ? json.decode(value) : value as Map,
          );
        },
      );

      if (response.success) {
        return response.payload!;
      } else {
        switch (response.statusCode) {
          case 401:
            throw InvalidTokenException(message: response.payload?.message ?? 'unauthenticated');
          case 403:
            throw ForbiddenException(message: response.payload?.message ?? 'user not verified');
          case 404:
            throw NotFoundException(message: response.payload?.message ?? 'user not verified');
          case 400:
            throw NotFoundException(message: response.payload?.message ?? 'Information not found');
          case 500:
            throw DefaultException(
                message: response.payload?.message ??
                    'Error server failed to provide response, contact admin to get support!');
          default:
            throw DefaultException(
              message: response.payload?.message ?? 'Error loading data, check your internet!',
            );
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
