import 'package:flutter_tech_task/core/use_case/abstract_usecase.dart';
import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/details/domain/repositories/post_details_repository.dart';

class GetPostDetailsUsecase implements AbstractUseCase<Result, String> {
  final PostDetailsRepository postDetailsRepository;
  GetPostDetailsUsecase(this.postDetailsRepository);

  @override
  Future<Result> call(parameter) async {
    final response =
        await postDetailsRepository.getPostAndCommentById(parameter!);
    return response;
  }
}
