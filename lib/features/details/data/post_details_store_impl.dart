import 'dart:convert';

import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/details/data/post_details_store.dart';
import 'package:http/http.dart' as http;

class PostDetailsStoreImpl implements PostDetailsStore {
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
