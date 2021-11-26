import 'dart:io';

import 'package:final_application/provider/auth_provider.dart';
import 'package:final_application/screens/AuthScreen/home.dart';
import 'package:final_application/screens/AuthScreen/login.dart';
import 'package:final_application/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('_image: $_image');
    });
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sign Up',
          style: TextStyle(
            //importing the white text color
            color: AppColors.whiteTextColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                //importing the white boxShadowColour
                color: AppColors.boxShadowColourWhite,
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(500))),
            child: GestureDetector(
              onTap: () {},
            ),
          ),
        )
      ],
    );
  }

  Widget _buildImage() {
    return Icon(Icons.add_a_photo_rounded, size: 80);
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: isLoading == false
              ? Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150, top: 40),
                      child: GestureDetector(
                        onTap: _getImage,
                        child: Container(
                          height: 120,
                          width: 120,
                          color: Colors.white,
                          child: _image == null
                              ? Icon(Icons.add)
                              : Image.file(
                                  _image,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 200, right: 5),
                      child: _buildLogo(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 180),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(color: Colors.white),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                    ),
                                    TextFormField(
                                      controller: _email,
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        prefixIcon: Icon(Icons.email),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                    ),
                                    TextFormField(
                                        controller: _password,
                                        decoration: InputDecoration(
                                            hintText: 'Password',
                                            prefixIcon: Icon(Icons.lock),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              child: Icon(Icons.visibility,
                                                  color: Colors.black),
                                            ))),
                                    SizedBox(
                                      height: 60,
                                    ),
                                    FlatButton(
                                        color: Colors.blue,
                                        onPressed: () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          AuthClass()
                                              .createAccount(
                                                  email: _email.text.trim(),
                                                  password:
                                                      _password.text.trim())
                                              .then((value) {
                                            if (value == 'Register') {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()),
                                                  (route) => false);
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(value)));
                                              //taking a chance at trying to override the default text in
                                              //the Alertdialog with failure message from db
                                              showAlertDialog(context, value);
                                            }
                                          });
                                        },
                                        child: Text('Create account')),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      },
                                      child: Text('Have Account? Login'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Center(child: CircularProgressIndicator())),
    );
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
