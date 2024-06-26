import 'package:flutter/material.dart';
import 'map.dart';
import 'calendar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, String>> upcomingFlights = [];

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  @override
  Widget build(BuildContext context) {
    var greeting = getGreeting();

    return Scaffold(
      backgroundColor: Color(0xFF212029),
      appBar: AppBar(
        backgroundColor: Color(0xFF212029),
        elevation: 0,
        title: Text(
          greeting, // Use the greeting here
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.amber),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: upcomingFlights.length,
        itemBuilder: (context, index) {
          var flight = upcomingFlights[index];
          return ListTile(
            title: Text(flight['destination'] ?? '', style: TextStyle(color: Colors.white)),
            subtitle: Text('Departure: ${flight['goingDate']} Return: ${flight['returnDate']}', style: TextStyle(color: Colors.white70)),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  upcomingFlights.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed logic here
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF212029),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.amber),
              onPressed: () {}, // This page is already active.
            ),
            IconButton(
              icon: Icon(Icons.map, color: Colors.grey),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.grey),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
