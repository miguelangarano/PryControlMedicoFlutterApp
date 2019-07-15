import 'package:flutter/material.dart';
import 'dart:convert';
import '../entites/medicamento.dart';
import '../components/medicamento_card.dart';
import '../components/empty_item.dart';
import 'package:http/http.dart' as http;

class Medicamentos extends StatefulWidget {

  Medicamentos(this.idpaciente, this.url);
  int idpaciente;
  String url;

  @override
  _Medicamentos createState() => _Medicamentos();
}

class _Medicamentos extends State<Medicamentos> {


  MediaQueryData _queryData;
  List<Medicamento> listaMedicamentos = new List();
  bool loaded = false;

  Future<List<Medicamento>> getMedicamentos() async{
    final String localurl="http://192.168.43.164:8080/api/medicamentoxpaciente/"+widget.idpaciente.toString();
    final response=await http.get(localurl);
    print(response.body);
    List responseJson=json.decode(response.body.toString());
    List<Medicamento> medicamentosList=createMedicamentosList(responseJson);
    return medicamentosList;
  }

  List<Medicamento> createMedicamentosList(List data){
    List<Medicamento> lista=new List();
    for(int i=0;i<data.length;i++){
      int id=data[i]["idmedicamento"];
      String nombreComercial=data[i]["nombreComercial"];
      String componenteActivo=data[i]["componenteActivo"];
      String concentracion=data[i]["concentracion"];
      Medicamento m = new Medicamento(id, nombreComercial, componenteActivo, concentracion);
      print("fjnssjd: "+concentracion);
      lista.add(m);

    }
    return lista;
  }


  @override
  void initState() {
    getMedicamentos().then((val){
      setState(() {
        listaMedicamentos = val;
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
                  Text("Lista de Medicamentos", style: TextStyle(fontSize: 30, color: Colors.white),),
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
            children: List.generate(listaMedicamentos.length, (index) {
              if(index<=listaMedicamentos.length){
                return MedicamentoCard(listaMedicamentos, index, widget.url);
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
