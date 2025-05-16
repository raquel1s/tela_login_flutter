import 'package:flutter/material.dart';
import 'package:tela_login/screens/login_screen.dart';

void main() {
  runApp(const TelaLogin());
}

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tela Login',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.comfortable,
      ),
      home: const Login_Screen(),
    );
  }
}