// ignore_for_file: lines_longer_than_80_chars,

import 'dart:convert';
import 'dart:developer' as developer show log;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:people_manager/utils/url.dart';

class ApiClient {
  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal();

  static final Dio dio = Dio();
  static final ApiClient _instance = ApiClient._internal();
  static ApiClient get instance => _instance;

  static Future<void> init() async {
    dio.options.baseUrl = URL.mainUrl;
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);
    dio.options.receiveDataWhenStatusError = true;
    dio.options.headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer 5f54c461fb7d6b345b3a770fa4586795ec1125bb80459ed9daba5f1c26cf26e0',
    };
  }

  Future<Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? quryParameter,
    Map<String, dynamic>? headers,
  }) async {
    developer.log('url:  $url', name: 'API');
    developer.log('body: $quryParameter', name: 'API');
    Logger().i('url:  $url');
    Logger().i('body: $quryParameter');
    return dio.get(
      url,
      options: Options(headers: headers),
      queryParameters: quryParameter,
    );
  }

  Future<Response<Map<String, dynamic>>> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    developer.log('url:  $url', name: 'API');
    developer.log('body: $body', name: 'API');
    Logger().i('url:  $url');
    Logger().i('body: $body');
    return dio.post(
      url,
      options: Options(headers: headers),
      data: body,
    );
  }

  Future<Response<dynamic>> patch({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    developer.log('url:  $url');
    developer.log('body: $body');
    Logger().i('url:  $url');
    Logger().i('body: $body');
    return dio.patch(
      url,
      options: Options(headers: headers),
      data: body,
    );
  }

  Future<Response<Map<String, dynamic>>> put({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    return dio.put(
      url,
      options: Options(headers: headers),
      data: body,
    );
  }

  Future<Response<dynamic>> delete({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    return dio.delete(
      url,
      options: Options(headers: headers),
      data: body,
    );
  }

  Future<Response<dynamic>> requestWithSingleFile({
    required String url,
    File? file,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final formData = FormData.fromMap(body ?? {});
      if (file != null) {
        formData.files.add(
          MapEntry(
            'attachments',
            await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
          ),
        );
      }
      return dio.post(
        url,
        options: Options(headers: headers),
        data: formData,
      );
    } catch (e) {
      // developer.log('requestWithSingleFile', name: 'ApiClient.requestWithSingleFile.catch', error: e);
      return Response(
        requestOptions: RequestOptions(path: url),
        data: jsonEncode({'status': false, 'message': 'Something went wrong!'}),
        statusCode: 500,
      );
    }
  }
}
