import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final usuario = "alunosenai";
  final senha = "12345678";

  late final encrypt.Key aesKey;
  late final encrypt.IV iv;
  late final encrypt.Encrypter encrypter;
  late final encrypt.Encrypted encrypted;
  late final String senhaCriptografada;

  String resultado = "";

  @override
  void initState() {
    super.initState();

    aesKey = encrypt.Key.fromUtf8('1234567890123456');
    iv = encrypt.IV.fromLength(16);
    encrypter = encrypt.Encrypter(encrypt.AES(aesKey));
    encrypted = encrypter.encrypt(senha, iv: iv);
    senhaCriptografada = encrypted.base64;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Senai'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usuarioController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _autenticarSenha,
                  child: Text('Enviar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              resultado,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: resultado == "Acesso aceito" ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _autenticarSenha() async {
    String senhaDigitada = _senhaController.text;
    String usuarioDigitado = _usuarioController.text;

    final senhaDescriptografada = encrypter.decrypt64(
      senhaCriptografada,
      iv: iv,
    );

    String resposta =
        (senhaDigitada == senhaDescriptografada && usuarioDigitado == usuario)
            ? "Acesso aceito"
            : "Acesso Negado";

    setState(() {
      resultado = resposta;
    });
  }
}
