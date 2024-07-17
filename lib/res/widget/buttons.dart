import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:tedza/constants/constant.dart';


class PPBackButton extends StatelessWidget {
  const PPBackButton({
    super.key,
    required this.onPress,
  });
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return PPRoundButton(
      pressState: onPress,
      textColor: kWhite,
    );
  }
}

class PPRoundButton extends StatelessWidget {
  final VoidCallback pressState;
  final Color textColor;

  const PPRoundButton(
      {required this.pressState, required this.textColor, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: pressState,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: kWhiteTwo,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          IconlyLight.arrow_left_2,
          size: 20,
        ),
      ),
    );
  }
}

class PPChatBoxCardButton extends StatefulWidget {
  final VoidCallback pressState;
  final Color textColor, color;
  final String text;

  const PPChatBoxCardButton(
      {required this.pressState,
      required this.textColor,
      super.key,
      required this.text,
      required this.color});

  @override
  State<PPChatBoxCardButton> createState() => _PPChatBoxCardButtonState();
}

class _PPChatBoxCardButtonState extends State<PPChatBoxCardButton> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.pressState,
      child: Container(
        padding: const EdgeInsets.all(11),
        height: 49,
        decoration: BoxDecoration(
            border: Border.all(
                color: selected
                    ? AppColor.kPrimaryColor
                    : AppColor.kGreyNeutral.shade300),
            borderRadius: BorderRadius.circular(10),
            color: widget.color),
        child: Center(
            child: Text(
          widget.text,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 15, color: widget.textColor),
        )),
      ),
    );
  }
}

class PPBackNextButton extends StatelessWidget {
  final VoidCallback onBackPress;
  final VoidCallback onNextPress;
  final bool active;
  const PPBackNextButton({
    super.key,
    required this.onBackPress,
    required this.onNextPress,
    this.active = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: kPaddingMM, horizontal: kPaddingMM),
                backgroundColor: AppColor.kPrimaryColor.shade50,
                shape: RoundedRectangleBorder(
                    // side: BorderSide(
                    //     color:active ? buttonColor : AppColor.kGreyNeutral.shade300.withOpacity(.5),
                    //     width: kPaddingTwo,
                    //     style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(kPaddingSS)),
              ),
              onPressed: onBackPress,
              child: Text("Back",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColor.kPrimaryColor, fontSize: 18))),
        ),
        horizontalSpaceRegular,
        Expanded(
          child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: kPaddingMM, horizontal: kPaddingMM),
                backgroundColor: active
                    ? AppColor.kPrimaryColor
                    : AppColor.kGreyNeutral.shade300.withOpacity(.5),
                shape: RoundedRectangleBorder(
                    // side: BorderSide(
                    //     color:active ? buttonColor : AppColor.kGreyNeutral.shade300.withOpacity(.5),
                    //     width: kPaddingTwo,
                    //     style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(kPaddingSS)),
              ),
              onPressed: active
                  ? onNextPress
                  : () {
                      return;
                    },
              child: Text("Next",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color:
                          active ? AppColor.kWhiteColor : AppColor.kGreyNeutral,
                      fontSize: 18))),
        ),
      ],
    );
  }
}

class PPDropDownIcon extends StatelessWidget {
  const PPDropDownIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        // decoration: BoxDecoration(
        //   color: PrefUtils.getUserThemePreference() == true
        //       ? kMainColorFade
        //       : kMainColorLight.withOpacity(0.13),
        //   shape: BoxShape.circle,
        // ),
        child: const Icon(
          FontAwesomeIcons.chevronDown,
          color: kDarkGrey,
          size: 14,
        ));
  }
}
