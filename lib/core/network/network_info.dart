import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class BaseNetWorkInfo {
  Future<bool> get isConnected;
}

class NetWorkInfo implements BaseNetWorkInfo {
  final InternetConnectionChecker internetConnectionChecker;
  NetWorkInfo({
    required this.internetConnectionChecker,
  });
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
