import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:final_application/provider/db_service.dart';
import 'package:final_application/provider/db_service2.dart';
import 'package:final_application/screens/AuthScreen/request_review.dart';
//import 'package:final_application/screens/AuthScreen/review_item.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestAccept extends StatefulWidget {
  const RequestAccept({Key key, this.title, this.description, this.id})
      : super(key: key);
  final title;
  final description;
  final id;

  @override
  _RequestAcceptState createState() => _RequestAcceptState();
}

class _RequestAcceptState extends State<RequestAccept> {
  CollectionReference rCollection =
      FirebaseFirestore.instance.collection('Requests');
  User user2 = FirebaseAuth.instance.currentUser;
  GlobalKey<FormState> key = GlobalKey();

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
                child:
                    Text("This Item Will Be Accepted as a Request, Continue?"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 120),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                            //I added a ButtonStyle
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(5),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              DbHelper2()
                                  .add2(
                                      title: widget.title,
                                      description: widget.description,
                                      id: widget.id)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value)));
                              });

                              DbHelper2()
                                  .delete(
                                      id: widget.id,
                                      title: widget.title,
                                      desciption: widget.description)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value)));
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewRequest()),
                              );
                            },
                            child: Text("Yes")),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                            //I added this ElevatedButton styling
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                              fixedSize:
                                  MaterialStateProperty.all(Size(120, 40)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewRequest()),
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

showAlertDialog(BuildContext context, String content) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  //setting up the AlertDialog in terms of a title, content and actions
  AlertDialog confDialog = AlertDialog(
    title: Text("Registration unsuccesful!!"),
    content: Text(
        "Your login attempt was unsuccessful. Please enter a valid email and password combination"),
    actions: [
      okButton,
    ],
  );

  //This method will show the actual dialog
  showDialog(
    barrierColor: Colors.blue,
    context: context,
    builder: (BuildContext context) {
      return confDialog;
    },
  );
}
