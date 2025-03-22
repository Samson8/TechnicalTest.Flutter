import 'package:flutter_tech_task/core/constants/constants.dart';
import 'package:flutter_tech_task/core/use_case/abstract_usecase.dart';
import 'package:flutter_tech_task/core/utils/result_handler.dart';
import 'package:flutter_tech_task/features/post/data/post_store.dart';
import 'package:flutter_tech_task/features/post/data/post_store_impl.dart';
import 'package:flutter_tech_task/features/post/domain/repositories/post_repository.dart';
import 'package:flutter_tech_task/features/post/domain/repositories/post_repository_impl.dart';
import 'package:flutter_tech_task/features/post/domain/use_cases/get_post_usecase.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initInjections() async {
  locator
    ..registerLazySingleton<PostStore>(
      () => PostStoreImpl(),
    )
    ..registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(locator()),
    )
    ..registerLazySingleton<AbstractUseCase<Result, String>>(
      () => GetPostUsecase(locator()),
      instanceName: Constants.postUseCase,
    );
}
