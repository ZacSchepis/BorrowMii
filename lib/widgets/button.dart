import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color ?color;
  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.color
  });

  @override
  Widget build(BuildContext ctx) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey.shade300, 
        foregroundColor:  color ?? Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),

      onPressed: onPressed, 
      child: Text(text), 
    );
  }
}