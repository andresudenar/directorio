import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//10.254.200.99:8000

ValueNotifier<Client> client = ValueNotifier(
  Client(
    endPoint: 'http://johnmariogb.pythonanywhere.com/graphql',
    cache: InMemoryCache(),
  ),
);

class Menu2 extends StatefulWidget{
  @override
  _MenuState createState() => new _MenuState();
}

class _MenuState extends State<Menu2>{
  Color mainColor = const Color(0xff3C3261);
  Widget build(BuildContext context){
    return new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new MovieTitle(mainColor),
              new Text('Hola menu'),
              GraphqlProvider(
                  client: client,
                  child: Query(
                      """
                      query{
                        containers(name: "home"){
                          widgets{
                            title
                            description
                          }
                        }
                      }                      
                      """,
                      pollInterval: 10,
                      builder: ({bool loading, Map data, Exception error}) {
                        if (error != null) {
                          return Text("Error en la consulta");
                        }
                        if (loading) {
                          return Text("Loading");
                        }
                        List menus = data['containers'][0]['widgets'];

                        return Text(menus.toString());
                        //menus[0][title]
                      }
                  )
              ),

            ],
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

