
import 'dart:convert';

import 'package:amazon_clon_con_node_back/constants/error_handling.dart';
import 'package:amazon_clon_con_node_back/constants/global_variables.dart';
import 'package:amazon_clon_con_node_back/constants/utils.dart';
import 'package:amazon_clon_con_node_back/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials":'true',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Cuenta Creada Correctamente, por favor ingrese con el correo y contraseñas registrado',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // function SIGIN USER

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  
  }) async {
    try {
      
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: jsonEncode({
          'email' : email,
          'password' : password
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials":'true',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance(); 
          prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Provider.of<UserProvider>(contex, listen: false).setUser(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}