import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget icon;
  final String hintText;
  final int maxLine;
  final String? initialValue;

  const CustomTextField({
    Key? key,
    required this.icon,
    required this.controller,
    required this.hintText,
    this.initialValue,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: icon,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        initialValue: initialValue,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter Your $hintText";
          }
          return null;
        },
        maxLines: maxLine,
      ),
    );
  }
}
