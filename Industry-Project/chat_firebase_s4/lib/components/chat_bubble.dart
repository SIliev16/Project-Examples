import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;


  const ChatBubble({
    Key? key,
    required this.message,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFF13CCCC),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16 , color : Colors.white),
      ),
    );
  }
}
