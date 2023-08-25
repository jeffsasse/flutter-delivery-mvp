import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:tobbund/widgets/dialog.dart';

BuildContext dialogcontext;
int i = 0;
class ConnectivityProvider{
  Future connectionListen()async{
    await Connectivity().checkConnectivity().then((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
      } else if (result == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
      }else{
          Dialogs.showLoadingDialog(dialogcontext, title: "Bağlantı Hatası", description: "Lütfen internet bağlantınızı kontrol edin.", icon: 'failed', barrierDismissible: true);
      }
    });
  }
}