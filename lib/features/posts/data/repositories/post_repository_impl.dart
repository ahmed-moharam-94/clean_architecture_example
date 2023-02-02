import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/application/error/exceptions.dart';
import 'package:flutter_clean_architecture_app/application/error/failures.dart';
import 'package:flutter_clean_architecture_app/application/network_info/network_info.dart';
import 'package:flutter_clean_architecture_app/features/posts/data/data_sources/local_data_source/local_data_source.dart';
import 'package:flutter_clean_architecture_app/features/posts/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:flutter_clean_architecture_app/features/posts/data/mappers/post_mapper.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/repositories/post_repository.dart';


class PostRepositoryImpl implements PostRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(this.localDataSource, this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    // check if there is connection
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // if there is internet connection get data from remote anc cache it
      try {
       final posts = await remoteDataSource.getAllPosts();
       // cache posts
        localDataSource.cachePosts(posts);
        return Right(posts.toDomain());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      // if there is no internet connection get data from local data source
      try {
        final posts = await localDataSource.getCachedPosts();
        return Right(posts.toDomain());
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    return await _getMessage(() {
      return remoteDataSource.addPost(post.toModel());
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    return await _getMessage(() {
      return remoteDataSource.updatePost(post.toModel());
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(id);
    });
  }

  Future<Either<Failure, Unit>> _getMessage (Future<Unit> Function() postFunction) async {
    final bool isConnected = await networkInfo.isConnected;
    // check if there is connection
    if (isConnected) {
      try {
        await postFunction();
        return const Right(unit);
      }  on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

}