import 'package:art2/core/error/failure.dart';
import 'package:art2/core/strings/failires_strings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:art2/features/posts/domain/usecases/get_all_posts.dart';

import '../../../domain/entities/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsBloc(
    this.getAllPosts,
  ) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllPosts.call();
        posts.fold(
          (l) {
            emit(ErrorPostsState(message: failureToMessage(l)));
          },
          (r) {
            emit(SuccessPostsState(posts: r));
          },
        );
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllPosts.call();
        posts.fold(
          (l) {
            emit(ErrorPostsState(message: failureToMessage(l)));
          },
          (r) {
            emit(SuccessPostsState(posts: r));
          },
        );
      }
    });
  }
}
