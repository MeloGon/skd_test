import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class AppNetwork {
  final logger = Logger(printer: PrettyPrinter());
  final Dio _dio = Dio();

  Future<dynamic> post(
      {String url = '',
      Map? formData,
      String? token,
      bool showPrint = true}) async {
    if (!await checkInternetConnection()) {
      throw Exception(['NOT_INTERNET_EXCEPTION']);
    }

    if (token != null) {
      _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    } else {
      _dio.options.headers.remove("Authorization");
    }

    _dio.options.contentType = Headers.jsonContentType;

    logger.d("URL POST: $url");
    logger.d("Headers: ${_dio.options.headers}");
    if (showPrint) {
      logger.d("Body: $formData");
    }

    return _dio
        .post(url,
            data: formData,
            options: Options(
                method: 'POST',
                //sendTimeout: receiveTimeOut,
                responseType: ResponseType.json // or ResponseType.JSON
                ))
        .then((Response response) {
      logger.d("Response [${response.statusCode}]: $response");

      return response.data;
    }).catchError((error) => debugPrint("EL ERROR $error"));
  }

  Future<dynamic> get(
      {String url = '',
      Map<String, String>? parameters,
      String? token,
      Map<String, String>? headers
      /*Encoding? encoding*/
      }) async {
    if (!await checkInternetConnection()) {
      throw Exception(['NOT_INTERNET_EXCEPTION']);
    }

    if (token != null) {
      _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    } else {
      _dio.options.headers.remove("Authorization");
    }

    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    _dio.options.contentType = Headers.jsonContentType;

    logger.d("URL GET: $url");
    logger.d("Headers: ${_dio.options.headers}");

    return _dio
        .get(url,
            queryParameters: parameters ?? {},
            options: Options(
                method: 'GET',
                responseType: ResponseType.json // or ResponseType.JSON
                ))
        .then((Response response) {
      logger.d("Response [${response.statusCode}]: $response");

      return response.data;
    }).catchError((error) => debugPrint("EL ERROR $error"));
  }

  Future<dynamic> delete({
    String url = '',
    Map<String, String>? parameters,
    String? token,
    /*Encoding? encoding*/
  }) async {
    if (!await checkInternetConnection()) {
      throw Exception(['NOT_INTERNET_EXCEPTION']);
    }

    if (token != null) {
      _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    } else {
      _dio.options.headers.remove("Authorization");
    }

    _dio.options.contentType = Headers.jsonContentType;

    logger.d("URL GET: $url");
    logger.d("Headers: ${_dio.options.headers}");

    return _dio
        .delete(url,
            queryParameters: parameters ?? {},
            options: Options(
                method: 'DELETE',
                responseType: ResponseType.json // or ResponseType.JSON
                ))
        .then((Response response) {
      logger.d("Response [${response.statusCode}]: $response");

      return response.data;
    }).catchError((error) => debugPrint("EL ERROR $error"));
  }

  Future<bool> checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }
}
