import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text){
  print('$context , $text');
 ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(text),
    ),
  );
}