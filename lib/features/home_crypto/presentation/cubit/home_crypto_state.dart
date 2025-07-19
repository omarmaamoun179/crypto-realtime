// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crypto_realtime/features/home_crypto/data/models/crypto_model.dart';
import 'package:flutter/foundation.dart';

enum HomeCryptoStateStatus {
  initial,
  isEmpty,
  loading,
  loaded,
  error,
}

extension HomeCryptoStateX on HomeCryptoState {
  bool get isInitial => status == HomeCryptoStateStatus.initial;
  bool get isLoading => status == HomeCryptoStateStatus.loading;
  bool get isLoaded => status == HomeCryptoStateStatus.loaded;
  bool get isEmpty => status == HomeCryptoStateStatus.isEmpty;
  bool get isError => status == HomeCryptoStateStatus.error;

}

class HomeCryptoState {
  final HomeCryptoStateStatus status;
  final String? errorMessage;
  final List<CryptoModel>? cryptoCoin;
  Map<String, double>? prevPrice;
  Map<String, double>? currentPrice;
  List<CryptoCoin>? filteredCoins;

  final Map<String, CryptoCoin>? liveCoins;

  HomeCryptoState({
    this.status = HomeCryptoStateStatus.initial,
    this.errorMessage,
    this.cryptoCoin,
    this.prevPrice,
    this.liveCoins,
    this.filteredCoins,
    this.currentPrice,
  });

  HomeCryptoState copyWith({
    HomeCryptoStateStatus? status,
    String? errorMessage,
    List<CryptoModel>? cryptoCoin,
    Map<String, double>? prevPrice,
    Map<String, CryptoCoin>? liveCoins,
    List<CryptoCoin>? filteredCoins,
    Map<String, double>? currentPrice,
  }) {
    return HomeCryptoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      cryptoCoin: cryptoCoin ?? this.cryptoCoin,
      prevPrice: prevPrice ?? this.prevPrice,
      currentPrice: currentPrice ?? this.currentPrice,
      filteredCoins: filteredCoins ?? this.filteredCoins,
      liveCoins: liveCoins ?? this.liveCoins,
    );
  }

  @override
  bool operator ==(covariant HomeCryptoState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.errorMessage == errorMessage &&
        listEquals(other.cryptoCoin, cryptoCoin) &&
        mapEquals(other.currentPrice, currentPrice) &&
        listEquals(other.filteredCoins, filteredCoins) &&
        mapEquals(other.prevPrice, prevPrice) &&
        mapEquals(other.liveCoins, liveCoins);
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      prevPrice.hashCode ^
      currentPrice.hashCode ^
      filteredCoins.hashCode ^
      cryptoCoin.hashCode ^
      liveCoins.hashCode;
}
