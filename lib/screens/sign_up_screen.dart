import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jamiu_flutter/api_service/api_service.dart';
import 'package:jamiu_flutter/constants/constants.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscureTextPassword = true, obscureTextConfirmPassword = true;

  String errorPassword = '';
  final snackBar = SnackBar(content: Text('Fields cannot be empty'));

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController nameTextController = TextEditingController();
    TextEditingController emailTextController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();

    GlobalKey<FormState> passwordGlobalKey = GlobalKey();
    GlobalKey<FormState> confirmPasswordGlobalKey = GlobalKey();
    GlobalKey<FormState> nameTextGlobalKey = GlobalKey();
    GlobalKey<FormState> emailTextGlobalKey = GlobalKey();
    GlobalKey<FormState> phoneNumberGlobalKey = GlobalKey();

    bool validation() {
      bool validator = true;
      if(passwordController.text != confirmPasswordController.text){
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          validator = false;
        });
      }
      if (passwordGlobalKey.currentState!.validate() &&
          confirmPasswordGlobalKey.currentState!.validate() &&
          nameTextGlobalKey.currentState!.validate() &&
          emailTextGlobalKey.currentState!.validate() &&
          phoneNumberGlobalKey.currentState!.validate()) {
        setState(() {
          validator = true;
        });
        print('Valid');
      } else {
        print('Invalid');
      }
      return validator;
    }

    Future<Response> createUser() async {
      Response response = await ApiService().createUser(
          nameTextController.text,
          emailTextController.text,
          phoneNumberController.text,
          passwordController.text);
      return response;
    }

    void validateUserAndSignIn() async{
      late Response response;
      if(validation()) {
        response = await createUser();
      }
      if(response.statusCode == 201){

        // Navigator
        //     .of(context)
        //     .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
        );
      }
    }

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
                              child: Form(
                                key: nameTextGlobalKey,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Name',
                                      labelStyle:
                                          TextStyle(color: Colors.black38),
                                      suffixIcon: Icon(Icons.person)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field cannot be empty";
                                    } else
                                      return null;
                                  },
                                  controller: nameTextController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                            ),
                            Container(color: Colors.black12, height: 1),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: Form(
                                key: emailTextGlobalKey,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      labelStyle:
                                          TextStyle(color: Colors.black38),
                                      suffixIcon: Icon(Icons.email)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field cannot be empty";
                                    } else
                                      return null;
                                  },
                                  controller: emailTextController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                            Container(color: Colors.black12, height: 1),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: Form(
                                key: phoneNumberGlobalKey,
                                child: InternationalPhoneNumberInput(
                                  onInputChanged: (PhoneNumber number) {
                                    print(number.phoneNumber);
                                  },
                                  inputDecoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Phone number',
                                      labelStyle:
                                          TextStyle(color: Colors.black38),
                                      suffixIcon: Icon(Icons.phone_android)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field cannot be empty";
                                    } else
                                      return null;
                                  },
                                  textFieldController: phoneNumberController,
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                ),
                              ),
                            ),
                            Container(color: Colors.black12, height: 1),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: Form(
                                key: passwordGlobalKey,
                                child: TextFormField(
                                  obscureText: obscureTextPassword,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      labelStyle:
                                          TextStyle(color: Colors.black38),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              obscureTextPassword =
                                                  !obscureTextPassword;
                                            });
                                          },
                                          icon: Icon(Icons.remove_red_eye))),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field cannot be empty";
                                    } else
                                      return null;
                                  },
                                  controller: passwordController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                            Container(color: Colors.black12, height: 1),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: Form(
                                key: confirmPasswordGlobalKey,
                                child: TextFormField(
                                  obscureText: obscureTextConfirmPassword,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Confirm password',
                                      labelStyle:
                                          TextStyle(color: Colors.black38),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              obscureTextPassword =
                                                  !obscureTextPassword;
                                            });
                                          },
                                          icon: Icon(Icons.remove_red_eye))),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field cannot be empty";
                                    } else
                                      return null;
                                  },
                                  controller: confirmPasswordController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                            RaisedButton(
                              color: Colors.yellow,
                              onPressed: (){
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
                                      Text('Sign Up!',
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
                  SizedBox(height: 40),
                  Container(color: Colors.black12, height: 1),
                  SizedBox(height: 30),
                  Align(
                      alignment: Alignment.center,
                      child: Text("Don you have an account?",
                          style:
                              TextStyle(color: Colors.black45, fontSize: 15))),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign In!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
