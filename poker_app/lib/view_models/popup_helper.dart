import 'package:flutter/material.dart';

import 'package:poker_app/constants/strings.dart';

class PopupHelper {
  static void showPopup(BuildContext context, String message, String subtitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text(Strings.alertSubtitle),
          content: Text(Strings.alertTitle),
        );
      },
    );
  }
}
