import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/auth_service.dart';
import 'chat_page.dart'; // Import the ChatPage if not already imported

class Physiotherapists extends StatefulWidget {
  const Physiotherapists({Key? key}) : super(key: key);

  @override
  State<Physiotherapists> createState() => _PhysiotherapistsState();
}

class _PhysiotherapistsState extends State<Physiotherapists> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physiotherapists'),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return const Text('error');
          }
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Text('loading');
          }
          return ListView(
            children: snapshots.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.email != data['email']) {
      return Column(
        children: [
          ListTile(
            leading: Image.asset(
              'assets/girl-2.png',
              width: 75,
              height: 75,
            ),
            title: Text(data['email']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverUserEmail: data['email'],
                    receiverUserID: data['uid'],
                  ),
                ),
              );
            },
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
          const Divider(
            color: Colors.black,
            height: 0,
            thickness: 1,
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
