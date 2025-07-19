class RequestException implements Exception {
  final String _message;

  RequestException(message)
      : _message = (message ??= 'connection error') is String
            ? message.isEmpty
                ? 'connection error'
                : message
            : message is List
                ? message.join(',\n')
                : message.toString();

  String get message => _message;

  @override
  String toString() => _message;
}
