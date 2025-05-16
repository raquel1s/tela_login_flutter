import 'package:flutter/material.dart';
import 'package:tela_login/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String nomeUsuario;

  const HomeScreen({Key? key, required this.nomeUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
           margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Bem-vindo ${nomeUsuario}!",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              ),
               SizedBox(height: 20),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login_Screen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                     child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
              
                    ),
                  )
                ],
               )
            ],
          ),
        ),
      ),
    );


  }
}