import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:directorio/pages/grid.dart';
import 'package:directorio/pages/maps.dart';
import 'package:directorio/pages/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:directorio/pages/Login/index.dart';
import 'configurarURL.dart';
import 'menuLista.dart';



String url = '';


Future<String> GetURLPreferences() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  url = prefs.getString("url") ?? 0;
  return(url);
}

ValueNotifier<Client> client = ValueNotifier (
  Client(
    endPoint: 'http://johnmariogb.pythonanywhere.com'+'/graphql',
    cache: InMemoryCache(),
  ),
);

class Home extends StatefulWidget{
  @override
  _HomeState createState() => new _HomeState();
}



class _HomeState extends State<Home>{
  Color mainColor = const Color(0xff3C3261);
  var point = GetURLPreferences();
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Uni-Foss",
            style: TextStyle(
                fontFamily: "Sacramento",
              fontSize: 27,
              //fontWeight: FontWeight.bold
            ),
          ),

        ),
        body: new Center(
            child:
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RaisedButton(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ConfigurarUrl())
                      );
                    },
                  ),
                  //new MovieTitle(mainColor),

                  GraphqlProvider(
                      client: client,
                      child: Query(
                          """
                          query {
                            __type(name:"HomeElements"){
                              fields{
                                name    
                              } 
                            }
                          }                 
                          """,
                          pollInterval: 10,
                          builder: ({bool loading, Map data, Exception error}) {
                            GetURLPreferences();
                            if (error != null) {
                              return Text("Error en la consulta");
                            }
                            if (loading) {
                              return Expanded(
                                  child: Center(
                                      child: Image.asset(
                                        'images/loading4.gif',
                                        height: 70.0,
                                        fit: BoxFit.cover,
                                      )
                                  )
                              );
                            }

                            List elements = data['__type']['fields'];
                            String consulta = '';
                            for(int i=0; i<elements.length; i++){
                              consulta += elements[i]['name']+'{title icon state theme description}';
                            }
                            consulta = 'query {Home{elements{'+consulta+'}}}';
                            return (GraphqlProvider(
                                client: client,
                                child: Query(
                                    consulta,
                                    pollInterval: 10,
                                    builder: ({bool loading, Map data, Exception error}) {
                                      GetURLPreferences();
                                      if (error != null) {
                                        return Text("Error en la consulta");
                                      }
                                      if (loading) {
                                        return Expanded(
                                            child: Center(
                                                child: Image.asset(
                                                  'images/loading4.gif',
                                                  height: 70.0,
                                                  fit: BoxFit.cover,
                                                )
                                            )
                                        );
                                      }

                                      Map menu = data['Home']['elements'];
                                      //return Text(menu[elements[0]['name']]['title'].toString());
                                      //menus[0][title]
                                      return Expanded(
                                          child: new ListView.builder(
                                            itemCount: menu == null ? 0 : menu.length,
                                            itemBuilder: (context, i){
                                              return new FlatButton(
                                                child: MenuLista(menu[elements[i]['name']]['title'].toString(),menu[elements[i]['name']]['description'].toString(),'http://johnmariogb.pythonanywhere.commenus[i]'+menu[elements[i]['name']]['icon'].toString()),
                                                padding: const EdgeInsets.all(0.0),
                                                onPressed: (){
                                                  Navigator.push(context, new MaterialPageRoute(builder: (context){
                                                    if(menu[elements[i]['name']]['theme']== null){
                                                      String abre = 'Home{elements{'+elements[i]['name'];
                                                      String cierra = '';
                                                      return Menu(menu[elements[i]['name']]['title'].toString(),elements[i]['name'].toString());
                                                      return Text('Hola');
                                                    }
                                                    //return Menu();
                                                  }));
                                                },
                                                color: Colors.white,
                                              );
                                            },
                                          )
                                      );
                                    }
                                )
                            ));
                            //menus[0][title]
                          }
                      )
                  ),
                  Text(url),
                ],
              ),
            )
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