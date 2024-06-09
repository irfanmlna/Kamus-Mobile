import 'package:flutter/material.dart';
import 'package:pkamus/login_screen.dart';
import 'package:pkamus/register_screen.dart';
import 'package:pkamus/widget/button.login.dart';
import 'package:pkamus/widget/buttton.register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              './lib/assets/icon.png',
              height: 200,
              width: 150,
            ),
            Text(
              'KamusKu',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.all(20.0),
            ),
            ButtonLogin(),
            SizedBox(height: 10),
            ButtonRegister(),
          ],
        ),
      ),
    );
  }
}
