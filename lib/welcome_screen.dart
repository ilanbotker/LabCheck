import 'package:flutter/material.dart';
import 'package:lab_check/computer_lab_screen.dart';
import 'package:lab_check/electronics_lab_screen.dart'; // Import for Electronics Lab screen
import 'package:lab_check/electrical_lab_screen.dart';

import 'computer_lab_screen.dart';
import 'electrical_lab_screen.dart';
import 'electronics_lab_screen.dart'; // Import for Electrical Lab screen

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('בדיקת מעבדה יומית')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('LOGO.png', height: 100.0, width: 100.0,), // Replace with your logo image
            SizedBox(height: 50),
            _buildLabButton(
              context,
              'מעבדת מחשבים',
              ComputerLabScreen(),
            ),
            SizedBox(height: 30),
            _buildLabButton(
              context,
              'מעבדת אלקטרוניקה',
              ElectronicsLabScreen(),
            ),
            SizedBox(height: 30),
            _buildLabButton(
              context,
              'מעבדת חשמל',
              ElectricalLabScreen(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build lab buttons
  Widget _buildLabButton(BuildContext context, String label, Widget nextScreen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 50), // Customize button size
        textStyle: TextStyle(fontSize: 18),
      ),
      child: Text(label),
    );
  }
}