import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/dio_client.dart';
import '../../core/sevices/local_storage_service.dart';
import '../../core/sevices/secure_storage_service.dart';
import '../../core/sevices/hive_service.dart';

import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_device_telemetry_usecase.dart';
import '../../features/home/presentation/bloc/home_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Core Storage
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService(sl()));
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<HiveService>(() => HiveService());

  // Core Network
  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));

  // Features - Home
  // Data Sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton<GetDeviceTelemetryUseCase>(
    () => GetDeviceTelemetryUseCase(sl()),
  );

  // Cubits / Blocs
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(getDeviceTelemetryUseCase: sl()),
  );
}
