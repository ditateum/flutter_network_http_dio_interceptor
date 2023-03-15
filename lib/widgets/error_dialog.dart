import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String err) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text('Error Message'),
        content: Text(err.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
