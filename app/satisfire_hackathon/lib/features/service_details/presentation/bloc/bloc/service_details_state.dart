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

class FetchingRating extends ServiceDetailsState {}

class RatingFetched extends ServiceDetailsState {
  final double rating;

  RatingFetched({this.rating}) : super([rating]);
}
