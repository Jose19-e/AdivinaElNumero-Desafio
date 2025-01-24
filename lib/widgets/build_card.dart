import 'package:flutter/material.dart';

Widget buildCard(String title, List<int> numbers, {bool? estado}) {
  final ScrollController _scrollController = ScrollController();

  // Desplazarse al final cuando se construye el widget
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  });

  return Expanded(
    child: Container(
      height: 100,
      child: SingleChildScrollView(
        controller: _scrollController, 
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
            color: Colors.black87,
          ),
          child: Column(
            children: [
              Column(
                children: numbers.map((number) {
                  return Text(
                    number.toString(),
                    style: TextStyle(
                      color: estado == true 
                          ? Colors.green  // Si es true, color verde
                          : estado == false 
                              ? Colors.red  // Si es false, color rojo
                              : Colors.white,  // Si es null, color blanco
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
