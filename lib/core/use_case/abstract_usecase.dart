import 'package:flutter_tech_task/core/utils/result_handler.dart';

abstract class AbstractUseCase<Type, Parameter> {
  Future<Result> call({Parameter? parameter});
}
