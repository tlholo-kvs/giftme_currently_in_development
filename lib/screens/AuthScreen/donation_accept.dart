import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_application/provider/db_service.dart';
import 'package:final_application/screens/AuthScreen/review_item.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AcceptDonation extends StatefulWidget {
  const AcceptDonation({Key key, this.title, this.description, this.id})
      : super(key: key);
  final title;
  final description;
  final id;

  @override
  _DeleteConfirmState createState() => _DeleteConfirmState();
}

class _DeleteConfirmState extends State<AcceptDonation> {
  CollectionReference dbCollection2 =
      FirebaseFirestore.instance.collection('Reviewed Donated Items');
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
                    Text("This Item Will Be Accepted as a Donation, Continue?"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 120),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                            //I added styling to this ElevatedButton
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
                                  .add2(
                                      id: widget.id,
                                      title: widget.title,
                                      desciption: widget.description)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value)));
                              });

                              DbHelper()
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
                                    builder: (context) => ReviewDonations()),
                              );
                            },
                            child: Text("Yes")),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                            //I added styling to this ElevatedButton
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            onPressed: () {},
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
