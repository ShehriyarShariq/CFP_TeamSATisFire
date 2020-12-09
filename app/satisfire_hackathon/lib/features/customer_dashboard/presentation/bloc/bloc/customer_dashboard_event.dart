part of 'customer_dashboard_bloc.dart';

abstract class CustomerDashboardEvent extends Equatable {
  const CustomerDashboardEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class LoadAllCategoriesEvent extends CustomerDashboardEvent {
  final Function func;

  LoadAllCategoriesEvent({this.func}) : super([func]);
}

class LoadPopularServicesEvent extends CustomerDashboardEvent {
  final Function func;

  LoadPopularServicesEvent({this.func}) : super([func]);
}
