import 'package:flutter/material.dart';


Widget buildCard(String title, List<int> numbers, {bool? estado}) {   // el tercer parametro es opcional :)
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        color: Colors.black87,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
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
  );
}

