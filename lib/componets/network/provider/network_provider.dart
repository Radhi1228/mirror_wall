import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
class NetworkProvider with ChangeNotifier
{
  Connectivity connectivity=Connectivity();
  bool isInterNet=true;
  Future<void> checkConnectivity() async {
    Connectivity().onConnectivityChanged.listen(
          (event) {
        if (event.contains(ConnectivityResult.none)) {
          isInterNet = false;
          //no internet
        } else {
          isInterNet = true;
          // internet on
        }
        notifyListeners();
      },
    );
  }
}