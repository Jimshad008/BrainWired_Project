import 'package:get_it/get_it.dart';


import 'core/constant/theme_bool/bloc/theme_bool_bloc.dart';
import 'features/auth/data/dataSource/auth_remote_data_source.dart';
import 'features/auth/data/repository/auth_repository_implement.dart';
import 'features/auth/domain/repository/auth_repository.dart';

import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/data/dataSource/home_remote_data_source.dart';
import 'features/home/data/repository/home_repository_implement.dart';
import 'features/home/domain/repository/home_repository.dart';
import 'features/home/domain/usecase/fetch_data.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _themeBool();
  _initHome();





}
_initAuth(){
  serviceLocator.registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(

    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
        () => UserLogin(
      serviceLocator(),
    ),

  );
  serviceLocator.registerLazySingleton(
        () => AuthBloc(userLogin: serviceLocator(),
    ),
  );
}
_themeBool(){
  serviceLocator.registerLazySingleton(
        () => ThemeBoolBloc(),

  );
}
_initHome(){
  serviceLocator.registerFactory<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(
    ),
  );
  serviceLocator.registerFactory<HomeRepository>(
        () => HomeRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => FetchData(
      serviceLocator(),
    ),

  );
  serviceLocator.registerLazySingleton(
        () => HomeBloc( fetchData: serviceLocator(),
    ),
  );
}
