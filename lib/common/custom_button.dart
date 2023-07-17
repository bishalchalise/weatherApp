import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  const CustomButton(
      {super.key, this.color, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          double.infinity,
          50,
        ),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
        
      ),
      child: Text(
        text,
        style: TextStyle(color: color == null ? Colors.black: Colors.white),
      ),
    );
  }
}