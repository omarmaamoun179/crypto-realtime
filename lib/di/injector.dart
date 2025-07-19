import 'package:crypto_realtime/core/bloc/cubit/theme_cubit.dart';

import '../core/network/network_service.dart';
import '../features/home_crypto/data/datasources/home_remote_data_source.dart';
import '../features/home_crypto/data/repositories/home_crypto_repository.dart';
import '../features/home_crypto/presentation/cubit/home_crypto_cubit.dart';

class Injector {
  final _flyweightMap = <String, dynamic>{};
  static final _singleton = Injector._internal();

  Injector._internal();
  factory Injector() => _singleton;
  NetworkServiceUtil get networkServiceUtil =>
      _flyweightMap['networkServiceUtil'] ??= NetworkServiceUtilImpl();

  NetworkService get networkService => _flyweightMap['networkService'] ??=
      NetworkServiceImpl(networkServiceUtil);

  HomeRemoteDataSource get homeRemoteDataSource =>
      _flyweightMap['homeRemoteDataSource'] ??=
          HomeRemoteDataSourceImpl(networkService);

  HomeCryptoRepository get homeCryptoRepository =>
      _flyweightMap['homeCryptoRepository'] ??=
          HomeCryptoRepositoryImpl(homeRemoteDataSource);

  HomeCryptoCubit get homeCryptoCubit => HomeCryptoCubit(homeCryptoRepository);

  ThemeCubit get themeCubit => ThemeCubit();
}
