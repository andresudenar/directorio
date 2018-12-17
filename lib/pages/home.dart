import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:directorio/pages/grid.dart';
import 'package:directorio/pages/maps.dart';
import 'package:directorio/pages/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          title: new Text("UNI-FOSS"),
        ),
        body: new Center(
          child:
         Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
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
                splashColor: Colors.deepPurpleAccent,
                onPressed: () {
                  // Perform some action
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfigurarUrl())
                  );
                },
              ),
              new MovieTitle(mainColor),

              GraphqlProvider(
                  client: client,
                  child: Query(
                      """
                      query{
                        containers(name: "home"){
                          widgets{
                            title
                            description
                            icon
                            ofType
                            services{
                              title 
                              description
                              icon
                              kind   
                            }
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
                          return Center(
                            child: Image.asset(
                                'images/loading3.gif',
                                height: 150.0,
                                fit: BoxFit.cover,
                            )
                          );
                        }
                        List menus = data['containers'][0]['widgets'];
                        //return Text(menus.toString());
                        //menus[0][title]
                        return Expanded(
                            child: new ListView.builder(
                              itemCount: menus == null ? 0 : menus.length,
                              itemBuilder: (context, i){
                                return new FlatButton(
                                  child: MenuLista(menus[i]['title'].toString(),menus[i]['description'].toString(),'http://johnmariogb.pythonanywhere.commenus[i]'+['icon'].toString()),
                                  padding: const EdgeInsets.all(0.0),
                                  onPressed: (){
                                    Navigator.push(context, new MaterialPageRoute(builder: (context){
                                      if(menus[i]['ofType']=='menu'){
                                        List servicios = menus[i]['services'];
                                        return Menu(menus[i]['title'].toString(),servicios);
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