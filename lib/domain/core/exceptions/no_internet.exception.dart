import 'package:logger/logger.dart';

class NotInternetException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  NotInternetException({
    this.message = 'Connection Failed',
    this.stackTrace,
  }) {
    Logger().e(stackTrace);
  }

  @override
  String toString() => message;
}
