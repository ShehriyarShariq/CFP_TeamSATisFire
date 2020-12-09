part of 'service_details_bloc.dart';

abstract class ServiceDetailsState extends Equatable {
  const ServiceDetailsState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class Initial extends ServiceDetailsState {}

class LoadingReviews extends ServiceDetailsState {}

class LoadedReviews extends ServiceDetailsState {
  final List<Review> reviews;

  LoadedReviews({this.reviews}) : super([reviews]);
}

class Error extends ServiceDetailsState {}
