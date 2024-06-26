import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dashboar.dart';
import 'map.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime, List> _events;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late List _selectedEvents;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _events = {};
    _selectedEvents = [];
    _calendarFormat = CalendarFormat.month;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents = _events[selectedDay] ?? [];
    });
  }

  void _addErrand() {
    final TextEditingController _errandController = TextEditingController();
    final TextEditingController _timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Errand'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _errandController,
                decoration: InputDecoration(hintText: 'Enter errand title'),
              ),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(hintText: 'Pick a time'),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    _timeController.text = pickedTime.format(context);
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (_errandController.text.isEmpty || _timeController.text.isEmpty) {
                  return;
                }
                if (_events[_selectedDay] == null) {
                  _events[_selectedDay] = [];
                }
                setState(() {
                  _events[_selectedDay]!.add({
                    'title': _errandController.text,
                    'time': _timeController.text,
                  });
                  _selectedEvents = _events[_selectedDay]!;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212029),
      appBar: AppBar(
        backgroundColor: Color(0xFF212029),
        elevation: 0,
        title: Text(
          'Your Calendar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            calendarFormat: _calendarFormat,
            eventLoader: (day) => _events[day] ?? [],
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Adjust style to make the calendar larger
              cellMargin: EdgeInsets.all(4.0),
              cellPadding: EdgeInsets.all(6.0),
            ),
          ),
          ..._selectedEvents.map(
                (event) => ListTile(
              title: Text(
                event['title'],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                event['time'],
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addErrand,
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      color: Color(0xFF212029),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.grey),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard()));
            },
          ),
          IconButton(
            icon: Icon(Icons.map, color: Colors.grey),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MapScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.amber),
            onPressed: () {}, // This page is already active.
          ),
        ],
      ),
    );
  }
}
