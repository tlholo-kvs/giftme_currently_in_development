import 'dart:io';

import 'package:final_application/provider/db_service.dart';
import 'package:final_application/provider/db_service2.dart';
import 'package:final_application/screens/AuthScreen/splashScreen3.dart';
import 'package:final_application/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateRequest extends StatefulWidget {
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  bool isRememberMe = false;
  bool isHiddenPassword = true;
  String email, password;

  String valueChoose;
  String value;

  final items = ['Excellent', 'Very Good ', 'Good', 'Bad', 'Very Bad'];

  GlobalKey<FormState> key = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('_image: $_image');
    });
  }

  Widget _buildNamer() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: title,
        decoration: InputDecoration(
          //I added this OutlineInputBorder
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: 'Title',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Title is empty';
          } else {
            return '';
          }
        },
      ),
    );
  }

  Widget _buildNamer2() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: description,
        maxLines: 7,
        decoration: InputDecoration(
          //I added this OutlineInputBorder
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: 'Description',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Description is empty';
          } else {
            return '';
          }
        },
      ),
    );
  }

  Widget _buildImage() {
    return Icon(Icons.add_a_photo_rounded, size: 80);
  }

  Widget _buildSubmitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 45,
            width: 160,
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
                //the button has an elevation of 5.0,
                //color: Colors.blue,
                //I added this ElevatedButton styling
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                onPressed: () {
                  if (!key.currentState.validate()) {
                    print(title.text);
                    print(description.text);

                    //Save data to database

                    DbHelper2()
                        .add(
                            title: title.text.trim(),
                            description: description.text.trim())
                        .then((value) {
                      //a dialog will pop up on the UI to let the user know
                      //they have created an itemand it has been sent to
                      //the database
                      showAlertDialog(context);
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplashScreen3()));
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    //importing the white text color
                    color: AppColors.whiteTextColor,
                    letterSpacing: 1.5,
                  ),
                )))
      ],
    );
  }

  Widget _buildText() {
    return Text(
      'Quality',
      style: TextStyle(
        //importing the grey text colour
        color: AppColors.greyTextColour,
        fontSize: 16,
      ),
    );
  }

  Widget _buildText2() {
    return Padding(
      padding: EdgeInsets.only(right: 180),
      child: Text(
        'Anonymous',
        style: TextStyle(
          //importing the grey text colour
          color: AppColors.greyTextColour,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildCheckBox() {
    return Padding(
      padding: EdgeInsets.only(right: 1),
      child: Checkbox(
        value: isRememberMe,
        //importing the white check colour
        checkColor: AppColors.checkColorWhite,
        //importing the blue active status colour
        activeColor: AppColors.activeStatusColBlue,
        onChanged: (value) {
          setState(() {
            isRememberMe = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  decoration: BoxDecoration(
                      //importing the Blue boxshadow with an opacity
                      color: AppColors.boxShadowColourBlueNoOpacity,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(40),
                        bottomRight: const Radius.circular(40),
                      ))),
            ),
            Padding(
                padding: EdgeInsets.only(left: 140, top: 40),
                child: Text(
                  'Requests',
                  style: TextStyle(
                    //importing the white text colour
                    color: AppColors.whiteTextColor,
                    fontSize: 25,
                  ),
                )),
            Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 320),
                  _buildNamer(),
                  SizedBox(height: 20),
                  _buildNamer2(),
                  SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 5),
                  //   child: _buildText(),
                  // ),
                  SizedBox(height: 10),

                  Row(
                    children: [_buildCheckBox(), _buildText2()],
                  ),
                  SizedBox(height: 5),
                  _buildSubmitButton(),
                ],
              ),
            )
          ],
        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Padding(
        padding: EdgeInsets.only(left: 12),
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
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
    title: Text("Confirmation Of Item Creation"),
    content: Text(
        "Thank you!! Your request has been sent for review by the moderator."),
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
