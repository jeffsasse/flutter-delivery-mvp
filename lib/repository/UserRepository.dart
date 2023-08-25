import 'package:tobbund/model/user.dart';

class UserRepository{
  static final UserRepository _instance = UserRepository._internal();
  UserRepository._internal();
  factory UserRepository() => _instance;
  User _user;
  set user(User value) => this._user = value;
  User get user => _user;
}