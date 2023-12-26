import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'src/CustomAppBar.dart'; // Certifique-se de que o caminho esteja correto
import 'src/chat.dart'; // Certifique-se de que o caminho esteja correto
import 'src/splash_screen.dart'; // Certifique-se de que o caminho esteja correto

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primaryColor: Color(0xFF007ACC),
        appBarTheme: AppBarTheme(
          color: Colors.yellow,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF007ACC),
            elevation: 2,
            textStyle: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ),
      home: SplashScreen(), // SplashScreen como a primeira tela
    );
  }
}

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
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Carregando...',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> especialistas = [
    "Aviação",
    "Bancos",
    "Eletroeletrônicos",
    "Eletrodomêsticos",
    "Plano de saúde"
  ];
  String selectedEspecialista = "Aviação";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Doutor',
        selectedEspecialista: selectedEspecialista,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Escolha uma das opções para ',
                  ),
                  TextSpan(
                    text: 'tirar dúvidas sobre direitos do consumidor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Ação ao tocar no texto
                      },
                  ),
                  TextSpan(
                    text: '. ',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedEspecialista,
              onChanged: (String? newValue) {
                setState(() {
                  selectedEspecialista = newValue!;
                });
              },
              items: especialistas.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatScreen(especialista: selectedEspecialista),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF009639), // Cor do botão
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chat_bubble, size: 24, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Iniciar Chat',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Certifique-se de que os arquivos CustomAppBar.dart, chat.dart e splash_screen.dart estão presentes e corretos no diretório 'src'.
