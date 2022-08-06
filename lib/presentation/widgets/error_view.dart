import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String? message;

  const ErrorView({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16, width: double.infinity),
        Text(
          message ?? '',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
