import 'package:flutter/material.dart';
import 'package:tedza/constants/constant.dart';

class PPFlatButton extends StatelessWidget {
  final String? text;
  final bool active;
  final VoidCallback? pressState;
  final Color textColor, buttonColor;

  const PPFlatButton(
      {this.text,
      required this.pressState,
      required this.active,
      required this.textColor,
      required this.buttonColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kPaddingSS),
        child: TextButton(
            onPressed: pressState,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingMM, horizontal: kPaddingMM),
              backgroundColor: active
                  ? buttonColor
                  : kGrey.withOpacity(.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kPaddingSS)),
            ),
            child: Text(
              text!,
              style: TextStyle(
                color: active ? textColor : kGrey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
      ),
    );
  }
}
