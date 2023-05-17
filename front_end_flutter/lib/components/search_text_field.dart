import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.obscureText, required this.icon})
      : super(key: key);

  final controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        prefixIcon: icon,
        prefixIconColor: Colors.grey[600],
      ),
    );
  }
}
