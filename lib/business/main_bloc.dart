import 'dart:async';
import '../data/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/user_data.dart';

part 'main_bloc.freezed.dart';


class MainBloc {

  late UserServices userServices;
  final StreamController<MainBlocEvent>  _eventControllerBloc = StreamController();
  final StreamController<MainBlocState>  _stateController = StreamController.broadcast();

  Stream<MainBlocState> get state => _stateController.stream;

  MainBloc({
    required this.userServices
}) {
    _eventControllerBloc.stream.listen((event) {
      event.map<void>(
        init: (_) async{
          _stateController.add(
            MainBlocState.loading(),
          );
          _stateController.add(
            MainBlocState.loaded(
              userData: await userServices.getDefaultUser(),
            ),
          );
        },
        setUser: (event) async => _stateController.add(
        MainBlocState.loaded(
          userData: await userServices.getUserById(event.userId),
        ),
      ),
      );
    });
  }


  void add(MainBlocEvent event) {
    if(_eventControllerBloc.isClosed) return;
    _eventControllerBloc.add(event);
  }

  void dispose() {
    _eventControllerBloc.close();
    _stateController.close();
  }

}

@freezed
class MainBlocState with _$MainBlocState{
  const factory MainBlocState.loading() = MainLoadingState;
  const factory MainBlocState.loaded({required UserData userData}) = MainLoadedState;
}

@freezed
class MainBlocEvent with _$MainBlocEvent{
  const factory MainBlocEvent.init() = MainInitState;
  const factory MainBlocEvent.setUser({required int userId}) = MainSetState;
}

