import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_device_telemetry_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetDeviceTelemetryUseCase getDeviceTelemetryUseCase;

  HomeCubit({required this.getDeviceTelemetryUseCase}) : super(HomeInitialState());

  Future<void> loadTelemetry(String deviceId) async {
    emit(HomeLoadingState());
    final result = await getDeviceTelemetryUseCase(GetDeviceTelemetryParams(deviceId: deviceId));
    result.fold(
      (failure) => emit(HomeErrorState(failure.message)),
      (telemetry) => emit(HomeLoadedState(telemetry)),
    );
  }
}
