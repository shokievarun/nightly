// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum LogLevel { DEBUG, INFO, WARNING, ERROR }

class AppLogger {
  static void debug(String message) {
    logMessage(LogLevel.DEBUG, message);
  }

  static void info(String message) {
    logMessage(LogLevel.INFO, message);
  }

  static void warning(String message) {
    logMessage(LogLevel.WARNING, message);
  }

  static void error(dynamic error, [StackTrace? stackTrace]) {
    final errorMessage = error.toString();
    final trace = stackTrace ?? StackTrace.current;
    logMessage(LogLevel.ERROR, '\x1B[31m$errorMessage\x1B[0m\n$trace');
  }

  static void logMessage(LogLevel level, String message) {
    if (!kReleaseMode) {
      // Print logs to the console in development mode
      switch (level) {
        case LogLevel.DEBUG:
          debugPrint('\x1B[36m[DEBUG]\x1B[0m \x1B[36m$message\x1B[0m',
              wrapWidth: 1024);
          break;
        case LogLevel.INFO:
          debugPrint('\x1B[32m[INFO]\x1B[0m \x1B[32m$message\x1B[0m',
              wrapWidth: 1024);
          break;
        case LogLevel.WARNING:
          debugPrint('\x1B[33m[WARNING]\x1B[0m \x1B[33m$message\x1B[0m',
              wrapWidth: 1024);
          break;
        case LogLevel.ERROR:
          debugPrint('\x1B[31m[ERROR]\x1B[0m \x1B[31m$message\x1B[0m',
              wrapWidth: 1024);
          break;
      }
    } else {
      // Log to a remote server or a file in production mode
      // Implement logging to a remote server or a file
    }
  }
}
