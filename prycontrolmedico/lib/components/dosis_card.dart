import 'package:flutter/material.dart';
import 'package:prycontrolmedico/entites/dosis.dart';

class DosisCard extends StatelessWidget {

  DosisCard(this.listaDosis, this.index);

  List<Dosis> listaDosis;
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
              
              Text(listaDosis[index].id.toString(), style: TextStyle(fontSize: 15, color: Colors.black),),
              Text(listaDosis[index].fechaHora, style: TextStyle(fontSize: 20, color: Colors.black),),

              Icon(Icons.remove_red_eye, color:getColor(listaDosis[index].descripcionestado), size: 20,)
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10),),
          Text(listaDosis[index].descripcion, style: TextStyle(fontSize: 25, color: Colors.black),),
          Text(listaDosis[index].descripcionestadoDosis, style: TextStyle(fontSize: 25, color: Colors.black),),
          Padding(padding: EdgeInsets.only(top: 10),),
        ],
      ),
    );
  }

  Color getColor(int i){
    if(i==0){
      return Colors.yellow;
    }
    if(i==1){
      return Colors.green;
    }
    if(i==2){
      return Colors.red;
    }
    return Colors.white;
  }
}