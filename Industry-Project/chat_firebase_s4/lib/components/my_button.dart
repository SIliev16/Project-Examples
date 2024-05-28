import 'package:flutter/material.dart';




class MyButton extends StatelessWidget {
 final String text;
  final void Function()? onTap;

  const MyButton({Key? key,required this.text,  this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        padding: const EdgeInsets.all(25),
        color: Colors.blue,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
