import 'package:flutter_architecture/data/services.dart';
import 'package:flutter_architecture/data/user_data.dart';

@LazySingleton(as: UserServices)
class DummyUserServices implements UserServices {

  @override
  Future<UserData> getDefaultUser() async {
    await Future.delayed(
      Duration(
        seconds: 1
      )
    );
    return UserData(id: 1, name: 'Default');

  }

  @override
  Future<UserData> getUserById(int id) async{
    await Future.delayed(
      Duration(
        seconds: 1
      )
    );
    return UserData(id: id, name: 'Specific User number $id');
  }
}

class LazySingleton {
  const LazySingleton({required Type as});
}