import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_app/application/util/snack_bar.dart';
import 'package:flutter_clean_architecture_app/application/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/blocs/add_delete_update_bloc/add_delete_update_bloc.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/widgets/post_form_widget.dart';

class PostAddUpdateScreen extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdateScreen({Key? key, this.post, this.isUpdatePost = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: isUpdatePost ? const Text('Update Post') : const Text('Add Post'),
    );
  }

  Widget _buildBody() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdateState>(
              listener: (context, state) {
                if (state is MessageAddDeleteUpdatePostState) {
                  Navigator.of(context).pop();
                  return SnackBarMessage()
                      .showSuccessSnackBar(context, state.message);
                } else if (state is ErrorAddDeleteUpdatePostState) {
                  return SnackBarMessage()
                      .showErrorSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is LoadingAddDeleteUpdatePostState) {
                  return const LoadingWidget();
                } else {
                  return PostFormWidget(
                      isUpdatePost: isUpdatePost,
                      post: isUpdatePost ? post : null);
                }
              },
            )));
  }
}
