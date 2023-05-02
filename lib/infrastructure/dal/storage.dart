import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../domain/core/abstractions/storage.interface.dart';

class Storage implements IStorage {
  final GetStorage _storage;

  const Storage({required GetStorage storage}) : _storage = storage;

  @override
  T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  @override
  Future<void> write({required String key, required value}) async {
    await _storage.write(key, value);
  }

  @override
  T? readObject<T>(String key, {T Function(String v)? decoder}) {
    if (decoder != null) {
      var value = _storage.read(key);
      return decoder.call(value.toString());
    }
    return _storage.read<T>(key);
  }

  @override
  Future<void> writeObject<T>({
    required String key,
    required T value,
    required Map<String, dynamic> Function(T v)? encoder,
  }) async {
    if (encoder != null) {
      Map<String, dynamic> jsonValue = encoder(value);
      String jsonString = json.encode(jsonValue);
      return await _storage.write(key, jsonString);
    }
    return await _storage.write(key, value);
  }

  @override
  List<T> allList<T>({T Function(String v)? decoder}) {
    Iterable l = _storage.getKeys();

    List<String> keys = l.map((e) => e.toString()).toList();

    List<T> result = <T>[];
    for (var key in keys) {
      T? res = readObject(key, decoder: decoder);
      if (res != null) {
        result.add(res);
      }
    }
    return result;
  }

  @override
  Future<void> delete(String key) async {
    return _storage.remove(key);
  }
}
