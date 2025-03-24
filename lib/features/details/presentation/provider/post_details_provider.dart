import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/core/injections.dart';
import 'package:flutter_tech_task/core/use_case/abstract_usecase.dart';
import 'package:flutter_tech_task/core/utils/bloc_resource.dart';
import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/models/post_with_comments_model.dart';
import 'package:localstore/localstore.dart';

class LoadPostDetails extends AppEvent {
  final String? postId;
  LoadPostDetails(this.postId);
}

class SavePostOffline extends AppEvent {
  final PostWithComments postWithComments;
  SavePostOffline(this.postWithComments);
}

class RemovePostOffline extends AppEvent {
  final String? postId;
  RemovePostOffline(this.postId);
}

AbstractUseCase<Result, String> get postDetailsUseCase =>
    locator.get<AbstractUseCase<Result, String>>(
        instanceName: Constants.postDetailsUseCase);

final _localStore = Localstore.instance;

class PostDetailsProvider extends Bloc<AppEvent, AppState> {
  PostDetailsProvider() : super(AppLoading()) {
    on<LoadPostDetails>((event, emit) async {
      try {
        if (event.postId == null) {
          return;
        }
        emit(AppLoading());
        final response = await postDetailsUseCase.call(event.postId);
        emit(AppLoaded(response.data));
      } catch (e) {
        emit(AppError("Failed to load post detals: \n$e"));
      }
    });

    on<SavePostOffline>((event, emit) async {
      try {
        final postId = event.postWithComments.post?.id.toString();
        await _localStore
            .collection('savedPosts')
            .doc(postId)
            .set(event.postWithComments.toJson());
      } catch (e) {
        debugPrint('Error saving post offline: $e');
      }
    });

    on<RemovePostOffline>((event, emit) async {
      if (event.postId == null) {
        return;
      }
      try {
        await _localStore.collection('savedPosts').doc(event.postId).delete();
      } catch (e) {
        debugPrint('Error removing post offline: $e');
      }
    });
  }
  Future<bool> isPostSaved(String? postId) async {
    if (postId == null) {
      return false;
    }
    final doc = await _localStore.collection('savedPosts').doc(postId).get();
    return doc != null;
  }
}
