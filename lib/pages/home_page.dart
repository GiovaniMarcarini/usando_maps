import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  _HomePageState createState()=> _HomePageState();

}

class _HomePageState extends State<HomePage>{
  Position? _localizacaoAtual;
  final _controller = TextEditingController();

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Textando Mapas'),
      ),
      body: _criarBody(),
    );
  }
}