import 'package:flutter/material.dart';
import 'dart:io';

class SummaryScreen extends StatelessWidget {
  final double painLevel;
  final String condition;
  final Map<String, bool> symptoms;
  final File? image;
  final String additionalDetails;
  final String title; // Assuming you want to show the title

  SummaryScreen({
    required this.painLevel,
    required this.condition,
    required this.symptoms,
    this.image,
    required this.additionalDetails,
    this.title = '', // Default to an empty string if not provided
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (title.isNotEmpty)
              Text('Title: $title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Pain Level: ${painLevel.toStringAsFixed(1)}'),
            Text('Condition: $condition'),
            Text('Symptoms: ${symptoms.keys.where((key) => symptoms[key]!).join(', ')}'),
            if (image != null) Image.file(image!, height: 200, width: 300),
            Text('Additional Details: $additionalDetails'),
            // Add any additional widgets or data presentation as needed
          ],
        ),
      ),
    );
  }
}
