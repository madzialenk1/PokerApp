import 'package:flutter/material.dart';

class PopupHelper {
  static void showPopup(BuildContext context, String message, String subtitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: Text(subtitle),
        );
      },
    );
  }
}
