import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

class AQDioFetcher {
  AQDioFetcher() {
    if (kDebugMode) _dio.interceptors.add(_logger);
  }

  // Dio Client
  final _dio = Dio();

  // Logger
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    error: true,
  );

  Future<String> getHtmlFromDio(String link) async {
    final _response = await _dio.get(link);

    if (_validResponse(_response.statusCode)) {
      return _response.data;
    } else {
      throw _response.data;
    }
  }

////////////////////////////////////////////////////////////////////////////////
  // Helper Functions.
  bool _validResponse(int statusCode) => statusCode >= 200 && statusCode < 300;
}