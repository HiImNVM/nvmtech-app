enum Flavor {
  STAG,
  PROD,
}

class Env {
  static Flavor appFlavor;
  static const String API_VERSION = 'v1';

  static String getDomainAPI() {
    switch (appFlavor) {
      case Flavor.STAG:
        return 'http://api.nvmtech.work' + '/' + API_VERSION;
      default:
        return 'https://api.nvmtech.work' + '/' + API_VERSION;
    }
  }
}
