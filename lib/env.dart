enum Flavor {
  STAG,
  PROD,
}

class Env {
  static Flavor appFlavor;
  static const String API_VERSION = 'v1';

  static String getDomainAPI() {
    switch (appFlavor) {
      case Flavor.PROD:
        return 'https://api.nvmtech.work/api' + '/' + API_VERSION;
      default:
        return 'https://api.nvmtech.work/api' + '/' + API_VERSION;
    }
  }

  static int getTimeOutRequest() {
    switch (appFlavor) {
      case Flavor.PROD:
        return 8000;
      default:
        return 5000;
    }
  }
}
