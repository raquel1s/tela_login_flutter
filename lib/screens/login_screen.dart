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
  bool _senhaVisivel = false;

  final usuario = "alunosenai";
  final senha = "12345678";

  late final encrypt.Key aesKey;
  late final encrypt.IV iv;
  late final encrypt.Encrypter encrypter;
  late final encrypt.Encrypted encrypted;
  late final String senhaCriptografada;

  String resultadoSenha = "";
  String resultadoUsuario = "";

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
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 7),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  resultadoUsuario,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _senhaController,
                obscureText: !_senhaVisivel,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _senhaVisivel = !_senhaVisivel; // Toggle
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 7),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  resultadoSenha,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _autenticarSenha,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Entrar', 
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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

    String respostaSenha =
        (senhaDigitada == senhaDescriptografada)
            ? ""
            : "Senha Incorreta";

    String respostaUsuario = (usuarioDigitado == usuario)
      ? ""
      : "Usuário Incorreto";

    setState(() {
      resultadoSenha = respostaSenha;
      resultadoUsuario = respostaUsuario;
    });
  }
}
