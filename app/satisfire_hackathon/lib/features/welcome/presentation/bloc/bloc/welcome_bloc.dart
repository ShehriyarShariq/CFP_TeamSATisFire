import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(Initial());

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    if (event is CheckCurrentUserEvent) {
      final failureOrUser = await event.func();
      yield failureOrUser.fold(
          (failure) => Error(), (map) => Success(map: map));
    }
  }
}
