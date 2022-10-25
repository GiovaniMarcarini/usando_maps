import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapasPage extends StatefulWidget{
  final double latitude;
  final double longetude;

  const MapasPage({ Key? key, required this.latitude, required this.longetude}) : super(key:key);

  _MapasPageState createState() => _MapasPageState();
}

class _MapasPageState extends State<MapasPage>{
  final _controller = Completer<GoogleMapController>();
  StreamSubscription<Position>? _subscription;

  @override
  void initState(){
    super.initState();
    _monitorarLocalixacao();
  }
  void dispose(){
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa Interno'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longetude),
              zoom: 15,
        ),
        onMapCreated: (GoogleMapController controler){
          _controller.complete(controler);
        },
        myLocationEnabled: true,
      ),
    );
  }

  void _monitorarLocalixacao() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
      timeLimit: Duration(seconds: 1),
    );
    _subscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
            (Position position) async {
              final controller = await _controller.future;
              final zoom = await controller.getZoomLevel();
              controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(
                    position.latitude, position.longitude),
                zoom: zoom,
                  )));
              });
  }
}