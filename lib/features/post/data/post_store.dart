import 'package:flutter_tech_task/core/utils/result_handler.dart';

abstract class PostStore {
  Future<Result> getList();
}
