import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/application/error/failures.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/repositories/post_repository.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/use_cases/base_use_case.dart';


class AddPostUseCase implements BaseUseCase<Post, Unit> {
  final PostRepository postRepository;
  AddPostUseCase(this.postRepository);
  @override
  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepository.addPost(post);
  }

}