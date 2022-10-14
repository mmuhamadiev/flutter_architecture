import 'package:flutter_architecture/data/user_data.dart';
import 'package:get_it/get_it.dart';
import 'internals.dart';

class UserServiceProvider {
  final GetIt _getIt = GetIt.I;

  T get<T extends Object>() => _getIt.get<T>();

  static final instance = UserServiceProvider();

  void initialize() {

    _getIt.registerLazySingleton<UserServices>(() =>  DummyUserServices());
  }

}

abstract class UserServices {
  Future<UserData> getDefaultUser();
  Future<UserData> getUserById(int id);

}