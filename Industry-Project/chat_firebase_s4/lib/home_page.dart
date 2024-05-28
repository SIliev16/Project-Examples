import 'package:chat_firebase_s4/auth/auth_service.dart';
import 'package:chat_firebase_s4/figma_to_code_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Physiotherapists.dart';
import 'family.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Family(),
    Physiotherapists(),
    FigmaToCodeApp(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  void signOut(){
    final authService = Provider.of<AuthService>(context,listen: false );
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10.0),
        child: AppBar(
          title: const Text('Chat rooms', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF15B0A9),

          actions: [
            IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.logout),
            )
          ],
        ),
      ),

      body: Stack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: const Color(0xFF13CCCC),
              padding: const EdgeInsets.only(top: kToolbarHeight + 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _onItemTapped(0),
                    child: Text(
                      'Family',
                      style: TextStyle(
                        color: _selectedIndex == 0 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(1),
                    child: Text(
                      'Physiotherapists',
                      style: TextStyle(
                        color: _selectedIndex == 1 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(2),
                    child: Text(
                      'Community',
                      style: TextStyle(
                        color: _selectedIndex == 2 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}