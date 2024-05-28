


import 'package:chat_firebase_s4/chatting/chat_service.dart';
import 'package:chat_firebase_s4/components/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'components/my_text_field.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage({
    Key? key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Row(
        children: [
          Image.asset(
            'assets/girl-2.png', // Replace with your image asset path
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 8),
          Text(widget.receiverUserEmail),
        ],
      ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }


  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        }


        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),

        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      height: 70,
      decoration: BoxDecoration(

      color: Colors.grey[400], // Dark gray background color for the input area
      borderRadius: BorderRadius.circular(15), // Set the desired border-radius
    ), // Dark gray background color for the input area
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.mic, size: 25),
            onPressed: () {
              // Handle record icon press
            },
          ),
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Type your message...',
              obscureText: false,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, size: 25),
            onPressed: () {
              // Handle camera icon press
            },
          ),
          IconButton(
            icon: const Icon(Icons.send, size: 25),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment =
    (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          ChatBubble(message: data['message']),
        ],
      ),
    );
  }

// ...


}