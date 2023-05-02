import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NoInternetController extends GetxController {
  NoInternetController({required Connectivity connectivity})
      : _connectivity = connectivity;

  final Connectivity _connectivity;

  StreamSubscription? subscription;

  RxBool connected = true.obs;
  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    listenInterNet();
    super.onInit();
  }

  void listenInterNet() {
    try {
      subscription = _connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        debugPrint('internet connection result = $result');
        if (result == ConnectivityResult.none ||
            result == ConnectivityResult.bluetooth) {
          connected.value = false;
          connected.refresh();
        } else {
          connected.value = true;
          connected.refresh();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
