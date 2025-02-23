import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const ButtonPrimary({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
