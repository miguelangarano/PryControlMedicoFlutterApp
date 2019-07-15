import 'package:flutter/material.dart';
import '../entites/medicamento.dart';
import '../pages/scale_route.dart';
import '../pages/dosis.dart';


class MedicamentoCard extends StatelessWidget {

  MedicamentoCard(this.listaMedicamentos, this.index, this.url);

  List<Medicamento> listaMedicamentos;
  int index;
  String url;

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
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            ScaleRoute(page: DosisPage(listaMedicamentos[index].id, url))
        );
      },
      child: Container(
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
                Text(listaMedicamentos[index].nombreComercial, style: TextStyle(fontSize: 30, color: Colors.black),),
                Icon(Icons.healing, color: Color.fromRGBO(0, 164, 174, 1), size: 50,)
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20),),
            Text(listaMedicamentos[index].componenteActivo, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 25, color: Colors.black),),
            Text(listaMedicamentos[index].concentracion, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 25, color: Colors.black),),
          ],
        ),
      ),
    );
  }
}
