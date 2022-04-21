import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/logic/bloc/internet_tate.dart';

import '../../data_internet/data_connection_checker.dart';

class InternetCubit extends Cubit<InternetState> {
  late StreamSubscription connectivityStreamSubscription;
  final Connectivity connectivity;
  InternetCubit(this.connectivity) : super(InternetState.InternetLoading) {
    isInternet(DataConnectionChecker());
  }

  isInternet(DataConnectionChecker dc) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((event) async {
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network, make sure there is actually a net connection.
        bool connected = await checkConnection(dc);
        connected == true
            ? emitInternetConnected()
            : emitInternetDisconnected();
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a WIFI network, make sure there is actually a net connection.
        bool connected = await checkConnection(dc);
        connected == true
            ? emitInternetConnected()
            : emitInternetDisconnected();
      } else {
        // Neither mobile data or WIFI detected, not internet connection found.
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected() => emit(InternetState.InternetConnected);

  void emitInternetDisconnected() => emit(InternetState.InternetDisconnected);
  Future<bool> checkConnection(DataConnectionChecker dc) async {
    if (await dc.hasConnection) {
      // Wifi detected & internet connection confirmed.
      print("Internet");
      return true;
    } else {
      // Wifi detected but no internet connection found.
      print("No Internet");
      return false;
    }
  }
}
