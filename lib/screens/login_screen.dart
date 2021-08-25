import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:jamiu_flutter/api_service/api_service.dart';
import 'package:jamiu_flutter/constants/constants.dart';
import 'package:jamiu_flutter/models/user_model.dart';
import 'package:jamiu_flutter/screens/sign_up_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;

  TextEditingController emailPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void validateUserAndSignIn() async {
    late Response response;

    response = await ApiService()
        .loginUser(emailPhoneController.text, passwordController.text);

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(height: 300, color: Constants.greenColor),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 120, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sign In',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.white)),
                  SizedBox(height: 10),
                  Text('Login to start posting free & premium Ads',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white)),
                  SizedBox(height: 40),
                  Container(
                    height: 222,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child: TextFormField(
                                controller: emailPhoneController,
                                decoration: InputDecoration(
                                    hintText: 'Email or phone number',
                                    labelStyle:
                                        TextStyle(color: Colors.black38),
                                    suffixIcon: Icon(Icons.email)),
                                maxLines: 1,
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 10),
                              child: TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    labelStyle:
                                        TextStyle(color: Colors.black38),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            obscureText = !obscureText;
                                          });
                                        },
                                        icon: Icon(Icons.remove_red_eye))),
                                obscureText: obscureText,
                                maxLines: 1,
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                            RaisedButton(
                              color: Colors.yellow,
                              onPressed: () {
                                validateUserAndSignIn();
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15))),
                              child: Container(
                                height: 65,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Login!',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text('Forgot password?',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black38))),
                  SizedBox(height: 40),
                  Container(color: Colors.black12, height: 1),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.center,
                      child: Text("Don't have  account yet?",
                          style:
                              TextStyle(color: Colors.black45, fontSize: 15))),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign Up!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
