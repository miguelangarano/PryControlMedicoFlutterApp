import 'package:flutter/material.dart';
import 'dart:convert';
import '../entites/paciente.dart';
import '../components/paciente_card.dart';
import '../components/empty_item.dart';
import 'package:http/http.dart' as http;

class Pacientes extends StatefulWidget {

  @override
  _Pacientes createState() => _Pacientes();
}

class _Pacientes extends State<Pacientes> {

  MediaQueryData _queryData;
  List<Paciente> listaPacientes = new List();
  final String url="http://192.168.43.164:8080";
  bool loaded = false;

  Future<List<Paciente>> getPacientes() async{
    String localurl = "http://192.168.43.164:8080/api/paciente/activos";
    final response=await http.get(localurl);
    print(response.body);
    List responseJson=json.decode(response.body.toString());
    List<Paciente> pacientesList=createPacientesList(responseJson);
    return pacientesList;
  }

  List<Paciente> createPacientesList(List data){
    List<Paciente> lista=new List();
    for(int i=0;i<data.length;i++){
      int id=data[i]["idpersona"];
      String nombres=data[i]["nombre"];
      String apellidos=data[i]["apellido"];
      String cedula=data[i]["cedula"];
      Paciente p = new Paciente(id, nombres, apellidos, cedula);
      print("fjnssjd: "+cedula);
      lista.add(p);
    }
    return lista;
  }


  @override
  void initState() {
    getPacientes().then((val){
      setState(() {
        listaPacientes = val;
        loaded = true;
      });
    });
  }

  double widthToPercent(double value) {
    double ret = (value * _queryData.size.width) / 100;
    return ret;
  }

  double heightToPercent(double value) {
    double ret = (value * _queryData.size.height) / 100;
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    _queryData = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
          child: Container(
            color: Color.fromRGBO(0, 164, 174, 1),
            child: Column(
              children: <Widget>[
                Text("Lista de Pacientes", style: TextStyle(fontSize: 30, color: Colors.white),),
                OptionWidget()
              ],
            ),
          )
      )
    );
  }

  Widget OptionWidget(){
    if(loaded){
      return Expanded(
          child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: (1 / 0.45),
            crossAxisSpacing: 0,
            mainAxisSpacing: 10,
            crossAxisCount: 1,
            children: List.generate(listaPacientes.length, (index) {
              if(index<=listaPacientes.length){
                return PacienteCard(listaPacientes, index, url);
              }else{
                return EmptyItem();
              }
            }),
          )
      );
    }else{
      return Container(
        width: widthToPercent(100),
        margin: EdgeInsets.only(top: 50),
        child: Center(
          child: Text("No hay Datos.", style: TextStyle(fontSize: 20, color: Colors.white),),
        )
      );
    }
  }
}
