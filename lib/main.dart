import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasky/splash_screen.dart';

void main() {
  runApp(TaskyApp());
}
class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}