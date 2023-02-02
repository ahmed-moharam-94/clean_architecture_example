import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/application/error/failures.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/repositories/post_repository.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/use_cases/base_use_case.dart';

class DeletePostUseCase implements BaseUseCase<int, Unit> {
  final PostRepository postRepository;
  DeletePostUseCase(this.postRepository);

  @override
  Future<Either<Failure, Unit>> call(int id) async {
    return await postRepository.deletePost(id);
  }

}