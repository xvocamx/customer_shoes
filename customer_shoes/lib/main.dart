import 'package:customer_shoes/screen/Home.dart';
import 'package:customer_shoes/screen/signIn.dart';
import 'package:customer_shoes/screen/signUp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/signIn' : (context) => const SignIn(),
        '/signUp' : (context) => const SignUp(),
        '/home' : (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: const SignIn(),
    );
  }
}

