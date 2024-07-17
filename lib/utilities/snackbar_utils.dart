import 'package:flutter/material.dart';

import 'package:tedza/constants/constant.dart';
import 'package:tedza/main.dart';

enum SNACKBARTYPE { error, warning, info, success }

class PPSnackBarUtilities {
  PPSnackBarUtilities();

  showSnackBar({required String message, required SNACKBARTYPE snackbarType}) {
    scaffoldKey.currentState!.hideCurrentSnackBar();
    // IconData icon = FontAwesomeIcons.ban;
    Color color = kRed;

    if (SNACKBARTYPE.warning == snackbarType) {
      // icon = FontAwesomeIcons.circleExclamation;
      color = kOrange;
    } else if (SNACKBARTYPE.info == snackbarType) {
      color = kBlue;
    } else if (SNACKBARTYPE.success == snackbarType) {
      color = kGreen;
    }
    scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: color.withOpacity(0.9),
        content:
            // SnackBarWidget(message),
            Row(
          children: [
            // Lottie.asset(asset, height: 35, width: 35, repeat: true),
            horizontalSpaceSmall,
            Expanded(
              child: Text(
                message,
                style: kFormHeaderTextStyle.copyWith(color: kWhite),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 6),
        elevation: 6.0,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        // padding: EdgeInsets.only(bottom: 200),
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
