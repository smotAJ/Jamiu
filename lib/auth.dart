
import 'package:hive/hive.dart';

import 'models/user_model.dart';

class AuthUser {
   bool authenticateUser(Box dbUserData) {
     List<dynamic>  userData = [];
    if(dbUserData.isNotEmpty){
      userData = dbUserData.get('userData');
      if (userData[0].accessToken != null) {
        return true;
      } else {
        return false;
      }
    } else {
      print("False");
      return false;
    }
  }
}
