part of 'service_details_bloc.dart';

abstract class ServiceDetailsEvent extends Equatable {
  const ServiceDetailsEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class LoadReviewsEvent extends ServiceDetailsEvent {
  final Function func;

  LoadReviewsEvent({this.func}) : super([func]);
}
