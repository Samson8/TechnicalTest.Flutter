import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/core/injections.dart';
import 'package:flutter_tech_task/core/use_case/abstract_usecase.dart';
import 'package:flutter_tech_task/core/utils/bloc_resource.dart';
import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/models/post_with_comments_model.dart';
import 'package:localstore/localstore.dart';

class LoadPosts extends AppEvent {}

AbstractUseCase<Result, String> get postUseCase => locator
    .get<AbstractUseCase<Result, String>>(instanceName: Constants.postUseCase);

final _localStore = Localstore.instance;

class PostProvider extends Bloc<AppEvent, AppState> {
  PostProvider() : super(AppLoading()) {
    on<LoadPosts>((event, emit) async {
      try {
        emit(AppLoading());
        final response = await postUseCase.call(null);
        emit(AppLoaded(response.data));
      } catch (e) {
        emit(AppError("Failed to load lists: $e"));
      }
    });
  }

  Future<List<PostWithComments>> getSavedPosts() async {
    final docs = await _localStore.collection('savedPosts').get();

    if (docs == null || docs.isEmpty) {
      return [];
    }

    // Convert the map entries to a list of PostWithComments
    final data = docs.entries
        .map((entry) => PostWithComments.fromJson(entry.value))
        .toList();

    return data;
  }
}
