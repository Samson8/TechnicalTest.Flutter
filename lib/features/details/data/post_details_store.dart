import 'package:flutter_tech_task/core/utils/result_handler.dart';

abstract class PostDetailsStore {
  Future<Result> getPostAndCommentById(String postId);
}
