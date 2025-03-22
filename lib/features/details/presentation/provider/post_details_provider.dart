import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/core/injections.dart';
import 'package:flutter_tech_task/core/use_case/abstract_usecase.dart';
import 'package:flutter_tech_task/core/utils/bloc_resource.dart';
import 'package:flutter_tech_task/core/utils/result_handler.dart';

class LoadPostDetails extends AppEvent {}

AbstractUseCase<Result, String> get postDetailsUseCase =>
    locator.get<AbstractUseCase<Result, String>>(
        instanceName: Constants.postDetailsUseCase);

class PostDetailsProvider extends Bloc<AppEvent, AppState> {
  PostDetailsProvider(String postId) : super(AppLoading()) {
    on<LoadPostDetails>((event, emit) async {
      try {
        emit(AppLoading());
        final response = await postDetailsUseCase.call(postId);
        emit(AppLoaded(response.data));
      } catch (e) {
        emit(AppError("Failed to load post detals: \n${e}"));
      }
    });
  }
}
