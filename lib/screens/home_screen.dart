import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:hive/hive.dart';
import 'package:jamiu_flutter/api_service/api_service.dart';
import 'package:jamiu_flutter/constants/constants.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Box dbUserData;
  List<dynamic> userData =[];

  showLogoutAlert(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text("Are you sure you want to logout?"),
        content:
        Text("We will clear your data to ensure safety"),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("OK"),
            onPressed: () {
              dbUserData.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
          BasicDialogAction(
            title: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    dbUserData = Hive.box('userData');
    if (dbUserData.isEmpty) {

     // TO DO
    } else {
      userData = dbUserData.get('userData');
      print('userData[0].name');
      print(userData[0].name);
      print(userData[0].id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Constants.greenColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                    child: InkWell(
                      onTap: (){
                        showLogoutAlert(context);
                      },
                        child: Icon(Icons.power_settings_new, size: 30, color: Colors.white))
                  ),
                  Positioned(
                    top: 120,
                    left: 30,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  Positioned(
                    top: 220,
                    right: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Icon(Icons.security, size: 20, color: Constants.greenColor),
                       SizedBox(width: 10),
                       Text('Verified')
                     ],
                    ),
                  ),
                  Positioned(
                    top: 270,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            userData[0].name ?? 'Chibundu'.trim(),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Row(
                          children: [
                            Text(
                              'ID : ',
                              style: TextStyle(color: Colors.black38, fontSize: 14),
                            ),
                            Text(
                              userData[0].id ?? '',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Email : ',
                              style: TextStyle(color: Colors.black38, fontSize: 14),
                            ),
                            Text(
                              userData[0].email ?? '',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Age : ',
                              style: TextStyle(color: Colors.black38, fontSize: 14),
                            ),
                            Text(
                              '${userData[0].age.toString()}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
