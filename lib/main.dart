import 'package:flutter/material.dart';
import 'package:juego_adivina_numero/screens/video_juego.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADIVINAR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 77, 113, 234)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const VideoJuego(title: 'ADIVINAR NUMERO'),
    );
  }
}

