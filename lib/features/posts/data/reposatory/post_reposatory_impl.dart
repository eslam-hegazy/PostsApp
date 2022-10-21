import 'package:art2/core/error/exception.dart';
import 'package:art2/core/network/network_info.dart';
import 'package:art2/features/posts/data/models/Post_model.dart';
import 'package:dartz/dartz.dart';

import 'package:art2/core/error/failure.dart';
import 'package:art2/features/posts/data/data_source/post_local_date_source.dart';
import 'package:art2/features/posts/data/data_source/post_remote_date_sourece.dart';
import 'package:art2/features/posts/domain/entities/post.dart';
import 'package:art2/features/posts/domain/reposatory/post_reposatory.dart';

class PostRepositoryImpl extends PostRepository {
  final BasePostRemoteDataSource basePostRemoteDataSource;
  final BasePostLocalDateSource basePostLocalDateSource;
  final BaseNetWorkInfo baseNetWorkInfo;
  PostRepositoryImpl({
    required this.basePostRemoteDataSource,
    required this.basePostLocalDateSource,
    required this.baseNetWorkInfo,
  });
  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    if (await baseNetWorkInfo.isConnected) {
      try {
        await basePostRemoteDataSource.deletePosts(id);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await baseNetWorkInfo.isConnected) {
      try {
        final remotePosts = await basePostRemoteDataSource.getAllPosts();
        basePostLocalDateSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await basePostLocalDateSource.getAllPosts();
        return Right(localPosts);
      } on EmptyCacheFailure {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> insertPost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    if (await baseNetWorkInfo.isConnected) {
      try {
        await basePostRemoteDataSource.insertPosts(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> upDatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    if (await baseNetWorkInfo.isConnected) {
      try {
        await basePostRemoteDataSource.updatePosts(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
