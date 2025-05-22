enum BuildConfigType { develop, release }

enum BuildConfigFlavor { main }

extension BuildConfigTypeExt on BuildConfigType {
  String get stringify => toString().split('.').last;
}

extension BuildConfigFlavorExt on BuildConfigFlavor {
  String get stringify => toString().split('.').last;
}

class BuildConfig {
  static late BuildConfig instance;
  final BuildConfigType type;
  final BuildConfigFlavor flavor;
  final String apiBaseUrl;

  static const String _mainBaseUrl = "https://dev-techtest.swfast.com.br";

  BuildConfig.main({
    this.type = BuildConfigType.release,
    this.flavor = BuildConfigFlavor.main,
    this.apiBaseUrl = _mainBaseUrl,
  }) {
    instance = this;
  }
}
