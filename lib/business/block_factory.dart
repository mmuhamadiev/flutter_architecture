import 'package:flutter_architecture/data/services.dart';
import 'package:get_it/get_it.dart';
import 'main_bloc.dart';

class BlocFactory {
  final GetIt _getIt = GetIt.instance;

  T get<T extends Object>() => _getIt.get<T>();

  static final instance = BlocFactory();

  void initialize() {

    _getIt.registerFactory<MainBloc>(() => MainBloc(userServices: UserServiceProvider.instance.get<UserServices>()));
  }

}