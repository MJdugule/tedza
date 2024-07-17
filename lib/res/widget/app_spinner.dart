import 'package:flutter/material.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: SizedBox(
      height: 27,
      width: 27,
      child: CircularProgressIndicator(strokeWidth: 5,)));
  }
}