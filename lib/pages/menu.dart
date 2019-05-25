import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'maps.dart';

import 'menuLista.dart';

ValueNotifier<Client> client = ValueNotifier(
  Client(
    endPoint: 'http://johnmariogb.pythonanywhere.com/graphql',
    cache: InMemoryCache(),
  ),
);

class Menu extends StatefulWidget{
  @override
  _MenuState createState() => new _MenuState(titulo,services);
  final String titulo;
  final services;
  Menu(this.titulo,this.services);
}

class _MenuState extends State<Menu>{
  final String titulo;
  final String services;
  _MenuState(this.titulo,this.services);
  Color mainColor = const Color(0xff3C3261);
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(titulo),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new MovieTitle(mainColor),
            Expanded(
              child: new ListView.builder(
                itemCount: services == null ? 0 : services.length,
                itemBuilder: (context, i) {
                  return new FlatButton(
                    /*child: new MenuLista(services[i]['title'].toString(),
                        services[i]['description'].toString(),
                        'http://johnmariogb.pythonanywhere.com'+services[i]['icon'].toString()
                    ),*/
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.push(
                          context, new MaterialPageRoute(builder: (context) {
                            /*if(services[i]['kind'].toString()=='map'){
                              return Maps();
                            }*/

                      }));
                    },
                    color: Colors.white,
                  );
                }
              )
            ),
          ],
        ),
      )
    );
  }
}

class MovieTitle extends StatelessWidget{
  final Color mainColor;

  MovieTitle(this.mainColor);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: new Text(
        'Servicos',
        style: new TextStyle(
            fontSize: 40.0,
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arvo'
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}