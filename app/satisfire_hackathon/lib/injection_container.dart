import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:satisfire_hackathon/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_connection_updates.dart';
import 'core/network/network_info.dart';
import 'features/chats/data/repositories/chats_repository_impl.dart';
import 'features/chats/domain/repositories/chats_repository.dart';
import 'features/credentials/data/repositories/credentials_repository_impl.dart';
import 'features/credentials/domain/repositories/credentials_repository.dart';
import 'features/credentials/presentation/bloc/bloc/credentials_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Credentials
  // Bloc
  sl.registerFactory(() => CredentialsBloc());

  // Repository
  sl.registerLazySingleton<CredentialsRepository>(
      () => CredentialsRepositoryImpl(networkInfo: sl()));

  //! Features - Chats
  // Bloc
  sl.registerFactory(() => ChatsBloc());

  // Repository
  sl.registerLazySingleton<ChatsRepository>(
      () => ChatsRepositoryImpl(networkInfo: sl()));

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
