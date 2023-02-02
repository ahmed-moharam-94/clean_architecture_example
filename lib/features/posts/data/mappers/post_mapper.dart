import 'package:flutter_clean_architecture_app/features/posts/data/models/post.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture_app/application//extensions.dart';

extension PostResponseMapper on PostModel? {
  // this refer to customerResponse
  Post toDomain() {
    return Post(id: this?.id.ifNullReturnZero() ?? 0,
        title: this?.title.ifNullReturnEmpty() ?? '',
        body: this?.body.ifNullReturnEmpty() ?? '');
  }
}

extension PostToModelMapper on Post {
  // this refer to customerResponse
  PostModel toModel() {
    return PostModel(id: id,
        title: title,
        body: body);
  }
}

extension PostsListResponseMapper on List<PostModel>? {
  // this refer to customerResponse
  List<Post> toDomain() {
    List<Post> mappedPosts = [];
     this?.forEach((post) {
       mappedPosts.add(post.toDomain());
     });
    return mappedPosts;
  }
}



