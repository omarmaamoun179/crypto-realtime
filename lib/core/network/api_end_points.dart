abstract class ApiEndPoint {
  static const domainUrl = 'https://www.okx.com';

  static const BASE_URL = '$domainUrl/api';

  static const _REQUEST_URL = BASE_URL;

  static const String tickers =
      '$_REQUEST_URL/v5/market/ticker';

  //Auth
}
