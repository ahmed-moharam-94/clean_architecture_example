import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/screens/post_detail_screen.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostsListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final post = posts[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Text((index + 1).toString(), style: const TextStyle(fontSize: 16, color: Colors.grey)),
               ),
              Expanded(
                child: ListTile(
                  title: Text(post.title,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(post.body, style: const TextStyle(fontSize: 16)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  onTap: () => _navigateToPostDetailScreen(context, post),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1,),
        itemCount: posts.length);
  }

  void _navigateToPostDetailScreen(BuildContext context, Post post) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>  PostDetailScreen(post: post)));
  }
}
