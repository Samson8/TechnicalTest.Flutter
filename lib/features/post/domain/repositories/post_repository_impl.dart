import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/post/data/post_store.dart';
import 'package:flutter_tech_task/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostStore postStore;
  PostRepositoryImpl(this.postStore);

  @override
  Future<Result> getList() async {
    try {
      final response = await postStore.getList();
      return response;
    } catch (e) {
      return Result.failure(e?.toString());
    }
  }
}
