import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:satisfire_hackathon/features/chat_room/data/repositories/chat_room_repository_impl.dart';
import 'package:satisfire_hackathon/features/chat_room/domain/repositories/chat_room_repository.dart';
import 'package:satisfire_hackathon/features/chat_room/presentation/bloc/chat_room_bloc.dart';
import 'package:satisfire_hackathon/features/customer_dashboard/data/repositories/customer_dashboard_repository_impl.dart';
import 'package:satisfire_hackathon/features/customer_dashboard/domain/repositories/customer_dashboard_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_connection_updates.dart';
import 'core/network/network_info.dart';
import 'features/credentials/data/repositories/credentials_repository_impl.dart';
import 'features/credentials/domain/repositories/credentials_repository.dart';
import 'features/credentials/presentation/bloc/bloc/credentials_bloc.dart';
import 'features/welcome/data/repositories/welcome_repository_impl.dart';
import 'features/welcome/domain/repositories/welcome_repository.dart';
import 'features/welcome/presentation/bloc/bloc/welcome_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Welcome
  // Bloc
  sl.registerFactory(() => WelcomeBloc());

  // Repository
  sl.registerLazySingleton<WelcomeRepository>(() => WelcomeRepositoryImpl(
        networkInfo: sl(),
        sharedPreferences: sl(),
      ));

  //! Features - Credentials
  // Bloc
  sl.registerFactory(() => CredentialsBloc());

  // Repository
  sl.registerLazySingleton<CredentialsRepository>(
      () => CredentialsRepositoryImpl(networkInfo: sl()));

  //! Features - Customer Dashboard
  // Bloc
  // sl.registerFactory(() => CustomerDashboardB());

  // Repository
  sl.registerLazySingleton<CustomerDashboardRepository>(
      () => CustomerDashboardRepositoryImpl(
            networkInfo: sl(),
            sharedPreferences: sl(),
          ));

  //! Features - Chat Room
  // Bloc
  sl.registerFactory(() => ChatRoomBloc());

  // Repository
  sl.registerLazySingleton<ChatRoomRepository>(
      () => ChatRoomRepositoryImpl(networkInfo: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! Core
  sl.registerLazySingleton<NetworkConnectionUpdates>(
      () => NetworkConnectionUpdatesImpl(sl(), sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
