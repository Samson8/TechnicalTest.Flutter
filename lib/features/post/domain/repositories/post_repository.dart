import 'package:flutter_tech_task/core/utils/result_handler.dart';

abstract class PostRepository {
  Future<Result> getList();
  Future<Result> getPostAndCommentById(String postId);
}
