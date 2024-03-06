import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  Future<void> submit(String name) async {
    emit(
      state.copyWith(
        name: name.trim(),
        position: null,
        inProcess: true,
        gpsAvailable: false,
        connectionAvailable: false,
      ),
    );

    calculatePosition();
  }

  Future<void> calculatePosition() async {
    emit(state.copyWith(inProcess: true));
    _calculatePosition();
  }

  Future<void> _calculatePosition() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();

    // якщо увімкнено впн, але нема з'єднання з інтернетом, буде хибне підтвердження
    bool connectionAvailable = connectivityResult != ConnectivityResult.none &&
        connectivityResult != ConnectivityResult.vpn;

    // нема сенсу перевіряти, бо це перевіряється при запиті позиції
    bool gpsAvailable = true;

    LatLng? position;
    if (connectionAvailable && gpsAvailable) {
      try {
        // якщо юзер в процесі відключив геопозицію, буде виключення
        Position? pos = await Geolocator.getCurrentPosition();
        position = LatLng(pos.latitude, pos.longitude);
      } catch (e) {
        gpsAvailable = false;
      }
    }

    emit(
      state.copyWith(
        connectionAvailable: connectionAvailable,
        gpsAvailable: gpsAvailable,
        inProcess: false,
        position: position,
        deletePosition: position == null,
      ),
    );
  }
}
