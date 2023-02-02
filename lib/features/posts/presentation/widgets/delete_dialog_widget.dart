import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/blocs/add_delete_update_bloc/add_delete_update_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;

  const DeleteDialogWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure ?'),
      content: const Text('Are you sure you want to delete this post?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No')),
        TextButton(
            onPressed: () {
              BlocProvider.of<AddDeleteUpdatePostBloc>(context)
                  .add(DeletePostEvent(postId: postId));
            },
            child: const Text('Yes')),
      ],
    );
  }
}
