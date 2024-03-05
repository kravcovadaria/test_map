part of 'app_cubit.dart';

class AppState {
  const AppState({
    this.name = '',
    this.gpsAvailable = false,
    this.connectionAvailable = false,
    this.inProcess = false,
  });

  final String name;
  final bool gpsAvailable;
  final bool connectionAvailable;
  final bool inProcess;

  AppState copyWith({
    String? name,
    bool? gpsAvailable,
    bool? connectionAvailable,
  }) {
    return AppState(
        name: name ?? this.name,
        gpsAvailable: gpsAvailable ?? this.gpsAvailable,
        connectionAvailable: connectionAvailable ?? this.connectionAvailable,
    );
  }
}
