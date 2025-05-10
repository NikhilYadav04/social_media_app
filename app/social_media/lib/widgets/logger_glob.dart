import 'package:logger/logger.dart';

void printLog(dynamic message) {
  final logger = Logger();
  logger.d(message);
}
