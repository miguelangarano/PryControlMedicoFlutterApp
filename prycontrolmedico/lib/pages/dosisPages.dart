import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prycontrolmedico/components/dosis_card.dart';
import 'package:prycontrolmedico/entites/dosis.dart';
import '../components/empty_item.dart';

class DosisPage extends StatefulWidget {
  @override
  ListPageState createState()=> new ListPageState();
}
class ListPageState extends State<DosisPage>{
  MediaQueryData _queryData;
  final String url="http://192.168.0.109:8080/api/dosisxdetalle/2";
  List<Dosis> listaDosis=new List();
  Future<List<Dosis>> getDosis() async{
    final response=await http.get(url);
    print(response.body);
    List responseJson=json.decode(response.body.toString());
    List<Dosis> dosisList=createDosisList(responseJson);
    return dosisList;
  }

  @override
  void initState() {
    getDosis() ;
    /*Dosis dosi=new Dosis(1,"1975-04-14T00:00:00","Lunes",0,"Notificado");
    listaDosis.add(dosi);
    listaDosis.add(dosi);
    listaDosis.add(dosi);
    listaDosis.add(dosi);*/

  }

  List<Dosis> createDosisList(List data){
    List<Dosis> list=new List();
    for(int i=0;i<data.length;i++){
      int id=data[i]["iddosis"];
      int estado=data[i]["estado"];
      String fecha=data[i]["fechaHora"];
      String descripcion=data[i]["descripcion"];
      String descripcionEstado=data[i]["descripcionEstadoDosis"];
      Dosis d=new Dosis(id, fecha, descripcion, estado,descripcionEstado);
      listaDosis.add(d);

    }
    return listaDosis;
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
  Widget build(BuildContext context){
    _queryData=MediaQuery.of(context);
    return Scaffold(

      body: SafeArea(
        child:Container(
          color:Color.fromRGBO(0, 164, 174, 1),
          child: Column(
            children: <Widget>[
              Text("LISTA DE DOSIS",style: TextStyle(fontSize: 30,color: Colors.white),),
              Expanded(
                  child: GridView.count(
                      shrinkWrap: true,
                      childAspectRatio: (1/0.45),
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 10,
                      crossAxisCount: 1,
                      children:List.generate(listaDosis.length, (index){
                          return DosisCard(listaDosis, index);

                      })
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

}

