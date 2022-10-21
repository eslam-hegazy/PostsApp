import 'dart:convert';

import 'package:art2/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:art2/features/posts/data/models/Post_model.dart';

abstract class BasePostLocalDateSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> cachePosts(List<PostModel> postModel);
}

class PostLocalDateSource extends BasePostLocalDateSource {
  final SharedPreferences sharedPreferences;
  PostLocalDateSource({
    required this.sharedPreferences,
  });
  @override
  Future<Unit> cachePosts(List<PostModel> postModel) {
    List postModelToJson =
        postModel.map<Map<String, dynamic>>((e) => e.toJson()).toList();
    sharedPreferences.setString("CACHED_POSTS", json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getAllPosts() {
    final getCachedPosts = sharedPreferences.getString("CACHED_POSTS");
    if (getCachedPosts != null) {
      List decodeJsonDate = json.decode(getCachedPosts);
      List<PostModel> jsonToPostModels =
          decodeJsonDate.map<PostModel>((e) => e.fromJson(e)).toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
