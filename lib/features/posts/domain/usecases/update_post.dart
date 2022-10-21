import 'package:art2/core/error/failure.dart';
import 'package:art2/features/posts/domain/reposatory/post_reposatory.dart';
import 'package:dartz/dartz.dart';

import '../entities/post.dart';

class UpDatePostUseCase {
  final PostRepository postRepository;
  UpDatePostUseCase({
    required this.postRepository,
  });
  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepository.upDatePost(post);
  }
}
