import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tedza/constants/constant.dart';

class PPPasswordVerificationWidget extends StatelessWidget {
  const PPPasswordVerificationWidget(
      {required this.text, required this.valid, super.key});

  final String text;
  final bool valid;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6, top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          valid
              ? AnimatedContainer(
                  duration: kDuration,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(
                    color: kLightWhite,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    FontAwesomeIcons.circleCheck,
                    size: 15.0,
                    color: kGreen,
                  ),
                )
              : AnimatedContainer(
                  duration: kDuration,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(
                    color: kLightWhite,
                    shape: BoxShape.circle,
                  ),
                  child:  const Icon(
                    FontAwesomeIcons.circle,
                    size: 15.0,
                    color: kLightGrey,
                  ),
                ),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 13)
            
          ),
        ],
      ),
    );
  }
}
