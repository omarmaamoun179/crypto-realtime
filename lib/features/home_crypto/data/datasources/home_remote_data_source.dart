import '../../../../core/network/network_service.dart';
import '../../../../core/services/request_exception.dart';
import '../models/crypto_model.dart';

import '../../../../core/network/api_end_points.dart';

abstract class HomeRemoteDataSource {
  Future<CryptoModel> fetchCryptoDataBtc();
  Future<CryptoModel> fetchCryptoDataEth();
  Future<CryptoModel> fetchCryptoDataXrp();
  Future<CryptoModel> fetchCryptoDataBnb();
  Future<CryptoModel> fetchCryptoDataSol();
  Future<CryptoModel> fetchCryptoDataDog();
  Future<CryptoModel> fetchCryptoDataTrx();
  Future<CryptoModel> fetchCryptoDataAda();
  Future<CryptoModel> fetchCryptoDataXlm();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkService _networkService;

  HomeRemoteDataSourceImpl(this._networkService);

  @override
  Future<CryptoModel> fetchCryptoDataBtc() {
    return _networkService
        .get(ApiEndPoint.tickers, queryParameters: {"instId": "BTC-USDT"}).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(response.data['msg']);

        final result = response.data;
        final resultStatus = result['code'];
        if (resultStatus == 0) throw RequestException(result['msg']);

        return CryptoModel.fromMap(result);
      },
    );
  }

  @override
  Future<CryptoModel> fetchCryptoDataEth() {
    return _networkService
        .get(ApiEndPoint.tickers, queryParameters: {"instId": "ETH-USDT"}).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(response.data['msg']);

        final result = response.data;
        final resultStatus = result['code'];
        if (resultStatus == 0) throw RequestException(result['msg']);

        return CryptoModel.fromMap(result);
      },
    );
  }

  @override
  Future<CryptoModel> fetchCryptoDataXrp() {
    return _networkService
        .get(ApiEndPoint.tickers, queryParameters: {"instId": "XRP-USDT"}).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(response.data['msg']);

        final result = response.data;
        final resultStatus = result['code'];
        if (resultStatus == 0) throw RequestException(result['msg']);

        return CryptoModel.fromMap(result);
      },
    );
  }

  @override
  Future<CryptoModel> fetchCryptoDataBnb() {
    return _networkService
        .get(ApiEndPoint.tickers, queryParameters: {"instId": "BNB-USDT"}).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(response.data['msg']);

        final result = response.data;
        final resultStatus = result['code'];
        if (resultStatus == 0) throw RequestException(result['msg']);

        return CryptoModel.fromMap(result);
      },
    );
  }

  @override
  Future<CryptoModel> fetchCryptoDataSol() {
    return _networkService
        .get(ApiEndPoint.tickers, queryParameters: {"instId": "SOL-USDT"}).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(response.data['msg']);

        final result = response.data;
        final resultStatus = result['code'];
        if (resultStatus == 0) throw RequestException(result['msg']);

        return CryptoModel.fromMap(result);
      },
    );
  }

  @override
  Future<CryptoModel> fetchCryptoDataDog() {
    return _networkService.get(ApiEndPoint.tickers,
        queryParameters: {"instId": "DOGE-USDT"}).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(response.data['msg']);

        final result = response.data;
        final resultStatus = result['code'];
        if (resultStatus == 0) throw RequestException(result['msg']);

        return CryptoModel.fromMap(result);
      },
    );
  }

  @override
  Future<CryptoModel> fetchCryptoDataTrx() {
    return _networkService
        .get(ApiEndPoint.tickers, queryParameters: {"instId": "TRX-USDT"}).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(response.data['msg']);

        final result = response.data;
        final resultStatus = result['code'];
        if (resultStatus == 0) throw RequestException(result['msg']);

        return CryptoModel.fromMap(result);
      },
    );
  }

  @override
  Future<CryptoModel> fetchCryptoDataAda() {
    return _networkService
        .get(ApiEndPoint.tickers, queryParameters: {"instId": "ADA-USDT"}).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(response.data['msg']);
        final result = response.data;
        final resultStatus = result['code'];
        if (resultStatus == 0) throw RequestException(result['msg']);

        return CryptoModel.fromMap(result);
      },
    );
  }

  @override
  Future<CryptoModel> fetchCryptoDataXlm() {
    return _networkService
        .get(ApiEndPoint.tickers, queryParameters: {"instId": "XLM-USDT"}).then(
      (response) {
        if (response.statusCode != 200)
          throw RequestException(response.data['msg']);

        final result = response.data;
        final resultStatus = result['code'];
        if (resultStatus == 0) throw RequestException(result['msg']);

        return CryptoModel.fromMap(result);
      },
    );
  }
}
