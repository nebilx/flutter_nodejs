import 'package:flutter/material.dart';
import 'package:flutter_nodejs/constants/global_variable.dart';
import 'package:flutter_nodejs/features/auth/screens/auth_screen.dart';
import 'package:flutter_nodejs/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       scaffoldBackgroundColor: GloalVariable.backgroundColor,
       colorScheme: const ColorScheme.light(
        primary: GloalVariable.secondaryColor, 
       ),
       appBarTheme: AppBarTheme(elevation: 0, iconTheme: IconThemeData(color: Colors.black))
      ),
      onGenerateRoute: ((settings) => genetateRoute(settings)),
      home: Center(child: Builder(
        builder: (context) {
          return ElevatedButton(onPressed: () {
            Navigator.pushNamed(context, AuthScreen.routeName);}, child: Text('Click'),);
        }
      )),
    );
  }
}
