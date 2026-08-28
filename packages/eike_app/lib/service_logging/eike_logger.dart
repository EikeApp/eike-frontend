import 'package:logger/logger.dart';

import 'eike_log_level.dart';

class EikeLogger {
  factory EikeLogger.pretty() {
    return EikeLogger._(Logger(printer: PrettyPrinter()));
  }

  factory EikeLogger.fmt() {
    return EikeLogger._(
      Logger(printer: LogfmtPrinter()),
    );
  }

  const EikeLogger._(this.logger);

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
    EikeLogLevel.trace,
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
    EikeLogLevel.debug,
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
    EikeLogLevel.info,
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
    EikeLogLevel.warning,
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
    EikeLogLevel.error,
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
  );
}

extension on EikeLogLevel {
  Level asLevel() {
    return switch (this) {
      EikeLogLevel.trace => Level.trace,
      EikeLogLevel.debug => Level.debug,
      EikeLogLevel.info => Level.info,
      EikeLogLevel.warning => Level.warning,
      EikeLogLevel.error => Level.error,
    };
  }
}
