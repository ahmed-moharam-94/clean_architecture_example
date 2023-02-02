import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_app/application/error/failures.dart';
import 'package:flutter_clean_architecture_app/application/strings/failure_strings.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/use_cases/get_all_post_use_case.dart';
import 'package:meta/meta.dart';


part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUseCase.call(unit);
        emit(_getPostState(failureOrPosts));
      } else if (event is RefreshPostEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUseCase.call(unit);
        emit(_getPostState(failureOrPosts));
      }
    });
  }
}

PostsState _getPostState(Either<Failure, List<Post>> either) {
  // use either.fold() to get left or right objects
  return either.fold(
      (failure) => ErrorPostsState(message: _getFailureMessage(failure)),
      (posts) => LoadedPostsState(posts: posts));
}

/*
  AddDeleteUpdateState _getAddDeleteUpdatePostState(Either<Failure, Unit> either, String message) {
    // use either.fold() to get left or right objects
    return either.fold(
            (failure) => ErrorAddDeleteUpdatePostState(message: _getFailureMessage(failure)),
            (_) => MessageAddDeleteUpdatePostState(message: message));
  }
 */

String _getFailureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case OfflineFailure:
      return offlineFailureMessage;
    case ServerFailure:
      return failureServerMessage;
    case EmptyCacheFailure:
      return emptyCacheFailureMessage;
    default:
      return unexpectedFailureMessage;
  }
}
