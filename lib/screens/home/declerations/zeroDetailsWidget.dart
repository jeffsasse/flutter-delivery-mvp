import 'package:flutter/material.dart';
import 'package:tobbund/model/declaration.dart';

class ZeroDetailsWidget extends StatelessWidget {
  final Declaration declaration;
  final String trnNum;
  ZeroDetailsWidget({this.declaration, this.trnNum});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            _detailsItemWidget(context, name: "Kayıt Numarası / TRN Numarası", value: "${declaration.id} / ${trnNum??"--"}", image:"assets/images/1.PNG"),
            _detailsItemWidget(context, name: "Firma", value: "${declaration.firmaAd}", image:"assets/images/2.PNG"),
            _detailsItemWidget(context, name: "Taşıyıcı", value: "${declaration.tasiyici}", image:"assets/images/3.PNG"),
            _detailsItemWidget(context, name: "LRN / MRN", value: "${declaration.mrn??""}", image:"assets/images/4.PNG"),
            _detailsItemWidget(context, name: "Arac Bilgileri", value: "Çekici : ${declaration.plaka} / Treyler : ${declaration.plaka2}", image:"assets/images/5.PNG"),
            _detailsItemWidget(context, name: "Tarih", value: "${declaration.duzenliTarih}", image:"assets/images/6.PNG"),
            _detailsItemWidget(context, name: "Taşıma Modu", value: "${declaration.tasimaMod}", image:"assets/images/icon4-tmode.png"),
            _detailsItemWidget(context, name: "Beyan Türü", value: "${declaration.rejimKodu}", image:"assets/images/9.PNG"),
            //_detailsItemWidget(context, name: "Beyan Sayısı", value: "${declaration.ensStatu}", image:"assets/images/9.PNG"),
            _detailsItemWidget(context, name: "Beyan Sayısı", value: "", image:"assets/images/9.PNG"),
            _detailsItemWidget(context, name: "Toplam Teminat", value: "", image:"assets/images/9.PNG"),
            _detailsItemWidget(context, name: "Fiyat", value: "", image:"assets/images/9.PNG"),
            _detailsItemWidget(context, name: "Konteyner No", value: "${declaration.konteynerNo}", image:"assets/images/icon8-container.png"),
            _detailsItemWidget(context, name: "Toplam Kap", value: "", image:"assets/images/icon8-container.png"),
            _detailsItemWidget(context, name: "Toplam kg", value: "", image:"assets/images/icon8-container.png"),
            _detailsItemWidget(context, name: "Sefer Bilgisi", value: "", image:"assets/images/icon5-expedition.png"),
          ],
        ),
      ),
    );
  }

  Widget _detailsItemWidget(BuildContext context, {@required String name, String value, String image}){
    if(name == "Sefer Bilgisi")
      return Container(
        margin: EdgeInsets.only(top: 7, left: 10, right: 10),
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                )
            )
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(image, width: 30,),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name, style: TextStyle(
                      fontSize: 12,
                        color: Colors.grey[700]
                    ),),
                  ],
                ),
              ],
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Table(
                    border: TableBorder.all(
                      color: Colors.black26, width: 1,),
                    children: [
                      TableRow( children: [
                        Column(children:[
                          Text('Gemi Adt', style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),)
                        ]),
                        Column(children:[
                          Text('Kalkis Tarl', style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),)
                        ]),
                        Column(children:[
                          Text('Kalkis Yeri', style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),)
                        ]),
                        Column(children:[
                          Text('Varis Tarihi', style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),)
                        ]),
                        Column(children:[
                          Text('Vans Yeri', style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),)
                        ]),
                      ]),
                      TableRow( children: [
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 5),
                          child: Center(
                            child: Text("Troy Seaways", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
                          ),),

                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 5),child:Center(
                          child: Text("16.06.2020", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
                        ),),
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 5),child:Center(
                          child: Text("GPA", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
                        ),),
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 5),child:Center(
                          child: Text("17.06.2020", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
                        ),),
                        Container(
                            padding: EdgeInsets.only(top: 8, bottom: 5),child:Center(
                          child: Text("PEN", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
                        )),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      );
    return Container(
      margin: EdgeInsets.only(top: 7
          , left: 10, right: 10),
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.7
              )
          )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(image, width: 30,),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name, style: TextStyle(
                fontSize: 12,
                  color: Colors.grey[700]
              ),),
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width-70,
                child: Text(value, style: TextStyle(
                    fontSize: 14
                ),),
              ),
            ],
          )
        ],
      ),
    );
  }
}
