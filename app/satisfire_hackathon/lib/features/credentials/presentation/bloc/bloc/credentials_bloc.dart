import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'credentials_event.dart';
part 'credentials_state.dart';

class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  CredentialsBloc() : super(Initial());

  @override
  Stream<CredentialsState> mapEventToState(
    CredentialsEvent event,
  ) async* {
    if (event is LoginWithCredentialsEvent) {
      yield Processing();
      final failureOrSuccess = await event.func();
      yield failureOrSuccess.fold((failure) => Error(failure.errorMsg),
          (success) => Success(isAdmin: success));
    } else if (event is RegisterUserEvent) {
      yield Processing();
      final failureOrSuccess = await event.func();
      yield failureOrSuccess.fold(
          (failure) => Error(failure.errorMsg), (success) => Registered());
    } else if (event is SendCodeEvent) {
      yield SendingCode();
    } else if (event is CodeSentEvent) {
      yield CodeSent();
    } else if (event is VerifyingCodeEvent) {
      yield Processing();
    } else if (event is CodeVerifiedEvent) {
      yield Processed();
    }
  }
}
