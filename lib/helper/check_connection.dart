import 'package:data_connection_checker/data_connection_checker.dart';

class CheckConnection {
  static Future<bool> checkConnection() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      print('Connection OK');
      return true;
    } else {
      print('No internet :( Reason:');
      print(DataConnectionChecker().lastTryResults);
      return false;
    }
  }
}
