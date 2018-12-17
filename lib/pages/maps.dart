import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Maps extends StatefulWidget{
  @override
  _MapsState createState() => new _MapsState();
}
class _MapsState extends State<Maps>{
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('mapa'),
        ),
      body: new FlutterMap(
        options: MapOptions(
          center: LatLng(1.232301, -77.293027),
          minZoom: 10.0,
        ),
        layers:[
          new TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a','b','c'],
          ),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 45.0,
                height: 45.0,
                point: LatLng(1.232301, -77.293027),
                builder: (context)=> new Container(
                  child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.deepPurpleAccent,
                      iconSize: 45.0,
                      tooltip: ('udenar'),
                      onPressed: (){
                        print('Univercidad de Nariño');
                      }
                  ),
                )
              )
            ]
          )
        ]
      ),
    );
  }
}