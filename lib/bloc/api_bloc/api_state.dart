part of 'api_bloc.dart';

@immutable
class ApiState {
  final Post? post;
  final List<Post>? lstPost;
  final PostInfo? updatePost;

  ApiState({this.post, this.lstPost, this.updatePost});

  ApiState ApiGet({List<Post>? lstPost}) => ApiState(lstPost: lstPost ?? this.lstPost);

  ApiState ApiGetPostFetch({Post? post}) => ApiState(post: post ?? this.post);

  ApiState ApiUpdatePosst({PostInfo? updatePost}) => ApiState(updatePost: updatePost ?? this.updatePost);

  ApiState ApiDeletePost() => ApiState();
}
