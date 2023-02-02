import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/application/error/exceptions.dart';
import 'package:flutter_clean_architecture_app/features/posts/data/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<Unit> cachePosts(List<PostModel> posts);

  Future<List<PostModel>> getCachedPosts();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    List postModelsToJson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString('CACHED_POSTS', json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString('CACHED_POSTS');
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.formJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
