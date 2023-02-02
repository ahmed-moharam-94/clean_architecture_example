
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/application/error/failures.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/repositories/post_repository.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/use_cases/base_use_case.dart';

// every use case is a class

class GetAllPostsUseCase  implements BaseUseCase<Unit, List<Post>> {
  final PostRepository postRepository;
  GetAllPostsUseCase(this.postRepository);
  @override
  Future<Either<Failure, List<Post>>> call(Unit unit) async {
    return await postRepository.getAllPosts();
  }

}