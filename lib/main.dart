import 'package:amazon_clon_con_node_back/constants/global_variables.dart';
import 'package:amazon_clon_con_node_back/features/auth/screens/auth_screen.dart';
import 'package:amazon_clon_con_node_back/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Amazon Clone",
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData( color:  Colors.black)
        )
      ),
      onGenerateRoute: (settings)=> generateRoute(settings),
      home: const AuthScreen(),
    );
  }
}
