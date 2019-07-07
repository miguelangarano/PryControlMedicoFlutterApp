import 'package:flutter/material.dart';
import '../entites/paciente.dart';

class PacienteCard extends StatelessWidget {

  PacienteCard(this.listaPacientes, this.index);

  List<Paciente> listaPacientes;
  int index;

  MediaQueryData _queryData;

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
    return Container(
      width: widthToPercent(90),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(239, 239, 239, 1),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: new Offset(0.0, 3.0),
                blurRadius: 10
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(listaPacientes[index].cedula, style: TextStyle(fontSize: 30, color: Colors.black),),
              Icon(Icons.face, color: Color.fromRGBO(0, 164, 174, 1), size: 50,)
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20),),
          Text(listaPacientes[index].nombres, style: TextStyle(fontSize: 25, color: Colors.black),),
          Text(listaPacientes[index].apellidos, style: TextStyle(fontSize: 25, color: Colors.black),),
        ],
      ),
    );
  }
}
