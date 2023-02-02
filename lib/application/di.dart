import 'package:flutter_clean_architecture_app/application/network_info/network_info.dart';
import 'package:flutter_clean_architecture_app/features/posts/data/data_sources/local_data_source/local_data_source.dart';
import 'package:flutter_clean_architecture_app/features/posts/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:flutter_clean_architecture_app/features/posts/data/repositories/post_repository_impl.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/repositories/post_repository.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/use_cases/get_all_post_use_case.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/use_cases/update_post_use_case.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/blocs/add_delete_update_bloc/add_delete_update_bloc.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/blocs/get_refresh_bloc/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> init() async {
  // SharedPreferences (Lazy singleton)
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton(() => sharedPreferences);

  // Network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // Http (lazy singleton)
  instance.registerLazySingleton(() => http.Client());

  // Data sources (Lazy singleton)
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(instance()));

  // Repository (lazy singleton)
  instance.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
        instance(),
        instance(),
        instance(),
      ));

  // Use cases (lazy singleton)
  instance.registerLazySingleton(() => AddPostUseCase(instance()));
  instance.registerLazySingleton(() => DeletePostUseCase(instance()));
  instance.registerLazySingleton(() => UpdatePostUseCase(instance()));
  instance.registerLazySingleton(() => GetAllPostsUseCase(instance()));

  // Bloc (factory)
  instance.registerFactory(() => PostsBloc(getAllPostsUseCase: instance()));
  instance.registerFactory(() => AddDeleteUpdatePostBloc(
        addPostUseCase: instance(),
        deletePostUseCase: instance(),
        updatePostUseCase: instance(),
      ));
}

// todo: note: in impl you have to define the Type or the app will have error
