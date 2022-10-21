import '../error/failure.dart';

const String SERVER_FAILURE_MESSAGE = "Please Try Again Later";
const String EMPTY_CACHE_FAILURE_MESSAGE = "No Data";
const String OFFLINE_FAILURE_MESSAGE =
    "Please Check Your Internet Connection .";
const String ADD_SUCCESS_MESSAGE = "Post Add Successfully";
const String UPDATE_SUCCESS_MESSAGE = "Post Update Successfully";
const String DELETE_SUCCESS_MESSAGE = "Post Delete Successfully";
String failureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case OffLineFailure:
      return OFFLINE_FAILURE_MESSAGE;
    case EmptyCacheFailure:
      return EMPTY_CACHE_FAILURE_MESSAGE;
    default:
      return "UnExpected Error, Please Try Again later .";
  }
}
