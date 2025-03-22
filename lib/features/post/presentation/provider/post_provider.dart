import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/core/injections.dart';
import 'package:flutter_tech_task/core/use_case/abstract_usecase.dart';
import 'package:flutter_tech_task/core/utils/bloc_resource.dart';
import 'package:flutter_tech_task/core/utils/result_handler.dart';

class LoadPosts extends AppEvent {}

AbstractUseCase<Result, String> get postUseCase => locator
    .get<AbstractUseCase<Result, String>>(instanceName: Constants.postUseCase);

class PostProvider extends Bloc<AppEvent, AppState> {
  PostProvider() : super(AppLoading()) {
    on<LoadPosts>((event, emit) async {
      try {
        emit(AppLoading());
        final response = await postUseCase.call();
        debugPrint('The posts: ${response.data}');
        emit(AppLoaded(response.data));
      } catch (e) {
        emit(AppError("Failed to load Lists: ${e}"));
      }
    });
  }
}
