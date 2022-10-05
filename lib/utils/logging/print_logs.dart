// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_this

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:nightly/utils/constants/text_constants.dart';
import 'package:nightly/utils/logging/app_logger.dart';
import 'package:nightly/utils/logging/log_filter.dart';

class PrintLogs {
  static final PrintLogs _instance = PrintLogs._internal();
  var logger;

  factory PrintLogs() {
    return _instance;
  }

  PrintLogs._internal() {
    logger = Logger(
      filter: MyFilter(),
      printer: PrettyPrinter(
          methodCount: 5,
          errorMethodCount: 8,
          lineLength: 120, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          printTime: false),
    );
  }

  void log(String strToLog, {String mode = "debug"}) {
    if (dotenv.env['ENVIRONMENT_NAME'] != TextConstants.ENVIRONMENT_PROD) {
      try {
        if (mode == "debug") {
          //this.debugLog(strToLog);
        } else if (mode == "debugError") {
          this.logError(strToLog);
        }
      } catch (e) {
        AppLogger.logError("@ applogger : " + e);
      }
    }
  }

  void debugLog(String strToLog) {}

  void logError(String strToLog) {
    if (dotenv.env['ENVIRONMENT_NAME'] != TextConstants.ENVIRONMENT_PROD) {
      logger.e(strToLog);
    }
  }
}
//imp: should make 1==2 in prod