part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent  extends Equatable {
 const PostsEvent();

  @override
  List<Object> get props => [];

}

// each event is a class
class GetAllPostsEvent extends PostsEvent {

}

class RefreshPostEvent extends PostsEvent {

}
