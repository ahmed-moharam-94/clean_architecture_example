import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';
import 'package:meta/meta.dart';
import '../../../../../application/error/failures.dart';
import '../../../../../application/strings/failure_strings.dart';
import '../../../../../application/strings/success_strings.dart';
import '../../../domain/use_cases/add_post_use_case.dart';
import '../../../domain/use_cases/delete_post_use_case.dart';
import '../../../domain/use_cases/update_post_use_case.dart';

part 'add_delete_update_event.dart';

part 'add_delete_update_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  AddDeleteUpdatePostBloc(
      {required this.addPostUseCase,
      required this.updatePostUseCase,
      required this.deletePostUseCase})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPostUseCase.call(event.post);
        emit(_getAddDeleteUpdatePostState(failureOrDoneMessage, postAddedSuccessfully));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePostUseCase.call(event.post);
        emit(_getAddDeleteUpdatePostState(failureOrDoneMessage, postUpdatedSuccessfully));

      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePostUseCase.call(event.postId);
        emit(_getAddDeleteUpdatePostState(failureOrDoneMessage, postDeletedSuccessfully));
        print(_getAddDeleteUpdatePostState(failureOrDoneMessage, postDeletedSuccessfully));
      }
    });
  }

  AddDeleteUpdateState _getAddDeleteUpdatePostState(Either<Failure, Unit> either, String message) {
    // use either.fold() to get left or right objects
    return either.fold(
            (failure) => ErrorAddDeleteUpdatePostState(message: _getFailureMessage(failure)),
            (_) => MessageAddDeleteUpdatePostState(message: message));
  }


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
}
