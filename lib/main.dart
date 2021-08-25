import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jamiu_flutter/screens/home_screen.dart';
import 'auth.dart';
import 'models/user_model.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox('userData');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jamiu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          platform: TargetPlatform.iOS,
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Box dbUserData;

  @override
  void initState() {
    dbUserData = Hive.box('userData');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return HomeScreen();

    if (AuthUser().authenticateUser(dbUserData))
      return HomeScreen();
    else
      return LoginScreen();
  }
}
