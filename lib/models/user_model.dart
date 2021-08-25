
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {

  @HiveField(0)
  dynamic age;

  @HiveField(1)
  String? id;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? name;

  @HiveField(4)
  dynamic accessToken;

  UserModel({required this.age, required this.id, required this.email, required this.name, required this.accessToken});

}