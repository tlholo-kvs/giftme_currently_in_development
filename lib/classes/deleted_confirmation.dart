//This alert will be nested in the other alert as a confirmation that
//nothing was deleted, or something was deleted
import 'package:flutter/material.dart';

class DeleteConfirmationAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextButton(
        child: Text('Confirmation'),
        onPressed: () {
          displayDeletedDialog(context);
        },
      ),
    );
  }
}

displayDeletedDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmation Dialog"),
    content: Text("Your donation was deleted"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
