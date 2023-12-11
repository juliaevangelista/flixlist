import 'package:flutter/material.dart';
import 'package:flixlist/screens/signup_screen.dart';
import 'package:flixlist/screens/home_screen.dart';
import 'package:flixlist/screens/login_screen.dart';
import 'package:flixlist/screens/splash_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seu Aplicativo',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignUpScreen(),
      },
    );
  }
}
