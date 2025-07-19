class AppImages {
  static const String baseFolder = 'assets/images/png/';
  static const String btc = '${baseFolder}btc.png';
  static const String eth = '${baseFolder}eth.png';
  static const String xrp = '${baseFolder}xrp.png';
  static const String bnb = '${baseFolder}bnb.png';
  static const String sol = '${baseFolder}sol.png';
  static const String doge = '${baseFolder}dodge.png';
  static const String trx = '${baseFolder}trx.png';
  static const String xlm = '${baseFolder}xlm.png';

  static String getImageForCurrency(String currency) {
    switch (currency.toLowerCase().split('-').first) {
      case 'btc':
        return btc;
      case 'eth':
        return eth;
      case 'xrp':
        return xrp;
      case 'bnb':
        return bnb;
      case 'sol':
        return sol;
      case 'doge':
        return doge;
      case 'trx':
        return trx;

      case 'xlm':
        return xlm;
      default:
        return btc; // Default to BTC if currency not found
    }
  }
}
