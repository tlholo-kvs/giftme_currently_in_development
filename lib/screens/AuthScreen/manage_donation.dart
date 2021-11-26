import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_application/provider/db_service.dart';
import 'package:final_application/screens/AuthScreen/get_items.dart';
import 'package:final_application/screens/AuthScreen/main_page2.dart';
import 'package:final_application/screens/AuthScreen/navigation_drawer_widget.dart';

import 'package:final_application/styles/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManageDonations extends StatefulWidget {
  _ManageDonationState createState() => _ManageDonationState();
}

class _ManageDonationState extends State<ManageDonations> {
  //int _currentpos = 0;

  CollectionReference dbCollection2 =
      FirebaseFirestore.instance.collection('Reviewed Donated Items');
  User user = FirebaseAuth.instance.currentUser;

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            //importing the grey boxDecoration colour
            decoration: BoxDecoration(color: AppColors.boxDecorationGrey300),
            child: SingleChildScrollView(
                child: ListView(
              children: [
                ...List.generate(10, (index) {
                  return ListTile(
                    title: Text('Title'),
                    subtitle: Text('Short Description'),
                    trailing: Icon(Icons.delete),
                    leading: Icon(Icons.photo, size: 40),
                  );
                })
              ],
            )),
          ),
        )
      ],
    );
  }

  Widget _buildContainer2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            //importing the grey boxDecoration colour
            decoration: BoxDecoration(color: AppColors.boxDecorationGrey300),
            child: SingleChildScrollView(
                child: ListView(
              children: [
                ...List.generate(10, (index) {
                  return ListTile(
                    title: Text('Title'),
                    subtitle: Text('Short Description'),
                    trailing: Icon(Icons.delete),
                    leading: Icon(Icons.photo, size: 40),
                  );
                })
              ],
            )),
          ),
        )
      ],
    );
  }

  Widget _buildItems() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      child: InkWell(
          child: Container(
            height: 150,
            width: 350,
            color: AppColors.containerColourBlue300,
            child: Row(
              children: [
                Icon(
                  Icons.image,
                  size: 150,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Title:              ",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Description: ",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Quality:        ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => GetItem()));
          }),
    );
  }

  Widget _buildSelectPage() {
    return Row(
      children: [
        SizedBox(width: 25),
        Text(
          'Food Items',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        SizedBox(width: 15),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPage2()));
            },
            child: Text(
              'Other Items',
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        SizedBox(width: 30),
        Icon(
          Icons.sort,
          size: 20,
          //importing the white icon color
          color: AppColors.whiteIconColor,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 80,
          title: Text('Gift Me'),
          centerTitle: true,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 10),
          //     child: Icon(Icons.settings,size: 40),
          //   )
          // ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(40),
                      bottomRight: const Radius.circular(40),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80, left: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  StreamBuilder<QuerySnapshot>(
                      stream: dbCollection2
                          .doc(user.uid)
                          .collection('Reviewed Donated Items')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.docs.isEmpty) {
                            return Center(
                              child: Text("No Item Added Yet"),
                            );
                          } else {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.width * 0.9,
                              //importing the grey boxDecoration colour
                              decoration: BoxDecoration(
                                  color: AppColors.boxDecorationGrey300),
                              child: ListView(children: [
                                ...snapshot.data.docs.map((data) {
                                  final title = data.get('title');
                                  final time = data.get('time');
                                  final description = data.get('description');

                                  String id = data.id;
                                  return ListTile(
                                    title: Text(title),
                                    subtitle: Text('$time'),
                                    trailing: IconButton(
                                      onPressed: () {
                                        DbHelper()
                                            .delete2(id: id)
                                            .then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(value)));
                                        });
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                    leading: Icon(Icons.photo, size: 40),
                                  );
                                })
                              ]),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error Fetching Data'),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
