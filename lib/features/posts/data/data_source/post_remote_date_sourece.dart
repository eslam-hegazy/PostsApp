import 'dart:convert';

import 'package:art2/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:art2/features/posts/data/models/Post_model.dart';

import '../../domain/entities/post.dart';

abstract class BasePostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePosts(int id);
  Future<Unit> updatePosts(PostModel post);
  Future<Unit> insertPosts(PostModel post);
}

String BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDateSource extends BasePostRemoteDataSource {
  final http.Client client;
  PostRemoteDateSource({
    required this.client,
  });
  @override
  Future<Unit> deletePosts(int id) async {
    final response = await client.delete(
      Uri.parse("${BASE_URL}/posts/${id.toString()}"),
      headers: {"Content_Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse("${BASE_URL}/posts/"),
      headers: {"Content_Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels =
          decodedJson.map<PostModel>((e) => PostModel.fromJson(e)).toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> insertPosts(PostModel post) async {
    final body = {"title": post.title, "body": post.body};
    final response = await client.post(
      Uri.parse("${BASE_URL}/posts"),
      body: body,
      headers: {"Content_Type": "application/json"},
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePosts(Post post) async {
    final postId = post.id.toString();
    final body = {
      "title": post.title,
      "body": post.body,
    };
    final response = await client
        .patch(Uri.parse("${BASE_URL}/posts/${postId}"), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
