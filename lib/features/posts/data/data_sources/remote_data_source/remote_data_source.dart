import 'dart:convert';
import 'package:flutter_clean_architecture_app/application/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/features/posts/data/models/post.dart';

const baseUrl = 'jsonplaceholder.typicode.com';
const String applicationJson = "application/json";
const String contentType = "content-type";

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> addPost(PostModel postModel);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> deletePost(int id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl(this.client);

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.https(baseUrl, '/posts/'), headers: {
      contentType: applicationJson,
    });

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body);
      final List<PostModel> postModels =
          decodedJson.map((posts) => PostModel.formJson(posts)).toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response =
        await client.post(Uri.https(baseUrl, '/posts/'), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response =
        await client.delete(Uri.https(baseUrl, '/posts/${id.toString()}'));
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id;
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response = await client
        .patch(Uri.https(baseUrl, '/posts/${postId.toString()}'), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
