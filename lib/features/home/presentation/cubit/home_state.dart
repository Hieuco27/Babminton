import 'package:equatable/equatable.dart';
import '../../domain/entities/device_telemetry.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final DeviceTelemetry telemetry;

  const HomeLoadedState(this.telemetry);

  @override
  List<Object?> get props => [telemetry];
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
