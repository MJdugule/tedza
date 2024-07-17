import 'package:flutter/material.dart';
import 'package:tedza/constants/constant.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/emptyFolder.png', width: 200,),
        verticalSpaceRegular,
        Text(text, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall,)
      ],
    );
  }
}