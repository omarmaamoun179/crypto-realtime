import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:crypto_realtime/core/services/request_exception.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:requests_inspector/requests_inspector.dart';

import '../../main.dart';
import '../services/redundant_request_exception.dart';

abstract class NetworkService {
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response> downloadFile(
    String apiBaseUrl,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Uint8List> readBytes(String apiBaseUrl);

  Future<Map<String, dynamic>> getDefaultHeaders([String? language]);
}

class NetworkServiceImpl implements NetworkService {
  NetworkServiceImpl(this._networkServiceUtil);

  final NetworkServiceUtil _networkServiceUtil;

  final _dio = Dio(BaseOptions(validateStatus: (_) => true))
    ..interceptors.add(inspectorEnabled
        ? RequestsInspectorInterceptor()
        : const Interceptor());

  String? _requestName;

  final _pendingRequests = <String>[];

  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url, queryParameters: queryParameters, headers: headers);
    if (_pendingRequests.contains(requestId)
        //  &&
        //     !requestId.contains('homepageslider')
        )
      throw RedundantRequestException('Request is already pending for $url');

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _get(
          url,
          queryParameters: queryParameters,
          headers: headers!,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url,
        queryParameters: queryParameters,
        headers: headers,
        data: data);
    if (_pendingRequests.contains(requestId))
      throw RedundantRequestException('Request is already pending for $url');

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _post(
          url,
          queryParameters: queryParameters,
          data: data,
          headers: headers!,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url,
        queryParameters: queryParameters,
        headers: headers,
        data: data);
    if (_pendingRequests.contains(requestId))
      throw RedundantRequestException('Request is already pending for $url');

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _patch(
          url,
          queryParameters: queryParameters,
          data: data,
          headers: headers!,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url,
        queryParameters: queryParameters,
        headers: headers,
        data: data);
    if (_pendingRequests.contains(requestId))
      throw RedundantRequestException('Request is already pending for $url');

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _put(
          url,
          queryParameters: queryParameters,
          data: data,
          headers: headers!,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  @override
  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    _requestName = _extractName(url);
    headers ??= await getDefaultHeaders();
    final requestId = _generateRequestId(
        url: url,
        queryParameters: queryParameters,
        headers: headers,
        data: data);
    if (_pendingRequests.contains(requestId))
      throw RedundantRequestException('Request is already pending for $url');

    _pendingRequests.add(requestId);
    return _connectionExceptionCatcher(() => _delete(
          url,
          queryParameters: queryParameters,
          data: data,
          headers: headers!,
        )).whenComplete(() => _pendingRequests.remove(requestId));
  }

  String _generateRequestId({
    url,
    queryParameters,
    headers,
    data,
  }) =>
      '${url ?? ''}${queryParameters ?? ''}${headers ?? ''}${data ?? ''}';

  String _extractName(String url) {
    url = url.split('?').first;
    final name = url.split('/').last;
    return name.toUpperCase();
  }

  Future<Response> _get(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> headers,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers);
    var response = await _dio.get(
      apiBaseUrl,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    _logResponse(requestName, response);

    // if ([401, 403].contains(response.statusCode))
    //   response = (await _refreshToken((_) async {
    //     _requestName = requestName!;
    //     return _get(
    //       apiBaseUrl,
    //       queryParameters: queryParameters,
    //       headers: await _updateHeaderWithNewToken(headers),
    //     );
    //   }))!;

    _requestName = null;
    return response;
  }

  @override
  Future<Uint8List> readBytes(String apiBaseUrl) {
    final url = Uri.parse(apiBaseUrl);
    return http.readBytes(url);
  }

  Future<Response> _post(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.post(
      apiBaseUrl,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers: headers),
    );
    _logResponse(requestName, response);

    // if ([401, 403].contains(response.statusCode))
    //   response = (await _refreshToken((_) async {
    //     _requestName = requestName!;
    //     return _post(
    //       apiBaseUrl,
    //       queryParameters: queryParameters,
    //       data: data,
    //       headers: await _updateHeaderWithNewToken(headers),
    //     );
    //   }))!;

    _requestName = null;
    return response;
  }

  Future<Response> _patch(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.patch(
      apiBaseUrl,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers: headers),
    );
    _logResponse(requestName, response);

    // if ([401, 403].contains(response.statusCode))
    //   response = (await _refreshToken((_) async {
    //     _requestName = requestName!;
    //     return _patch(
    //       apiBaseUrl,
    //       queryParameters: queryParameters,
    //       data: data,
    //       headers: await _updateHeaderWithNewToken(headers),
    //     );
    //   }))!;

    _requestName = null;
    return response;
  }

  Future<Response> _put(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.put(
      apiBaseUrl,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers: headers),
    );
    _logResponse(requestName, response);

    // if ([401, 403].contains(response.statusCode))
    //   response = (await _refreshToken((_) async {
    //     _requestName = requestName!;
    //     return _put(
    //       apiBaseUrl,
    //       queryParameters: queryParameters,
    //       data: data,
    //       headers: await _updateHeaderWithNewToken(headers),
    //     );
    //   }))!;

    _requestName = null;
    return response;
  }

  Future<Response> _delete(
    String apiBaseUrl, {
    Map<String, dynamic>? queryParameters,
    data,
    required Map<String, dynamic> headers,
  }) async {
    final requestName = _requestName;
    _logRequest(requestName, apiBaseUrl, queryParameters, headers, data);
    var response = await _dio.delete(
      apiBaseUrl,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers: headers),
    );
    _logResponse(requestName, response);

    // if ([401, 403].contains(response.statusCode))
    //   response = (await _refreshToken((_) async {
    //     _requestName = requestName!;
    //     return _delete(
    //       apiBaseUrl,
    //       queryParameters: queryParameters,
    //       headers: await _updateHeaderWithNewToken(headers),
    //     );
    //   }))!;

    _requestName = null;
    return response;
  }

  void _logRequest(
    String? requestName,
    String apiBaseUrl,
    Map<String, dynamic>? params,
    Map<String, dynamic> headers, [
    data,
  ]) {
    if (requestName == null) return;

    // CustomPrinter.logRequestPretty(
    //   header: headers,
    //   params: params,
    //   url: apiBaseUrl,
    //   title: requestName,
    // );
    if (data != null)
      log('[$requestName] body: ${data is FormData ? Map.fromEntries([
              ...data.fields,
              ...data.files
            ]) : data}');
  }

  void _logResponse(String? requestName, Response<dynamic> response) {
    if (requestName == null) return;

    // CustomPrinter.logJsonResponsePretty(title: requestName, response: response);
  }

  @override
  Future<Response> downloadFile(
    String apiBaseUrl,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _dio.download(apiBaseUrl, savePath);
  }

  @override
  Future<Map<String, dynamic>> getDefaultHeaders([String? language]) async {
    final accessToken = await _networkServiceUtil.getCurrentAccessToken();
    final languageCode =
        await _networkServiceUtil.getLanguageCode() ?? language ?? 'en';
    // const clientId = 'f93deb7e-56d9-4142-bb4e-c313781bfce6';
    final headers = <String, String>{
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      'local': languageCode,
      // 'token': ApiEndPoint.token,
      // 'platform': DeviceTypeDataSourceImpl().getDeviceType(),
      'version': '1.0.0+1',
      'Accept': '*/*',
    };

    return headers;
  }

  Future<T> _connectionExceptionCatcher<T>(Future<T> Function() request) async {
    try {
      return await request();
    } catch (e) {
      var message = e.toString();
      if (message.contains('SocketException') ||
          message.contains('HttpException'))
        throw RequestException('connection_error');
      rethrow;
    }
  }
}

abstract class NetworkServiceUtil {
  Future<String?> getCurrentAccessToken();
  Future<String?> getCurrentRefreshToken();
  Future<String?> getLanguageCode();
  Future<void> updateCurrentTokens({
    String? accessToken,
    String? refreshToken,
    String? expireDate,
  });
  Future<void> clearCurrentUserData();
}

///Used only as a helper inside NetworkService to handle tokens and language code.
///DONT: use it outside the NetworkService.
class NetworkServiceUtilImpl implements NetworkServiceUtil {
  // NetworkServiceUtilImpl(this._cacheService);
  // final CacheService _cacheService;
  @override
  Future<String?> getCurrentAccessToken() async {
    return null;

    // final token = await _cacheService.getUserToken();
    // if (token == null) return null;
    // return token;
  }

  @override
  Future<String?> getCurrentRefreshToken() async {
    return null;

    // final refreshToken = await _cacheService.getUserRefreshToken();
    // if (refreshToken == null) return null;
    // return refreshToken;
  }

  @override
  Future<String?> getLanguageCode() async {
    return null;

    // final languageString = await _cacheService.getLanguageCode();
    // if (languageString == null) return null;
    // final languageCode = languageString.split('_').first;
    // return languageCode;
  }

  @override
  Future<void> updateCurrentTokens({
    String? accessToken,
    String? refreshToken,
    String? expireDate,
  }) async {
    // await _cacheService.saveUserRefreshToken(refreshToken!);
    // await _cacheService.saveUserToken(accessToken!);
    // await _cacheService.saveUserTokenExpirationDate(expireDate!);
  }

  @override
  Future<void> clearCurrentUserData() {
    return Future.wait([
      // _cacheService.clearUserToken(),
      // _cacheService.clearUserRefreshToken(),
      // _cacheService.clearUserTokenExpirationDate(),
    ]);
  }
}
