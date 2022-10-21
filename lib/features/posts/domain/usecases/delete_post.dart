import 'package:art2/core/error/failure.dart';
import 'package:art2/features/posts/domain/reposatory/post_reposatory.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostRepository postRepository;
  DeletePostUseCase({
    required this.postRepository,
  });
  Future<Either<Failure, Unit>> call(int id) async {
    return await postRepository.deletePost(id);
  }
}
