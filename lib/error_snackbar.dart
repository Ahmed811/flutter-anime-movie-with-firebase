import 'package:flutter/material.dart';

class ErrorMessage {
  createErrorMessage(
      {required BuildContext? context, required String message}) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        // action: SnackBarAction(
        //   label: 'Action',
        //   onPressed: () {
        //     // Code to execute.
        //   },
        // ),
        content: Text(
          message,
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        duration: const Duration(milliseconds: 1500),
        width: 280.0,
        elevation: 5,
        // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
