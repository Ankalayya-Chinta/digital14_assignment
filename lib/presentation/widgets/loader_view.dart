import 'package:flutter/material.dart';

class LoaderView extends StatelessWidget {
  const LoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 16, width: double.infinity),
        CircularProgressIndicator(),
        SizedBox(height: 16),
      ],
    );
  }
}
