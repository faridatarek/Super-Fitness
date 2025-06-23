
import 'package:super_fitness/core/common/result.dart';

Future<Result<T>> executeHive<T>(Future<T> Function() hiveCall) async {
  try {
    var result = await hiveCall.call();
    return Success(result);
  } on Exception catch (ex) {
    return Fail(ex);
  }
}
