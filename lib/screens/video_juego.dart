import 'dart:math';
import 'package:flutter/material.dart';
import 'package:juego_adivina_numero/widgets/build_card.dart';

class VideoJuego extends StatefulWidget {
  const VideoJuego({super.key, required this.title});
  final String title;

  @override
  State<VideoJuego> createState() => _VideoJuegoState();
}

class _VideoJuegoState extends State<VideoJuego> {
  final TextEditingController _controller = TextEditingController();
  //int _counter = 0;
/* 
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  } */
  int _numeroSecreto = 0;
  int _intentosRestantes = 0;
  int _rangoMaximo = 10;
  String _mensaje = '';
  List<int> _mayorQue = [];
  List<int> _menorQue = [];
  List<int> _historial = [];
  String _dificultad = 'Fácil';
  String estado = 'NoEncontrado';


  @override
  void initState() {
    super.initState();
    _iniciarJuego();
  }

  // Inicializa el juego según la dificultad seleccionada
  void _iniciarJuego() {
    setState(() {
      _numeroSecreto = Random().nextInt(_rangoMaximo) + 1;
      _historial.clear();
      _mayorQue.clear();
      _menorQue.clear();
      _mensaje = '';
      _setIntentosPorDificultad();
    });
  }

  // Configura la dificultad
  void _cambiarDificultad(String nivel) {
    setState(() {
      _dificultad = nivel;
      switch (nivel) {
        case 'Fácil':
          _rangoMaximo = 10;
          _intentosRestantes = 5;
          break;
        case 'Medio':
          _rangoMaximo = 20;
          _intentosRestantes = 8;
          break;
        case 'Avanzado':
          _rangoMaximo = 100;
          _intentosRestantes = 15;
          break;
        case 'Extremo':
          _rangoMaximo = 1000;
          _intentosRestantes = 25;
          break;
      }
      _iniciarJuego();
    });
  }

  // Establece intentos según la dificultad
  void _setIntentosPorDificultad() {
    switch (_dificultad) {
      case 'Fácil':
        _intentosRestantes = 5;
        break;
      case 'Medio':
        _intentosRestantes = 8;
        break;
      case 'Avanzado':
        _intentosRestantes = 15;
        break;
      case 'Extremo':
        _intentosRestantes = 25;
        break;
    }
  }

  // Valida la entrada del usuario
  bool _validarEntrada(String input) {
    final int? numero_escogido = int.tryParse(input);
    if (numero_escogido == null || numero_escogido < 1 || numero_escogido > _rangoMaximo) {
      setState(() {
        _mensaje = 'Ingresa un número válido entre 1 y $_rangoMaximo';
      });
      return false;
    }
    return true;
  }


  // Comprueba el intento del usuario
  void _verificarNumero() {
    final String input = _controller.text;
    if (!_validarEntrada(input)) return;

    final int numero_escogido = int.parse(input);
    setState(() {
      _intentosRestantes--;
      if (numero_escogido > _numeroSecreto) {
        _mensaje = 'El número es menor que $numero_escogido';
        _menorQue.add(numero_escogido);
      } else if (numero_escogido < _numeroSecreto) {
        _mensaje = 'El número es mayor que $numero_escogido';
        _mayorQue.add(numero_escogido);
      } else {
        _mensaje = '¡Correcto! Has adivinado el número $_numeroSecreto';
        estado = 'encontrado';
        _historial.add(numero_escogido);
      }

      if (_intentosRestantes == 0 && numero_escogido != _numeroSecreto) {
        _mensaje = '¡Has perdido! El número era $_numeroSecreto';
        estado = 'NoEncontrado';
        _historial.add(numero_escogido);
      }
    });
    _controller.clear();
  }

  // Reinicia el juego
  void _reiniciarJuego() {
    _iniciarJuego();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text(
                'Adivina un número entre 1 y $_rangoMaximo',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 160,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Ingresa tú número',
                  ),
                ),
              ),
              Text(
                'Intentos restantes: $_intentosRestantes'
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildCard("Mayor que",_mayorQue),
              buildCard("Menor que",_menorQue),
              buildCard("HISTORIAL", _historial, estado: estado == 'encontrado' ? true : false)
            ],
          ),
          SizedBox(height: 30.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: _dificultad,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _cambiarDificultad(newValue);
                  }
                },
                items: ['Fácil', 'Medio', 'Avanzado', 'Extremo'].map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  )
                ).toList(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _mensaje,
                style: TextStyle(
                  fontSize: 18,
                  color: _mensaje.contains('Correcto') ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _verificarNumero,
                child: Text('Adivinar'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _reiniciarJuego,
                child: Text('Reiniciar Juego'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
