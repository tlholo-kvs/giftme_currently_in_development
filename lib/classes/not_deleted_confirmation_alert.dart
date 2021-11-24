//This class contains the Confirmation of "Not Deleted"
import 'package:flutter/material.dart';

class NotDeletedConfirmation extends StatelessWidget {
  const NotDeletedConfirmation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextButton(
        child: Text('Confirmation'),
        onPressed: () {
          displayNotDeletedDialog(context);
        },
      ),
    );
  }

  displayNotDeletedDialog(BuildContext context) {
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
      content: Text("Your donation was not deleted"),
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
}
