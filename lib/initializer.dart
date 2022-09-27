import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'config.dart';
import 'core/http_interceptors/request.intersepter.dart';

class Initializer {
  static Future<void> init() async {
    _initStorage();
    _initGetConnect();
    _initServerGetConnect();
  }

  static Future<void> test() async {
    _initGetConnect();
    _initServerGetConnect();
  }

  /// http client
  static Future<void> _initGetConnect() async {
    final connect = GetConnect();
    final AppConfigData env = ConfigEnvironments.getEnvironments();
    connect.baseUrl = env.url;
    connect.timeout = const Duration(seconds: 60);
    connect.httpClient.maxAuthRetries = 0;
    connect.httpClient.addResponseModifier(RequestInterceptor.responseLogger);
    Get.put(connect);
  }

  static Future<void> _initServerGetConnect() async {
    final connect = GetConnect();
    final AppConfigData env = ConfigEnvironments.getEnvironments();
    connect.baseUrl = env.serverUrl;
    connect.timeout = const Duration(seconds: 60);
    connect.httpClient.maxAuthRetries = 0;

    connect.httpClient.addResponseModifier(RequestInterceptor.responseLogger);
    Get.put(connect, tag: 'server');
  }

  /// local storage
  static Future<void> _initStorage() async {
    await GetStorage.init();
    Get.put(GetStorage());
  }
}
