// src/CustomAppBar.dart
import 'package:flutter/material.dart';
import 'package:doutorconsumidor/src/direitos_de_uso_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Recebe o título
  final String selectedEspecialista; // Recebe o nome do especialista

  CustomAppBar({required this.title, required this.selectedEspecialista});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(Icons.chat),
          SizedBox(width: 8),
          // Usa o nome do especialista fornecido
          Text('$title - $selectedEspecialista'),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DireitosDeUsoScreen(),
              ),
            );
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF009639), Color(0xFFFFDF00)], // Cores do degradê (verde e amarelo)
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
