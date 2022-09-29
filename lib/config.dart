class Environments {
  static const String PRODUCTION = 'prod';
  static const String QAS = 'QAS';
  static const String DEV = 'dev';
  static const String LOCAL = 'local';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.DEV;
  static AppConfigData defultConfig = AppConfigData(
    env: Environments.DEV,
    url: 'https://trycolors.com/',
    serverUrl: '',
  );
  static final List<AppConfigData> _availableEnvironments = [
    AppConfigData(
      env: Environments.LOCAL,
      url: 'http://localhost:3000/',
      serverUrl: '',
    ),
    AppConfigData(
      env: Environments.DEV,
      url: 'https://trycolors.com/',
      serverUrl: '',
    ),
    AppConfigData(
      env: Environments.QAS,
      url: 'https://trycolors.com/',
      serverUrl: '',
    ),
    AppConfigData(
      env: Environments.PRODUCTION,
      url: 'https://trycolors.com/',
      serverUrl: '',
    ),
  ];

  static AppConfigData getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d.env == _currentEnvironments,
      orElse: () => defultConfig,
    );
  }
}

class AppConfigData {
  final String url;
  final String serverUrl;
  final String env;

  //final String userAuthorization;

  AppConfigData({
    required this.url,
    required this.env,
    //required this.userAuthorization,
    required this.serverUrl,
  });
}
