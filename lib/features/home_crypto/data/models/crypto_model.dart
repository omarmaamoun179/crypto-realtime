// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CryptoModel {
  String? code;
  String? message;
  List<CryptoCoin>? data;
  CryptoModel({
    this.code,
    this.message,
    this.data,
  });

  CryptoModel copyWith({
    String? code,
    String? message,
    List<CryptoCoin>? data,
  }) {
    return CryptoModel(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory CryptoModel.fromMap(Map<String, dynamic> map) {
    return CryptoModel(
      code: map['code'] != null ? map['code'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null
          ? List<CryptoCoin>.from(
              (map['data'] as List<dynamic>).map<CryptoCoin?>(
                (x) => CryptoCoin.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoModel.fromJson(String source) =>
      CryptoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CryptoModel(code: $code, message: $message, data: $data)';

  @override
  bool operator ==(covariant CryptoModel other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ data.hashCode;
}

class CryptoCoin {
  String? instType;
  String? instId;
  String? last;
  String? lastSz;
  String? askPx;
  String? askSz;
  String? bidPx;
  String? bidSz;
  String? open24h;
  String? high24h;
  String? low24h;
  String? volCcy24h;
  String? vol24h;
  String? ts;
  CryptoCoin({
    this.instType,
    this.instId,
    this.last,
    this.lastSz,
    this.askPx,
    this.askSz,
    this.bidPx,
    this.bidSz,
    this.open24h,
    this.high24h,
    this.low24h,
    this.volCcy24h,
    this.vol24h,
    this.ts,
  });

  CryptoCoin copyWith({
    String? instType,
    String? instId,
    String? last,
    String? lastSz,
    String? askPx,
    String? askSz,
    String? bidPx,
    String? bidSz,
    String? open24h,
    String? high24h,
    String? low24h,
    String? volCcy24h,
    String? vol24h,
    String? ts,
  }) {
    return CryptoCoin(
      instType: instType ?? this.instType,
      instId: instId ?? this.instId,
      last: last ?? this.last,
      lastSz: lastSz ?? this.lastSz,
      askPx: askPx ?? this.askPx,
      askSz: askSz ?? this.askSz,
      bidPx: bidPx ?? this.bidPx,
      bidSz: bidSz ?? this.bidSz,
      open24h: open24h ?? this.open24h,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      volCcy24h: volCcy24h ?? this.volCcy24h,
      vol24h: vol24h ?? this.vol24h,
      ts: ts ?? this.ts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'instType': instType,
      'instId': instId,
      'last': last,
      'lastSz': lastSz,
      'askPx': askPx,
      'askSz': askSz,
      'bidPx': bidPx,
      'bidSz': bidSz,
      'open24h': open24h,
      'high24h': high24h,
      'low24h': low24h,
      'volCcy24h': volCcy24h,
      'vol24h': vol24h,
      'ts': ts,
    };
  }

  factory CryptoCoin.fromMap(Map<String, dynamic> map) {
    return CryptoCoin(
      instType: map['instType'] != null ? map['instType'] as String : null,
      instId: map['instId'] != null ? map['instId'] as String : null,
      last: map['last'] != null ? map['last'] as String : null,
      lastSz: map['lastSz'] != null ? map['lastSz'] as String : null,
      askPx: map['askPx'] != null ? map['askPx'] as String : null,
      askSz: map['askSz'] != null ? map['askSz'] as String : null,
      bidPx: map['bidPx'] != null ? map['bidPx'] as String : null,
      bidSz: map['bidSz'] != null ? map['bidSz'] as String : null,
      open24h: map['open24h'] != null ? map['open24h'] as String : null,
      high24h: map['high24h'] != null ? map['high24h'] as String : null,
      low24h: map['low24h'] != null ? map['low24h'] as String : null,
      volCcy24h: map['volCcy24h'] != null ? map['volCcy24h'] as String : null,
      vol24h: map['vol24h'] != null ? map['vol24h'] as String : null,
      ts: map['ts'] != null ? map['ts'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoCoin.fromJson(String source) =>
      CryptoCoin.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CryptoCoin(instType: $instType, instId: $instId, last: $last, lastSz: $lastSz, askPx: $askPx, askSz: $askSz, bidPx: $bidPx, bidSz: $bidSz, open24h: $open24h, high24h: $high24h, low24h: $low24h, volCcy24h: $volCcy24h, vol24h: $vol24h, ts: $ts)';
  }

  @override
  bool operator ==(covariant CryptoCoin other) {
    if (identical(this, other)) return true;

    return other.instType == instType &&
        other.instId == instId &&
        other.last == last &&
        other.lastSz == lastSz &&
        other.askPx == askPx &&
        other.askSz == askSz &&
        other.bidPx == bidPx &&
        other.bidSz == bidSz &&
        other.open24h == open24h &&
        other.high24h == high24h &&
        other.low24h == low24h &&
        other.volCcy24h == volCcy24h &&
        other.vol24h == vol24h &&
        other.ts == ts;
  }

  @override
  int get hashCode {
    return instType.hashCode ^
        instId.hashCode ^
        last.hashCode ^
        lastSz.hashCode ^
        askPx.hashCode ^
        askSz.hashCode ^
        bidPx.hashCode ^
        bidSz.hashCode ^
        open24h.hashCode ^
        high24h.hashCode ^
        low24h.hashCode ^
        volCcy24h.hashCode ^
        vol24h.hashCode ^
        ts.hashCode;
  }
}
