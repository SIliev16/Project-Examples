import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
 final TextEditingController controller;
 final String hintText;
 final bool obscureText;




  const MyTextField ({super.key, required this.controller, required this.hintText, required this.obscureText});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder( // Use OutlineInputBorder for border styling
          borderSide: BorderSide(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15.0),

        ),
        focusedBorder:  const OutlineInputBorder( // Use OutlineInputBorder for border styling
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}