

import 'package:connectivity_plus/connectivity_plus.dart';


class InternetChecker{
   checkInternetStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      // PPSnackBarUtilities().showSnackBar(message: kInternetErrorMessage, snackbarType: SNACKBARTYPE.error);
      return;
    }

    
  }
}