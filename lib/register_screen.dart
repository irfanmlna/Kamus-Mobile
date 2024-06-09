import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pkamus/login_screen.dart';
import 'package:pkamus/model/register_response.dart';
import 'package:pkamus/splash_screen.dart';
import 'package:pkamus/widget/button.global.dart';
import 'package:pkamus/widget/button.regist.dart';
import 'package:pkamus/widget/text.form.global.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailrController = TextEditingController();
  final TextEditingController passwordrController = TextEditingController();

  Future<RegisterResponse?> registerUser() async {
    final String fullname = fullnameController.text;
    final String username = usernameController.text;
    final String email = emailrController.text;
    final String password = passwordrController.text;

    final url = Uri.parse('http://192.168.1.7/kamusDb/register.php');

    try {
      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
          'email': email,
          'fullname': fullname,
        },
      );

      RegisterResponse data = registerResponseFromJson(response.body);

      if (data.value == 1) {
        // Data berhasil terkirim
        // Tambahkan logika sesuai kebutuhan Anda, misalnya pindah ke halaman lain
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        });
      } else {
        // Gagal mengirim data
        // Tambahkan logika penanganan kesalahan, misalnya menampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data.message)),
        );
      }
    } catch (e) {
      // Penanganan kesalahan jaringan
      // Misalnya, tampilkan pesan kesalahan atau coba lagi
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
                  'Silahkan Daftar!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                TextFormGlobal(
                  controller: fullnameController,
                  text: 'Fullname',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                TextFormGlobal(
                  controller: usernameController,
                  text: 'Username',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                TextFormGlobal(
                  controller: emailrController,
                  text: 'email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                TextFormGlobal(
                  controller: passwordrController,
                  text: 'Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => registerUser(),
                  child: Text('Daftar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
