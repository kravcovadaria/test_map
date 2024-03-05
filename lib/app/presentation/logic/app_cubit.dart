import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  Future<void> submit(String name) async {

    ConnectivityResult connectivityResult =
    await Connectivity().checkConnectivity();

    bool connectionAvailable = connectivityResult != ConnectivityResult.none;


  }
}
