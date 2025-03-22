import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/details/data/post_details_store.dart';
import 'package:flutter_tech_task/features/details/domain/repositories/post_details_repository.dart';

class PostDetailsRepositoryImpl implements PostDetailsRepository {
  final PostDetailsStore postDetailsStore;
  PostDetailsRepositoryImpl(this.postDetailsStore);

  @override
  Future<Result> getPostById(String postId) async {
    try {
      final response = await postDetailsStore.getPostById(postId);
      return response;
    } catch (e) {
      return Result.failure(e?.toString());
    }
  }
}
