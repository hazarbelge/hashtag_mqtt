import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hashtag_mqtt/core/utils/index.dart';
import 'package:hashtag_mqtt/network/index.dart';

abstract class BaseProvider {
  Future<Response<T>> get<T>(String url, {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    debugPrint("Queries - ${queries.keys} : ${queries.values}");
    debugPrint("Headers - ${RequestInterceptor.getHeaders.keys} : ${RequestInterceptor.getHeaders.values}");
    return GlobalVariables.app.dio.get(
      url,
      queryParameters: queries,
      options: Options(
        headers: RequestInterceptor.getHeaders,
        contentType: contentType,
        validateStatus: (int? status) => status! < 500,
      ),
    );
  }

  Future<Response<T>> post<T>(String? url, dynamic body, {String? contentType, Map<String, String>? headers, Map<String, dynamic>? query}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    debugPrint("Queries - ${queries.keys} : ${queries.values}");
    debugPrint("Headers - ${RequestInterceptor.getHeaders.keys} : ${RequestInterceptor.getHeaders.values}");
    return GlobalVariables.app.dio.post(
      url!,
      data: body,
      queryParameters: queries,
      options: Options(
        headers: RequestInterceptor.getHeaders,
        contentType: contentType,
        validateStatus: (int? status) => status! < 500,
      ),
    );
  }

  Future<Response<T>> put<T>(String? url, dynamic body, {String? contentType, Map<String, String>? headers, Map<String, dynamic>? query}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    debugPrint("Queries - ${queries.keys} : ${queries.values}");
    debugPrint("Headers - ${RequestInterceptor.getHeaders.keys} : ${RequestInterceptor.getHeaders.values}");
    return GlobalVariables.app.dio.put(
      url!,
      data: body,
      queryParameters: queries,
      options: Options(
        headers: RequestInterceptor.getHeaders,
        contentType: contentType,
        validateStatus: (int? status) => status! < 500,
      ),
    );
  }

  Future<Response<T>> delete<T>(String? url, {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query}) {
    Map<String, dynamic>? queries = query;
    queries ??= <String, dynamic>{};
    queries.addAll(RequestInterceptor.getQueries);
    queries.forEach((String key, dynamic value) {
      queries![key] = value.toString();
    });
    debugPrint("Queries - ${queries.keys} : ${queries.values}");
    debugPrint("Headers - ${RequestInterceptor.getHeaders.keys} : ${RequestInterceptor.getHeaders.values}");
    return GlobalVariables.app.dio.delete(
      url!,
      queryParameters: queries,
      options: Options(
        headers: RequestInterceptor.getHeaders,
        contentType: contentType,
        validateStatus: (int? status) => status! < 500,
      ),
    );
  }
}
