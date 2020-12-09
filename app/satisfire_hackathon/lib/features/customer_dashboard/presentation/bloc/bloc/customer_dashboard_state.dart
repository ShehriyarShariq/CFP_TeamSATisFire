part of 'customer_dashboard_bloc.dart';

abstract class CustomerDashboardState extends Equatable {
  const CustomerDashboardState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class Initial extends CustomerDashboardState {}

class LoadingCategories extends CustomerDashboardState {}

class LoadedCategories extends CustomerDashboardState {
  final List<Category> categories;

  LoadedCategories({this.categories}) : super([categories]);
}

class ErrorLoadingCategories extends CustomerDashboardState {}

class LoadingServices extends CustomerDashboardState {}

class LoadedServices extends CustomerDashboardState {
  final List<Service> services;

  LoadedServices({this.services}) : super([services]);
}

class ErrorLoadingServices extends CustomerDashboardState {}
