import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satisfire_hackathon/features/all_categories/data/models/category.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/service.dart';

part 'customer_dashboard_event.dart';
part 'customer_dashboard_state.dart';

class CustomerDashboardBloc
    extends Bloc<CustomerDashboardEvent, CustomerDashboardState> {
  CustomerDashboardBloc() : super(Initial());

  @override
  Stream<CustomerDashboardState> mapEventToState(
    CustomerDashboardEvent event,
  ) async* {
    if (event is LoadAllCategoriesEvent) {
      yield LoadingCategories();
      final failureOrCategories = await event.func();
      yield failureOrCategories.fold((failure) => ErrorLoadingCategories(),
          (categories) => LoadedCategories(categories: categories));
    } else if (event is LoadPopularServicesEvent) {
      yield LoadingServices();
      final failureOrServices = await event.func();
      yield failureOrServices.fold((failure) => ErrorLoadingServices(),
          (services) => LoadedServices(services: services));
    }
  }
}
