import 'package:flutter/material.dart';
import 'dashboar.dart';
import 'map.dart';
import 'calendar.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  CustomNavigationBar({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF212029),
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard()));
            break;
          case 1:
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MapScreen()));
            break;
          case 2:
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CalendarScreen()));
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendar',
        ),
      ],
    );
  }
}
