
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tedza/constants/constant.dart';

class PPCheckBox extends StatefulWidget {
  final bool isChecked;
  final VoidCallback onTapCheck;
  const PPCheckBox({
    super.key,
    required this.isChecked,
    required this.onTapCheck,
  });

  @override
  State<PPCheckBox> createState() => _BPCheckBoxState();
}

class _BPCheckBoxState extends State<PPCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTapCheck,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastLinearToSlowEaseIn,
          width: kPaddingXL,
          height: kPaddingXL,
          decoration: BoxDecoration(
            border: Border.all(color:  widget.isChecked
                  ? kMainColorDark
                  : kGrey),
              color: widget.isChecked
                  ? kMainColorDark
                  : kLightGrey,
                  // PrefUtils.getUserThemePreference() == true
                  //     ? kLightBlack
                  //     : kMainColorFade,
              borderRadius: BorderRadius.circular(kPaddingFIVE)),
          margin: const EdgeInsets.only(right: kPaddingMM),
          child: widget.isChecked
              ? const Icon(
                  FontAwesomeIcons.check,
                  size: kPaddingS,
                  color: kWhite,
                )
              : null,
        ));
  }
}
