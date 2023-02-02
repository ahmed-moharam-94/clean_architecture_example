import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_app/application/widgets/loading_widget.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/blocs/get_refresh_bloc/posts_bloc.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/screens/post_add_update_screen.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/widgets/posts_widget.dart';

import '../widgets/message_display_widget.dart';


class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();

}


class _PostsScreenState extends State<PostsScreen> {

  @override
  void initState() {
    BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBodyWidget(),
      floatingActionButton: _buildFabWidget(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Posts'),
    );
  }

  Widget _buildBodyWidget() {
    return Padding(padding: const EdgeInsets.all(10),
    child: BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadingPostsState) {
          // loading state
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          // loadedddddddddd state
          return RefreshIndicator(
            onRefresh: () => _refreshPost(context),
              child: PostsListWidget(posts: state.posts));
        } else if (state is ErrorPostsState) {
          return MessageDisplayWidget(message: state.message);
        } else {
          return const SizedBox();
        }
      },
    ));
  }

  FloatingActionButton _buildFabWidget() {
    return FloatingActionButton(
      onPressed: _navigateToAddUpdatePostScreen,
      child: const Icon(Icons.add));
  }

  Future<void> _refreshPost(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostEvent());
  }

  void _navigateToAddUpdatePostScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PostAddUpdateScreen()));
  }
}
