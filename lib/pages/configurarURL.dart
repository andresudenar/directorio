import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:directorio/pages/home.dart';

import 'home.dart';

String direccion;

Future<bool> SaveURLPreference(String url) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("url", url);
  return prefs.commit();
}

Future<String> GetURLPreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  direccion = prefs.getString("url") ?? 0;
  return(direccion);
}

class ConfigurarUrl extends StatefulWidget{
  @override
  _ConfigurarUrlState createState() => new _ConfigurarUrlState();
}

class _ConfigurarUrlState extends State<ConfigurarUrl>{
  var _controler = new TextEditingController();
  Color mainColor = const Color(0xffc5cae9);

  void SaveURL(){
    String url = _controler.text;
    SaveURLPreference(url);
    Navigator.pop(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child:
            new SingleChildScrollView(
              child: new Container(
                margin: const EdgeInsets.all(20.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(
                      Icons.cloud_circle,
                      color: Colors.black54,
                      size: 150.0,
                    ),
                    new Text(
                        "!Bienvenid@!",
                        style: new TextStyle(
                          fontSize: 40.0,
                          color: Colors.black54
                        )
                    ),
                    new Text(
                      "Para comenzar conectate a el servidor \n",
                      style: new TextStyle(
                        color: Colors.black
                      ),
                    ),
                    new TextField(
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Ingresa la url aquí",
                        labelText: 'Enter your username',
                      ),
                      controller: _controler,
                    ),
                    new Text(""),
                    new RaisedButton(
                      child: const Text('Conectar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arvo'
                        ),
                      ),
                      elevation: 4.0,
                      splashColor: Colors.redAccent,
                      onPressed: () {
                        // Perform some action
                        SaveURL();
                      },
                    )
                  ],
                ),
              ),
            ),
      )
    );
  }
}