import 'package:flutter/material.dart';

List<Container> _buildGridTileList(int count) {

  return List<Container>.generate(
    count,
    (int index) =>
    Container(
    child: Column(
      children: <Widget>[
        Container(
          child: new Container(
            width: 70.0,
            height: 70.0,
          ),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(50.0),
          color: Colors.transparent,
          image: new DecorationImage(
            image: new NetworkImage(
              'https://vignette.wikia.nocookie.net/doblaje/images/6/68/Bohemianposter2.jpg/revision/latest?cb=20180825200535&path-prefix=es'),
            fit: BoxFit.cover),
          boxShadow: [
            new BoxShadow(
              color: Colors.black54,
              blurRadius: 6.0,
              offset: new Offset(2.0, 5.0))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 1.0),
          child: new Text(
            'Bienestar universitario',
            style: new TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontFamily: 'Arvo'
            ),
            textAlign: TextAlign.center,
          ),
      )
    ],
  ),
  ),
  );
}

Widget buildGrid() {
  return GridView.extent(
      maxCrossAxisExtent: 150.0,
      padding: const EdgeInsets.all(10.0),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 10.0,
      children: _buildGridTileList(23));
}

class Grid extends StatefulWidget{
  @override
  _MenuState createState() => new _MenuState();
}

class _MenuState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid"),
      ),
      body: Center(
        child: buildGrid(),
      ),
    );
  }
}