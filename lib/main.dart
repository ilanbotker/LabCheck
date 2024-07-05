import 'package:flutter/material.dart';
import 'package:lab_check/welcome_screen.dart';
import 'package:lab_check/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import your Firebase options file




void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase
  //await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  //);

  // Run the app
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Check App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Customize your app's theme
      ),
      home: WelcomeScreen(), // Start with the WelcomeScreen
    );
  }
}