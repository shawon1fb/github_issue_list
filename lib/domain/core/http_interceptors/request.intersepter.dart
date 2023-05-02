import 'package:flutter/material.dart';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../config.dart';

class RequestInterceptor {
  static final bool _responsePrinter =
      ConfigEnvironments.getEnvironments().env == Environments.PRODUCTION;
  static List<String> logDisable = <String>[
    // 'https://onesignal.com/api/v1/apps',
    // 'http://3.95.30.17:3000/api/v1/admin/group/list',
    // 'http://3.95.30.17:3000/api/v1/admin/group/list?page=1',
  ];

  // static final _authLocalRepository = AuthLocalRepositoryBindings().repository;
  //
  // static Future<Request<T>> onesignalAuthModifier<T>(Request<T> request) async {
  //   //final AppConfigData env = ConfigEnvironments.getEnvironments();
  //   try {
  //     AuthDataModel model = _authLocalRepository.getUserAuth();
  //     print(model.userAuthKey);
  //     if (request.headers.containsKey('Authorization') == false) {
  //       request.headers['Authorization'] = 'Basic ${model.userAuthKey}';
  //     }
  //   } catch (_) {}
  //
  //   return request;
  // }
  //
  // static Future<Request<T>> serverBearerToken<T>(Request<T> request) async {
  //   try {
  //     AuthDataModel model = _authLocalRepository.getUserAuth();
  //     print(model.accessToken);
  //     if (request.headers.containsKey('Authorization') == false) {
  //       request.headers['Authorization'] = '${model.tokenType} ${model.accessToken}';
  //     }
  //   } catch (_) {}
  //
  //   return request;
  // }

  static Future<Request<T>> requestHeader<T>(Request<T> request) async {


    return request;
  }

  // static Future<Response<T>> responseLogger<T>(Request request, Response<T> response) async {
  //   if (_responsePrinter == true) {
  //     return response;
  //   }
  //   // debugPrint('url:=> ${request.url}');
  //   // debugPrint('statusCode:=> ${response.statusCode}');
  //   // debugPrint('method:=> ${request.method}');
  //   if (logDisable.contains(request.url.toString())) {
  //     return response;
  //   }
  //
  //   if (!request.url.toString().contains('api/user/logout')) {
  //     try {
  //       var j = json.decode(response.bodyString ?? '');
  //       String res = const JsonEncoder.withIndent('  ').convert(j);
  //       debugPrint('response $res');
  //     } catch (e) {
  //       debugPrint('error GetConnect:=> ${e.toString()}');
  //     }
  //   }
  //
  //   return response;
  // }

  static Future<Response<T>> responseHeaderLogger<T>(
      Request request, Response<T> response) async {
    if (_responsePrinter == true) {
      return response;
    }
    debugPrint('url:=> ${request.url}');
    debugPrint('statusCode:=> ${response.statusCode}');
    debugPrint('method:=> ${request.method}');
    debugPrint('requestId :=> ${response.headers?['x-request-id']}');
    // debugPrint('headers:=> ${response.headers}');
    debugPrint('headers:=> ${response.headers?.length}');
    return response;
  }
}
