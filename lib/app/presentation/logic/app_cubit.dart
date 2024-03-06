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
        name: name,
        position: null,
        inProcess: true,
        gpsAvailable: false,
        connectionAvailable: false,
      ),
    );

    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();

    bool connectionAvailable = connectivityResult != ConnectivityResult.none;
    LocationPermission gpsPermission = await Geolocator.checkPermission();
    bool gpsAvailable = gpsPermission == LocationPermission.always ||
        gpsPermission == LocationPermission.whileInUse;

    LatLng? position;
    if (connectionAvailable && gpsAvailable) {
      Position? pos = await Geolocator.getCurrentPosition();
      position = LatLng(pos.latitude, pos.longitude);
    }

    emit(
      state.copyWith(
        connectionAvailable: connectionAvailable,
        gpsAvailable: gpsAvailable,
        inProcess: false,
        position: position,
      ),
    );
  }
}
