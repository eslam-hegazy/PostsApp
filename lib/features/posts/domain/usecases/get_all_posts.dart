import 'package:art2/core/error/failure.dart';
import 'package:art2/features/posts/domain/entities/post.dart';
import 'package:art2/features/posts/domain/reposatory/post_reposatory.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase {
  final PostRepository postRepository;
  GetAllPostsUseCase({
    required this.postRepository,
  });
  Future<Either<Failure, List<Post>>> call() async {
    return await postRepository.getAllPosts();
  }
}
