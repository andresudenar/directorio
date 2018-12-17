import 'package:flutter/material.dart';
import 'pages/directorio.dart';
import 'pages/menu.dart';
import 'pages/grid.dart';
import 'pages/home.dart';
import 'pages/maps.dart';
import 'pages/configurarURL.dart';
import 'pages/splashScreen.dart';
import 'pages/pruebas.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'UNI-FOSS',
      initialRoute: '/pruebas',
      routes: {
        // Cuando naveguemos hacia la ruta "/", crearemos el Widget FirstScreen
        '/': (context) => Home(),
        // Cuando naveguemos hacia la ruta "/second", crearemos el Widget SecondScreen
        '/second': (context) => ConfigurarUrl(),
        '/maps': (context) => Maps(),
        '/splashScreen': (context) => SplashScreen(),
        '/pruebas': (context) => Pruebas(),

      },

    );
  }
}


