import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pkamus/dictionary_screen.dart';
import 'package:pkamus/home_screen.dart';
import 'package:pkamus/model/login_response.dart';
import 'package:pkamus/splash_screen.dart';
import 'package:pkamus/widget/button.global.dart';
import 'package:pkamus/widget/text.form.global.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<LoginResponse?> loginUser() async {
    final String username = emailController.text;
    final String password = passwordController.text;

    final url = Uri.parse('http://192.168.1.7/kamusDb/login.php');

    try {
      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );

      LoginResponse data = loginResponseFromJson(response.body);

      if (response.statusCode == 200) {
        // Autentikasi berhasil
        // Tambahkan logika sesuai kebutuhan Anda, misalnya pindah ke halaman lain
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DictionaryPage()),
          );
        });
      } else if (response.statusCode == 401) {
        // Autentikasi gagal
        setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email atau password salah')),
        );
        });
      } else {
        // Autentikasi gagal karena kesalahan lain
        setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal melakukan login')),
        );
        });
      }
    } catch (e) {
      // Penanganan kesalahan jaringan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'KamusKu',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Silahkan Login!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                TextFormGlobal(
                  controller: emailController,
                  text: 'username',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                TextFormGlobal(
                  controller: passwordController,
                  text: 'Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => loginUser(),
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
