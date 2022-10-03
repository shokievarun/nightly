// ignore_for_file: avoid_print

import 'package:nightly/utils/logging/print_logs.dart';

class AppLogger {
  static PrintLogs printLogs = PrintLogs();

  static void log(String logStr, {isPretty = false}) {
    try {
      if (1 == 1) {
        if (!isPretty) {
          print("" + logStr);
        } else {
          printLogs.log(logStr);
        }
      }
    } catch (e) {
      AppLogger.logError("@ applogger : " + e);
    }
  }

  static void logError(String logStr, {isPretty = true}) {
    try {
      if (1 == 1) {
        if (!isPretty) {
          print("" + logStr);
        } else {
          printLogs.logError(logStr);
        }
      }
    } catch (e) {
      AppLogger.logError("@ applogger : " + e);
    }
  }
}
