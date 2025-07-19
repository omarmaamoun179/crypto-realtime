import 'dart:convert';

import 'package:crypto_realtime/core/const/constant.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../core/abstract/base_cubit.dart';
import '../../data/models/crypto_model.dart';
import '../../data/repositories/home_crypto_repository.dart';
import 'home_crypto_state.dart';

class HomeCryptoCubit extends BaseCubit<HomeCryptoState> {
  final HomeCryptoRepository _homeCryptoRepository;
  HomeCryptoCubit(this._homeCryptoRepository) : super(HomeCryptoState());

  Future<void> fetchAllCryptoData({bool isRefresh = false}) async {
    if (!isRefresh) emit(state.copyWith(status: HomeCryptoStateStatus.loading));
    try {
      final results = await Future.wait([
        _homeCryptoRepository.fetchCryptoDataBtc(),
        _homeCryptoRepository.fetchCryptoDataEth(),
        _homeCryptoRepository.fetchCryptoDataXrp(),
        _homeCryptoRepository.fetchCryptoDataBnb(),
        _homeCryptoRepository.fetchCryptoDataSol(),
        _homeCryptoRepository.fetchCryptoDataDog(),
        _homeCryptoRepository.fetchCryptoDataTrx(),
        _homeCryptoRepository.fetchCryptoDataXlm(),
      ]);
      final liveMap = <String, CryptoCoin>{};
      final prevPrices = <String, double>{};
      final currentPrices = <String, double>{};

      for (final model in results) {
        final coin = model.data!.first;
        liveMap[coin.instId ?? ""] = coin;
        prevPrices[coin.instId ?? ""] =
            double.tryParse(coin.last ?? '0') ?? 0.0;
        currentPrices[coin.instId ?? ""] =
            double.tryParse(coin.last ?? '0') ?? 0.0;
      }
      emit(state.copyWith(
        status: HomeCryptoStateStatus.loaded,
        cryptoCoin: results,
        prevPrice: prevPrices,
        currentPrice: currentPrices,
        filteredCoins: liveMap.values.toList(),
        liveCoins: liveMap,
      ));
      connectToWebSocket();
    } catch (e) {
      emit(state.copyWith(
        status: HomeCryptoStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void search(String query) {
    final allCoins = state.liveCoins?.values.toList() ?? [];
    if (query.isEmpty) {
      emit(state.copyWith(
        status: HomeCryptoStateStatus.loaded,
        filteredCoins: allCoins,
      ));
      return;
    }
    final filteredCoins = allCoins.where((coin) {
      return coin.instId?.toLowerCase().contains(query.toLowerCase()) ?? false;
    }).toList();

    if (filteredCoins.isEmpty) {
      emit(state.copyWith(
        status: HomeCryptoStateStatus.isEmpty,
        filteredCoins: [],
      ));
    } else {
      emit(state.copyWith(
        status: HomeCryptoStateStatus.loaded,
        filteredCoins: filteredCoins,
      ));
    }
  }

  Future<void> refresh() async {
    await fetchAllCryptoData(isRefresh: true);
  }

  void connectToWebSocket() {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.okx.com:8443/ws/v5/public'),
    );

    channel.sink.add(Constant.argsOfWebSocket);
    channel.stream.listen((event) {
      final data = jsonDecode(event);
      if (data['arg'] != null && data['data'] != null) {
        final symbol = data['arg']['instId'];
        final ticker = data['data'][0];
        final currentPrice = double.tryParse(ticker['last'] ?? '0') ?? 0.0;

        var map = {
          'instType': ticker['instType'],
          'instId': ticker['instId'],
          'last': ticker['last'],
          'lastSz': ticker['lastSz'],
          'askPx': ticker['askPx'],
          'askSz': ticker['askSz'],
          'bidPx': ticker['bidPx'],
          'bidSz': ticker['bidSz'],
          'open24h': ticker['open24h'],
          'high24h': ticker['high24h'],
          'low24h': ticker['low24h'],
          'volCcy24h': ticker['volCcy24h'],
          'vol24h': ticker['vol24h'],
          'ts': ticker['ts'],
        };
        final liveCoin = CryptoCoin.fromMap(map);

        final updated = Map<String, CryptoCoin>.from(state.liveCoins!);

        resetInitialPricesAfterTenSec(symbol, currentPrice);

        final currentPrices = Map<String, double>.from(state.currentPrice!);

        currentPrices[symbol] = currentPrice;
        updated[symbol] = liveCoin;

        emit(state.copyWith(liveCoins: updated, currentPrice: currentPrices));
      }
    }, onError: (error) {
      channel.sink.close();
    }, onDone: () {});
  }

  void resetInitialPricesAfterTenSec(symbol, double currentPrice) {
    Future.delayed(
      const Duration(seconds: 10),
      () {
        if (state.prevPrice != null) {
          final prevPrices = Map<String, double>.from(state.prevPrice!);
          prevPrices[symbol] = currentPrice;
          emit(state.copyWith(prevPrice: prevPrices));
        }
      },
    );
  }
}
