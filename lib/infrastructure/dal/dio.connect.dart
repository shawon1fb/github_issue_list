import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart' as dio;

import '../../domain/core/abstractions/http_connect.interface.dart';
import '../../domain/core/abstractions/response.model.dart';

class DioConnect extends IHttpConnect {
  final dio.Dio _connect;

  DioConnect({required dio.Dio connect}) : _connect = connect;

  @override
  Future<Response<T>> delete<T>(String url,
      {required T Function(dynamic p1)? decoder,
      Map<String, String>? headers,
      Map<String, String>? query}) async {
    try {
      if (headers != null) {
        _connect.options.headers.addAll(headers);
      }

      dio.Response response =
          await _connect.delete(url, queryParameters: query);

      final obj = Response<T>(
        statusCode: response.statusCode!,
        payload: decoder != null
            ? decoder.call(response.data)
            : (response.data as T),
      );

      return obj;
    } on dio.DioError catch (e) {
      final obj = Response<T>(
        statusCode: e.response?.statusCode ?? 500,
        payload: decoder != null
            ? decoder.call(e.response?.data ?? {})
            : ((e.response?.data ?? {}) as T),
      );
      return obj;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> get<T>(String url,
      {required T Function(dynamic p1)? decoder,
      Map<String, String>? headers,
      Map<String, String>? query}) async {
    try {
      if (headers != null) {
        _connect.options.headers.addAll(headers);
      }
      dio.Response response = await _connect.get(url, queryParameters: query);

      final obj = Response<T>(
        statusCode: response.statusCode!,
        payload: decoder != null
            ? decoder.call(response.toString())
            : (response.data as T),
      );

      return obj;
    } on dio.DioError catch (e) {
      if (kDebugMode) {
        print(e);
        print(e.requestOptions.uri.toString());
      }
      final obj = Response<T>(
        statusCode: e.response?.statusCode ?? 500,
        payload: decoder != null
            ? decoder.call(e.response?.data ?? <String, dynamic>{})
            : ((e.response?.data ?? <String, dynamic>{}) as T),
      );
      return obj;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> patch<T>(
    String url,
    Map<String, dynamic> body, {
    T Function(dynamic p1)? decoder,
    Map<String, String>? headers,
  }) async {
    try {
      if (headers != null) {
        _connect.options.headers.addAll(headers);
      }

      dio.Response response = await _connect.patch(url, data: body);

      final obj = Response<T>(
        statusCode: response.statusCode!,
        payload: decoder != null
            ? decoder.call(response.data)
            : (response.data as T),
      );

      return obj;
    } on dio.DioError catch (e) {
      final obj = Response<T>(
        statusCode: e.response?.statusCode ?? 500,
        payload: decoder != null
            ? decoder.call(e.response?.data ?? <String, dynamic>{})
            : ((e.response?.data ?? <String, dynamic>{}) as T),
      );
      return obj;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> post<T>(String url, body,
      {T Function(dynamic p1)? decoder,
      Map<String, String>? headers,
      Map<String, String>? query}) async {
    try {
      if (headers != null) {
        _connect.options.headers.addAll(headers);
      }

      dio.Response response = await _connect.post(url,
          data: body,
          queryParameters: query,
          options: dio.Options(
            responseType: dio.ResponseType.plain,
          ));

     // print(response.data);

      final obj = Response<T>(
        statusCode: response.statusCode!,
        payload: decoder != null
            ? decoder.call(response.data)
            : (response.data as T),
      );

      return obj;
    } on dio.DioError catch (e) {
      // if (kDebugMode) {
      //   print(e);
      //   print('e.response?.data');
      //   print(e.response?.data);
      // }
      final obj = Response<T>(
        statusCode: e.response?.statusCode ?? 500,
        payload: decoder != null
            ? decoder.call(e.response?.data ?? <String, dynamic>{})
            : ((e.response?.data ?? <String, dynamic>{}) as T),
      );
      return obj;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> put<T>(
    String url,
    body, {
    T Function(dynamic p1)? decoder,
    Map<String, String>? headers,
  }) async {
    try {
      if (headers != null) {
        _connect.options.headers.addAll(headers);
      }

      dio.Response response = await _connect.put(url, data: body);

      final obj = Response<T>(
        statusCode: response.statusCode!,
        payload: decoder != null
            ? decoder.call(response.data)
            : (response.data as T),
      );

      return obj;
    } on dio.DioError catch (e) {
      final obj = Response<T>(
        statusCode: e.response?.statusCode ?? 500,
        payload: decoder != null
            ? decoder.call(e.response?.data ?? {})
            : ((e.response?.data ?? {}) as T),
      );
      return obj;
    } catch (e) {
      rethrow;
    }
  }
}
