import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppDialog {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          spacing: 10,
          children: [
            CircularProgressIndicator(color: Color(0xff5F33E1)),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
