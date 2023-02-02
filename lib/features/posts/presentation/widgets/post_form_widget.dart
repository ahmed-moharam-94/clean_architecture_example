import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/blocs/add_delete_update_bloc/add_delete_update_bloc.dart';

class PostFormWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostFormWidget(
      {Key? key, required this.isUpdatePost, required this.post})
      : super(key: key);

  @override
  State<PostFormWidget> createState() => _PostFormWidgetState();
}

class _PostFormWidgetState extends State<PostFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();
  final _bodyTextController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleTextController.text = widget.post!.title;
      _bodyTextController.text = widget.post!.body;
    }
    super.initState();
  }
  void _validateForm() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : 0,
        title: _titleTextController.text,
        body: _bodyTextController.text,
      );

      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: _titleTextController,
                  validator: (value) {
                    return value!.isEmpty ? 'Enter title' : null;
                  },
                  minLines: 1,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: _bodyTextController,
                  validator: (value) {
                    return value!.isEmpty ? 'Enter Body' : null;
                  },
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Body',
                  ),
                )),
            ElevatedButton(
                onPressed: _validateForm,
                child: widget.isUpdatePost
                    ? const Text('Update Post')
                    : const Text('Add Post')),
          ],
        ),
      ),
    );
  }
}
