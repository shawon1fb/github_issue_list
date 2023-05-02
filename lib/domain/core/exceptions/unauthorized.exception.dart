import 'package:logger/logger.dart';

class UnAuthorizedException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  UnAuthorizedException({
    this.message = 'wrong credentials',
    this.stackTrace,
  }) {
    Logger().e(stackTrace);
  }

  @override
  String toString() => message;
}
