import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Certifique-se de que o caminho para CustomAppBar.dart está correto
import 'CustomAppBar.dart';

void main() {
  runApp(MyChatApp());
}

class MyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doutor consumidor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(especialista: 'João Silva'),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String especialista;

  ChatScreen({required this.especialista});

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isSending = false;
  bool _apiCallFailed = false;

  @override
  void initState() {
    super.initState();
    final welcomeMessage = 'Bem-vindo(a) ao chat com Doutor ${widget.especialista}.\n\nQual o seu nome?';
    _addMessage('Doutor ${widget.especialista}', welcomeMessage);
  }

  void _handleSubmitted(String text) async {
    final formattedText = text.replaceAll('\n', ' '); // Substituir quebra de linha por espaço
    _textController.clear();

    setState(() {
      _isSending = true;
      _apiCallFailed = false;
    });

    _addMessage('Você', formattedText);

    final response = await sendMessageToOpenAI(formattedText);

    if (response == null) {
      // A chamada da API falhou
      setState(() {
        _apiCallFailed = true;
      });
    } else {
      _addMessage('Doutor ${widget.especialista}', response);
    }

    setState(() {
      _isSending = false;
    });
  }

  Future<String?> sendMessageToOpenAI(String text) async {
    final apiKey = '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';
    final endpoint = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'Accept-Charset': 'utf-8',
      },
      body: json.encode({
        'model': 'gpt-4',
        'messages': [
          {'role': 'system', 'content': 'Você é um advogado especialista em ${widget.especialista}'},
          {'role': 'user', 'content': text},
          {'role': 'assistant', 'content': 'Responda apenas sobre direitos do consumidor'},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)); // Decodifica a resposta usando utf-8
      return responseData['choices'][0]['message']['content'];
    } else {
      // A chamada da API falhou
      print('API Call Failed with Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return null; // Retornar null em caso de falha na chamada da API
    }
  }

  void _addMessage(String sender, String text) {
    setState(() {
      _messages.insert(0, {'sender': sender, 'text': text}); // Inverte a ordem
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Doutor', selectedEspecialista: widget.especialista,), // Usando CustomAppBar
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _buildMessage(_messages[index]),
              reverse: true, // Inverte a ordem das mensagens
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              children: <Widget>[
                if (_isSending)
                  LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                if (_apiCallFailed)
                  Text(
                    'A chamada da API falhou. Deseja tentar novamente?',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                _buildTextComposer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, String?> message) {
    final sender = message['sender'] ?? 'Remetente desconhecido';
    final text = message['text'] ?? 'Texto não disponível';
    final isUserMessage = sender == 'Você';

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              maxLines: null, // Permite várias linhas
              onSubmitted: (_) => _handleSubmitted(_textController.text),
              decoration: InputDecoration.collapsed(hintText: 'Enviar uma mensagem'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}
