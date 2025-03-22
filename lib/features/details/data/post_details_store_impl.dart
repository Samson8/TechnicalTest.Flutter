import 'dart:convert';

import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/details/data/post_details_store.dart';
import 'package:http/http.dart' as http;

class PostDetailsStoreImpl implements PostDetailsStore {
  @override
  Future<Result> getPostById(String postId) async {
    try {
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts/${postId}/'));
      return Result.success(await json.decode(response.body));
    } catch (e) {
      return Result.failure(e?.toString());
    }
  }
}
