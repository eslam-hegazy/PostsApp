import 'package:art2/core/strings/failires_strings.dart';
import 'package:art2/features/posts/domain/usecases/delete_post.dart';
import 'package:art2/features/posts/domain/usecases/insert_post.dart';
import 'package:art2/features/posts/domain/usecases/update_post.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/post.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final InsertPostUseCase insertPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpDatePostUseCase upDatePostUseCase;
  AddDeleteUpdateBloc({
    required this.insertPostUseCase,
    required this.deletePostUseCase,
    required this.upDatePostUseCase,
  }) : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      emit(LoadingAddPostState());

      if (event is AddPostEvent) {
        final failureOrDoneMessage = await insertPostUseCase(event.post);
        failureOrDoneMessage.fold(
          (l) {
            emit(ErrorAddPostState(message: failureToMessage(l)));
          },
          (r) {
            emit(const SuccessAddPostState(message: ADD_SUCCESS_MESSAGE));
          },
        );
      } else if (event is UpDatePostEvent) {
        final failureOrDoneMessage = await upDatePostUseCase(event.post);
        failureOrDoneMessage.fold(
          (l) {
            emit(ErrorUpDatePostState(message: failureToMessage(l)));
          },
          (r) {
            emit(const SuccessUpDatePostState(message: UPDATE_SUCCESS_MESSAGE));
          },
        );
      } else if (event is DeletePostEvent) {
        final failureOrDoneMessage = await deletePostUseCase(event.postId);
        failureOrDoneMessage.fold(
          (l) {
            emit(ErrorDeletePostState(message: failureToMessage(l)));
          },
          (r) {
            emit(const SuccessDeletePostState(message: DELETE_SUCCESS_MESSAGE));
          },
        );
      }
    });
  }
}
