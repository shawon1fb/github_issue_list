import 'package:flutter/cupertino.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CacheImageViewController extends GetxController {
  CacheImageViewController({required GetStorage storage}) : _storage = storage;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onClose() {
    errorImageUrlMap.clear();
    super.onClose();
  }

  void init() {
    try {
      Map? err = _storage.read('errorImageList');

      debugPrint(
        'error image list :=> ${err?.length},',
      );

      err?.forEach((key, value) {
        errorImageUrlMap[key.toString()] = false;
      });
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
  }

  void addErrorImageUrl(String url) {
    errorImageUrlMap[url] = false;
    saveToDb();
  }

  Future<void> saveToDb() async {
    try {
      await _storage.write('errorImageList', errorImageUrlMap);
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
  }

  void cacheImage(List<String> images) {
    try {
      for (var image in images) {
        if (GetUtils.isURL(image)) {
          if (errorImageUrlMap[image] == null) {
            // debugPrint('cache image url => $image');
            DefaultCacheManager().downloadFile(image, key: image);
          } else {
            // debugPrint('skip image url => $image');
          }
        }
      }
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
  }

  final GetStorage _storage;

  Map<String, bool> errorImageUrlMap = <String, bool>{};
}
