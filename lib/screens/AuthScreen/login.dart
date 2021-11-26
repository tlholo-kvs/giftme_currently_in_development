import 'package:final_application/provider/auth_provider.dart';
import 'package:final_application/screens/AuthScreen/admin_home.dart';
import 'package:final_application/screens/AuthScreen/create_request.dart';
import 'package:final_application/screens/AuthScreen/home.dart';
import 'package:final_application/screens/AuthScreen/item_donated.dart';
import 'package:final_application/screens/AuthScreen/register.dart';
import 'package:final_application/screens/AuthScreen/reset.dart';
import 'package:final_application/styles/app_colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sign In',
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
                      padding: const EdgeInsets.only(top: 100, right: 20),
                      child: _buildLogo(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 180),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              //this BoxDecoration imports the white color
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
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
                                          FocusScope.of(context).unfocus();
                                        },
                                        child: Icon(Icons.visibility,
                                            color: Colors.black),
                                      )),
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                FlatButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      AuthClass()
                                          .SignIn(
                                              email: _email.text.trim(),
                                              password: _password.text.trim())
                                          .then((value) {
                                        if (value == 'Welcome') {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemDonated()),
                                              (route) => false);

                                          if (_email.text.trim() ==
                                              'profesykxng@gmail.com') {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Admin()));
                                          }
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          showAlertDialog(context);
                                        }
                                      });
                                    },
                                    child: Text('Log In')),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()));
                                  },
                                  child: Text('Do Not Have Account? Register'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ResetPage()));
                                  },
                                  child: Text('Forgot Password? Reset'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
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
    title: Text("Login Unsuccessful!!"),
    content: Text(
        "Your login attemp was unsuccessful. Please enter a valid email and password combination"),
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
