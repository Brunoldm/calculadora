import 'package:calculadora/models/memoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/display.dart';
import '../components/teclado.dart';

class Calculadora extends StatefulWidget {

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final Memoria memoria = Memoria();
 
  _onPressed(String command){
    setState(() {
      memoria.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    return MaterialApp(
      home: Column(
        children: <Widget> [
          Display(memoria.value),
          Teclado(_onPressed)
        ],
      )
    );
  }
}