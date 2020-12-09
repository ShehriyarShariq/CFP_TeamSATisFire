import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/review.dart';

part 'service_details_event.dart';
part 'service_details_state.dart';

class ServiceDetailsBloc
    extends Bloc<ServiceDetailsEvent, ServiceDetailsState> {
  ServiceDetailsBloc() : super(Initial());

  @override
  Stream<ServiceDetailsState> mapEventToState(
    ServiceDetailsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
