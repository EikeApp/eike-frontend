import 'package:logger/logger.dart';

import 'eike_log_level.dart';

class EikeLogger {
  factory pretty() {
    return EikeLogger._(Logger(printer: PrettyPrinter()));
  }

  factory fmt() {
    return EikeLogger._(Logger(printer: LogfmtPrinter()));
  }

  const new _(this.logger);

  final Logger logger;

  void log(
    EikeLogLevel level,
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.log(
      level.asLevel(),
      message,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void trace(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    .trace,
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
  );

  void debug(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    .debug,
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
  );

  void info(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    .info,
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
  );

  void warning(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    .warning,
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
  );

  void error(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    .error,
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
  );
}

extension on EikeLogLevel {
  Level asLevel() {
    return switch (this) {
      .trace => .trace,
      .debug => .debug,
      .info => .info,
      .warning => .warning,
      .error => .error,
    };
  }
}
