import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prycontrolmedico/components/dosis_card.dart';
import 'package:prycontrolmedico/entites/dosis.dart';
import '../components/empty_item.dart';

class DosisPage extends StatefulWidget {

  DosisPage(this.id, this.url);
  int id;
  String url;
  @override
  ListPageState createState()=> new ListPageState();
}
class ListPageState extends State<DosisPage>{
  MediaQueryData _queryData;
  bool loaded = false;
  List<Dosis> listaDosis=new List();
  Future<List<Dosis>> getDosis() async{
    final String localurl="http://192.168.43.164:8080/api/dosisxdetalle/"+widget.id.toString();
    final response=await http.get(localurl);
    print(response.body);
    List responseJson=json.decode(response.body.toString());
    List<Dosis> dosisList=createDosisList(responseJson);
    return dosisList;
  }

  @override
  void initState() {
    getDosis().then((value){
      setState((){
        listaDosis = value;
        loaded = true;
      });
    });
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
      list.add(d);

    }
    return list;
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
              Text("Lista de Dosis",style: TextStyle(fontSize: 30,color: Colors.white),),
              OptionWidget()
            ],
          ),
        ),
      ),
    );
  }


  Widget OptionWidget(){
    if(loaded){
      return Expanded(
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