import 'package:flutter/material.dart';
import 'dart:async';
import 'chat.dart'; // Ajuste este caminho conforme a localização do seu arquivo ChatScreen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ChatScreen(especialista: 'João Silva')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nome do Aplicativo', // Substitua pelo nome real do seu aplicativo
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor, // Usa a cor primária do tema
              ),
            ),
            SizedBox(height: 20), // Espaço entre o texto e a imagem
            Image.asset(
              'assets/img/logo.png', // Certifique-se de que o caminho esteja correto
              width: 100, // Define a largura da imagem
              height: 100, // Define a altura da imagem
            ),
          ],
        ),
      ),
    );
  }
}
