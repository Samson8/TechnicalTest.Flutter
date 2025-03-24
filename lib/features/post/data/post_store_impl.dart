import 'dart:convert';

import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/post/data/post_store.dart';
import 'package:http/http.dart' as http;

class PostStoreImpl implements PostStore {
  @override
  Future<Result> getList() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/'));
      return Result.success(await json.decode(response.body));
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result> getPostAndCommentById(String postId) async {
    try {
      final postResponse = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId/'));
      final commentResponse = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/posts/$postId/comments'));
      return Result.success({
        'post': json.decode(postResponse.body),
        'comments': json.decode(commentResponse.body)
      });
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
