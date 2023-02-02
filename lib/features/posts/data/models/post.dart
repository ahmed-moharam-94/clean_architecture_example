import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';

class PostModel{
  // const PostModel({
  //   required super.id,
  //   required super.title,
  //   required super.body,
  // });

  int? id;
  String? title;
  String? body;
  PostModel({this.id, this.title, this.body});

  factory PostModel.formJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body
    };
  }
}
