import 'package:crypto_realtime/features/home_crypto/data/datasources/home_remote_data_source.dart'
    show HomeRemoteDataSource;
import 'package:crypto_realtime/features/home_crypto/data/models/crypto_model.dart';

abstract class HomeCryptoRepository {
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

class HomeCryptoRepositoryImpl implements HomeCryptoRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeCryptoRepositoryImpl(this._remoteDataSource);

  @override
  Future<CryptoModel> fetchCryptoDataAda() =>
      _remoteDataSource.fetchCryptoDataAda();

  @override
  Future<CryptoModel> fetchCryptoDataBnb() =>
      _remoteDataSource.fetchCryptoDataBnb();

  @override
  Future<CryptoModel> fetchCryptoDataBtc() =>
      _remoteDataSource.fetchCryptoDataBtc();

  @override
  Future<CryptoModel> fetchCryptoDataDog() =>
      _remoteDataSource.fetchCryptoDataDog();

  @override
  Future<CryptoModel> fetchCryptoDataEth() =>
      _remoteDataSource.fetchCryptoDataEth();

  @override
  Future<CryptoModel> fetchCryptoDataSol() =>
      _remoteDataSource.fetchCryptoDataSol();
  @override
  Future<CryptoModel> fetchCryptoDataTrx() =>
      _remoteDataSource.fetchCryptoDataTrx();

  @override
  Future<CryptoModel> fetchCryptoDataXlm() =>
      _remoteDataSource.fetchCryptoDataXlm();

  @override
  Future<CryptoModel> fetchCryptoDataXrp() =>
      _remoteDataSource.fetchCryptoDataXrp();
}
