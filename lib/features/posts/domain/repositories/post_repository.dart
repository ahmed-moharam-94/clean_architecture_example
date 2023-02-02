import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/application/error/failures.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';

abstract class PostRepository {
  // write post use cases
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}

// unit means return nothing
// note that you can not return void so use Unit
