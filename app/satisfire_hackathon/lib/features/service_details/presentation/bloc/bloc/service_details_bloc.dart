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
    if (event is LoadReviewsEvent) {
      yield LoadingReviews();
      final failureOrReviews = await event.func();
      yield failureOrReviews.fold(
          (failure) => Error(), (reviews) => LoadedReviews(reviews: reviews));
    } else if (event is OpenChatRoomEvent) {
      yield MakingChatRoom();
      final failureOrSuccess = await event.func();
      yield failureOrSuccess.fold((failure) => Error(),
          (chatID) => ChatRoomEstablished(chatID: chatID));
    }
  }
}
