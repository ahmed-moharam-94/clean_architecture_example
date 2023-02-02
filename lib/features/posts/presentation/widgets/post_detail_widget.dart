import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_app/application/util/snack_bar.dart';
import 'package:flutter_clean_architecture_app/application/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/blocs/add_delete_update_bloc/add_delete_update_bloc.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/screens/post_add_update_screen.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/screens/post_screen.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/widgets/delete_dialog_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  const PostDetailWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(post.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          const Divider(height: 50, thickness: 1),
          Text(post.body,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const Divider(height: 50, thickness: 1),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton.icon(
                onPressed: () => _navigateToUpdatePostScreen(context, post),
                icon: const Icon(Icons.edit),
                label: const Text('Edit')),
            ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                onPressed: () => _deleteDialog(context),
                icon: const Icon(Icons.delete),
                label: const Text('Delete')),
          ]),
        ],
      ),
    );
  }

  void _navigateToUpdatePostScreen(BuildContext context, Post post) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PostAddUpdateScreen(
              post: post,
              isUpdatePost: true,
            )));
  }

  void _navigateToPostsScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const PostsScreen()),
        (route) => false);
  }

  void _deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdateState>(
              listener: (_, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(context, state.message);
              // todo: in dialog show success message then navigate to the desired screen don't navigate to another screen inside the dialog because it won't show message (unless you don't have message)
              _navigateToPostsScreen(context);
            } else if (state is ErrorAddDeleteUpdatePostState) {
              SnackBarMessage().showErrorSnackBar(context, state.message);
            }
          }, builder: (_, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            } else {
              return DeleteDialogWidget(postId: post.id!);
            }
          });
        });
  }
}
