import 'package:crypto_realtime/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 1.5,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
    );
  }
}
