import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/utilities/snackbar_utils.dart';

class InternetChecker {
  checkInternetStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.mobile) &&
        !connectivityResult.contains(ConnectivityResult.wifi)) {
      TZSnackBarUtilities().showSnackBar(
          message: kInternetErrorMessage, snackbarType: SNACKBARTYPE.error);
      return;
    }
  }
}
