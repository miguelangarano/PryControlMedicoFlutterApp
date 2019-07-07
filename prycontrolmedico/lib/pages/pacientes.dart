import 'package:flutter/material.dart';
import '../entites/paciente.dart';
import '../components/paciente_card.dart';
import '../components/empty_item.dart';

class Pacientes extends StatefulWidget {

  @override
  _Pacientes createState() => _Pacientes();
}

class _Pacientes extends State<Pacientes> {

  MediaQueryData _queryData;
  List<Paciente> listaPacientes = new List();


  @override
  void initState() {
    Paciente paciente = new Paciente(0, "Miguel Eduardo", "Langarano Guerrero", "0504138934");
    listaPacientes.add(paciente);
    listaPacientes.add(paciente);
    listaPacientes.add(paciente);
    listaPacientes.add(paciente);
    listaPacientes.add(paciente);
    listaPacientes.add(paciente);
    listaPacientes.add(paciente);
    listaPacientes.add(paciente);
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
                Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      childAspectRatio: (1 / 0.45),
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 10,
                      crossAxisCount: 1,
                      children: List.generate(listaPacientes.length, (index) {
                        if(index<=listaPacientes.length){
                          return PacienteCard(listaPacientes, index);
                        }else{
                          return EmptyItem();
                        }
                      }),
                    )
                ),
              ],
            ),
          )
      )
    );
  }
}
