part of 'app_cubit.dart';

class AppState {
  const AppState({
    this.name = '',
    this.gpsAvailable = false,
    this.connectionAvailable = false,
    this.inProcess = false,
    this.position,
  });

  final String name;
  final bool gpsAvailable;
  final bool connectionAvailable;
  final bool inProcess;
  final LatLng? position;

  AppState copyWith({
    String? name,
    bool? gpsAvailable,
    bool? connectionAvailable,
    bool? inProcess,
    LatLng? position,
    bool deletePosition = false,
  }) {
    return AppState(
      name: name ?? this.name,
      gpsAvailable: gpsAvailable ?? this.gpsAvailable,
      connectionAvailable: connectionAvailable ?? this.connectionAvailable,
      inProcess: inProcess ?? this.inProcess,
      position: deletePosition ? null : position ?? this.position,
    );
  }
}
