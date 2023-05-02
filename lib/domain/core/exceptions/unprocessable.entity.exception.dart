import 'package:logger/logger.dart';

class UbProcessAbleEntityException implements Exception {
  final String message;

  UbProcessAbleEntityException({
    this.message = 'UbProcessAbleEntityException',
  }) {
    Logger().w(message);
  }

  @override
  String toString() => message;
}
