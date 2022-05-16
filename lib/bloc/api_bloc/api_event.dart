part of 'api_bloc.dart';

@immutable
abstract class ApiEvent {}

class getPostEvent extends ApiEvent {
  final List<Post> lstPost;

  getPostEvent({this.lstPost = const <Post>[]});
}

class getPostFetchEvent extends ApiEvent {
  final String id ;

  getPostFetchEvent(this.id);
}

class updatePostEvent extends ApiEvent {
  final PostInfo postInfo;
  final String id;

  updatePostEvent(this.postInfo, this.id);
}

class deletePostEvent extends ApiEvent {
  final String id ;

  deletePostEvent(this.id);
}
