class Constant {
  static String argsOfWebSocket = '''
      {
        "op": "subscribe",
        "args": [
          {"channel": "tickers", "instId": "BTC-USDT"},
          {"channel": "tickers", "instId": "ETH-USDT"},
          {"channel": "tickers", "instId": "XRP-USDT"},
          {"channel": "tickers", "instId": "BNB-USDT"},
          {"channel": "tickers", "instId": "SOL-USDT"},
          {"channel": "tickers", "instId": "DOGE-USDT"},
          {"channel": "tickers", "instId": "TRX-USDT"},
          {"channel": "tickers", "instId": "XLM-USDT"}
        ]
      }
      ''';
}
