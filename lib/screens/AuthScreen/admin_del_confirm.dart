import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_application/provider/db_service.dart';
import 'package:final_application/screens/AuthScreen/review_item.dart';
import 'package:final_application/screens/AuthScreen/view_item.dart';
import 'package:final_application/styles/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteConfirm extends StatefulWidget {
  const DeleteConfirm({Key key, this.title, this.description, this.id})
      : super(key: key);
  final title;
  final description;
  final id;

  @override
  _DeleteConfirmState createState() => _DeleteConfirmState();
}

class _DeleteConfirmState extends State<DeleteConfirm> {
  CollectionReference dbCollection =
      FirebaseFirestore.instance.collection('Donate Item');
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 360, left: 30),
                child: Text(
                    "This Will Result in the donation item being deleted, Continue?"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 120),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            onPressed: () {
                              DbHelper()
                                  .delete(
                                      id: widget.id,
                                      title: widget.title,
                                      desciption: widget.description)
                                  .then((value) {
                                showAlertDialog(context);
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewDonations()),
                              );
                            },
                            child: Text("Yes")),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewDonations()),
                              );
                            },
                            child: Text("No")),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  //setting up the AlertDialog in terms of a title, content and actions
  AlertDialog confDialog = AlertDialog(
    title: Text("Delete Successful"),
    content: Text("You have successfully deleted the item"),
    actions: [
      okButton,
    ],
  );

  //This method will show the actual dialog
  showDialog(
    barrierColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return confDialog;
    },
  );
}
