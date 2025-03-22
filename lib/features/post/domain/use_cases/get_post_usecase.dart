import 'package:flutter_tech_task/core/use_case/abstract_usecase.dart';
import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/post/domain/repositories/post_repository.dart';

class GetPostUsecase implements AbstractUseCase<Result, String> {
  final PostRepository postRepository;
  GetPostUsecase(this.postRepository);

  @override
  Future<Result> call(parameter) async {
    final response = await postRepository.getList();
    return response;
  }
}
