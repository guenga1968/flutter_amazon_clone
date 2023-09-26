import 'package:amazon_clon_con_node_back/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '');

      User get user => _user;
      void setUser(String user){
        _user = User.fromJson(user);
      }
}
