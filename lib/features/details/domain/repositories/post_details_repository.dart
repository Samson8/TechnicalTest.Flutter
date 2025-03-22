import 'package:flutter_tech_task/core/utils/result_handler.dart';

abstract class PostDetailsRepository {
  Future<Result> getPostById(String postId);
}
