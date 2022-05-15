import 'package:bloc/bloc.dart';
import 'package:dio_bloc_imagepicker/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiState()) {
    on<getPostEvent>(_onGetPost);
    on<getPostFetchEvent>(_onGetPostFetch);
    on<updatePostEvent>(_onUpdatePost);
    on<deletePostEvent>(_onDeletePost);
  }

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );

  Future<void> _onGetPost(getPostEvent event, Emitter<ApiState> emit) async {
    List<Post>? lstPost;
    Response strRes = await dio.get('/posts');

    if (strRes.statusCode == 200) {
      List<dynamic> result = strRes.data;
      List<Post> resultJson = result.map((json) {
        return Post.fromJson(json);
      }).toList();
      lstPost = resultJson;
    } else {
      throw Exception('Failed to lead jobs from API');
    }

    emit(state.ApiGet(lstPost: lstPost));
  }

  Future<void> _onGetPostFetch(
      getPostFetchEvent event, Emitter<ApiState> emit) async {
    Post? post;
    Response strRes = await dio.get('/posts/${event.id}');
    post = Post.fromJson(strRes.data);

    if (strRes.statusCode == 200) {
      emit(state.ApiGetPostFetch(post: post));
    } else {
      throw Exception('Failed to lead jobs from API');
    }
  }

  Future<void> _onUpdatePost(
      updatePostEvent event, Emitter<ApiState> emit) async {
    PostInfo? updatedPost;

    Response strRes = await dio.put(
      '/posts/${event.id}',
      data: event.postInfo.toJson(),
    );

    if (strRes.statusCode == 200) {
      updatedPost = PostInfo.fromJson(strRes.data);
      emit(state.ApiUpdatePosst(updatePost: updatedPost));
    } else {
      throw Exception('Failed to lead jobs from API');
    }
  }

  Future<void> _onDeletePost(
      deletePostEvent event, Emitter<ApiState> emit) async {
    try {
      await dio.delete('/posts/${event.id}');
      // print('Post deleted!');
      emit(state.ApiDeletePost());
    } catch (e) {
      Exception('Failed to lead jobs from API');
    }
  }
}
