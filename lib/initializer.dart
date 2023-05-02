import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'config.dart';
import 'domain/core/http_client/dia.http.client.dart';
import 'presentation/shared/no_internet_widget/no_internet_controller.dart';

class Initializer {
  static Future<void> init() async {
    try {
      await _initStorage();
      await _initGetConnect();
      await _dioClient();

      _initGlobalInternetConnection();
      _initScreenPreference();
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> testInit() async {
    try {
      await _initGetConnect();
      await _dioClient();
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _initGetConnect() async {
    final connect = GetConnect();
    final url = ConfigEnvironments.getEnvironments().url;
    connect.baseUrl = url;
    connect.timeout = const Duration(seconds: 300);
    connect.httpClient.maxAuthRetries = 0;

    connect.httpClient.addRequestModifier<dynamic>(
      (request) async {
        try {
          // String token =
          //     await AppDataRepositoryBinding().repository.getJwtToken();
          // debugPrint(token);
          // request.headers['Authorization'] = 'Bearer $token';
        } catch (_) {}

        return request;
      },
    );

    connect.httpClient.addResponseModifier(
      (request, response) async {
        debugPrint('request:=> ${request.url}');
        debugPrint('status:=> ${response.statusCode}');

        try {
          Map<String, dynamic> j = json.decode(response.bodyString ?? '');
          String res = const JsonEncoder.withIndent('  ').convert(j);

          debugPrint('');
          debugPrint('response $res');
        } catch (e) {
          debugPrint('error GetConnect:=> ${e.toString()}');
          debugPrint('error GetConnect:=> ${response.bodyString}');
        }
        if (response.statusCode == 401) {
          // Get.offAllNamed(Routes.LOGIN);
        }

        return response;
      },
    );

    Get.put(connect);
  }

  static Future<void> _dioClient() async {
    AppHttpClient client = AppHttpClient();
    // await client.initCache();
    Get.put(client);
  }

  static void _initGlobalInternetConnection() {
    final connection = NoInternetController(connectivity: Connectivity());
    Get.put(connection, permanent: true);
  }

  static Future<void> _initStorage() async {
    await GetStorage.init();
    Get.put(GetStorage());
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
