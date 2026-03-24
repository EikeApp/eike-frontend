import 'package:use_in_case/use_in_case.dart';

import 'eike_logger.dart';

extension EikeLoggingInteractorExt<Input, Output>
    on ParameterizedResultInteractor<Input, Output> {
  ParameterizedResultInteractor<Input, Output> logger([
    String? tag,
    EikeLogger? logger,
  ]) {
    tag ??= runtimeType.toString();
    logger ??= EikeLogger.pretty();

    return log(
      tag: tag,
      logStart: (text) => logger?.info(text),
      logSuccess: (text) => logger?.info(text),
      logError: (text) => logger?.error(text),
    );
  }
}
