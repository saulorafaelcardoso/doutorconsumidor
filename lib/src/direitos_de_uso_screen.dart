// src/direitos_de_uso_screen.dart

import 'package:flutter/material.dart';

class DireitosDeUsoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Direitos de Uso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aviso:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Todas as respostas fornecidas por este aplicativo são geradas por uma inteligência artificial da OpenAI (Chat GPT). Este aplicativo tem o objetivo de auxiliar os consumidores em questões de direitos do consumidor, mas não substitui o aconselhamento legal de um advogado. Certifique-se de buscar orientação legal adequada quando necessário.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
