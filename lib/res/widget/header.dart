import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({required this.heading, super.key});

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        heading,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20, fontWeight:FontWeight.w500),
      ),
    );
  }
}