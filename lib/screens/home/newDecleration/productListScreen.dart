import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/model/declaration.dart';
import 'package:tobbund/model/products.dart';
import 'package:tobbund/screens/bottombar.dart';
import 'package:tobbund/screens/home/newDecleration/AddProductScreen.dart';
import 'package:tobbund/widgets/dialog.dart';


class ProductListScreen extends StatefulWidget {
  String trnNumber;
  Declaration declaration;
  ProductListScreen({this.declaration, this.trnNumber});
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  bool _isAdded = false;

  final _titleStyle = TextStyle(color: Colors.grey);

  final _bodyStyle = TextStyle(color: Colors.black);

  Widget _itemWidget(Products _products, int number) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Card(
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "G.Tip",
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            _products.gtipNokta,
                            style: _bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Kalem No:",
                              style: _titleStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              number.toString(),
                              style: _bodyStyle,
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Parçalı:",
                              style: _titleStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              _products.parcali,
                              style: _bodyStyle,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Ticari Tanım",
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            _products.tanim,
                            style: _bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Kap Tipi",
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            _products.kapTipi ?? "",
                            style: _bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Kap Adet",
                            style: _titleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _products.kapAdet.toString() ?? "",
                            style: _bodyStyle,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Brüt kg",
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            _products.brut.toString(),
                            style: _bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Net kg",
                            style: _titleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _products.net.toString(),
                            style: _bodyStyle,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tutar",
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            _products.tutar.toString(),
                            style: _bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Döviz",
                            style: _titleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _products.doviz,
                            style: _bodyStyle,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child:Scaffold(
      appBar:  AppBar(
        backgroundColor: Color(0xFF187EA0),
        title: Text("${widget.declaration.id} / ${widget.trnNumber} / Kalem", style: TextStyle(fontSize: 16),
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    color: Colors.grey[200],
                    height: 40,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Container(
                          alignment: Alignment.center,
                          child: Text("Beyan", style: TextStyle(color: Colors.grey[800]),),
                        )),
                        Expanded(child: Container(
                          color: Color(0xFF0B40A2),
                          alignment: Alignment.center,
                          child: Text("Kalem", style: TextStyle(color: Colors.white),),
                        )),
                      ],
                    )),
                Divider(
                  color: Colors.grey[700],
                ),
                Container(
                    height: MediaQuery.of(context).size.height -
                        (Platform.isIOS ? 234 : 204),
                    child: FutureBuilder<List<Products>>(
                        future: _getData(), // a previously-obtained Future<String> or null
                        builder: (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            if(snapshot.data.isEmpty){
                              return Center(child: Container(
                                  padding: EdgeInsets.all(20),
                                  child:  Material(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Container(
                                      height: 200,
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.info_outline, color: Colors.blue, size: 45,),
                                          SizedBox(height: 10,),
                                          Container(
                                            child: Text("Bilgi", style: TextStyle(color: Colors.grey, fontSize: 14),),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            width: double.infinity,
                                            child: Text('Bu pozisyon içerisinde kalem yoktur.\nSağ alttaki \"artı\" butonundan kalem ekleyebilirsiniz.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              );
                            }else{
                              children = List.generate(snapshot.data.length, (i) {
                                return _itemWidget(snapshot.data[i], i + 1);
                              });
                            }
                          } else if (snapshot.hasError) {
                            children = <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text('Error: ${snapshot.error}'),
                              )
                            ];
                          } else {
                            children = <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                child: CircularProgressIndicator(),
                                width: 30,
                                height: 30,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Sonuç bekleniyor..'),
                              )
                            ];
                          }
                          return SingleChildScrollView(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: children,
                          ),);
                        },
                      ),
                    
                ),
              ],
            ),
          )
      ),
      bottomNavigationBar: BottomBarWidget(
        pageIndex: 1,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isAdded?Colors.blue[200]:Color(0xFF007DB9),
        onPressed: ()async{
          if(_isAdded)return;

          int result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductScreen(declaration: widget.declaration, trnNumber: widget.trnNumber,)));
          
          if(result == 1){
            _isAdded = true;
            setState(() {
              
            });
            Dialogs.showLoadingDialog(context,
              key: _keyLoader,
              barrierDismissible: false,
              title: "Başarılı!",
              description: "Kalem oluşturuldu.",
              icon: "success",
            );
            await Future.delayed(Duration(seconds: 2));
            Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
          }else{
            Dialogs.showLoadingDialog(context,
              key: _keyLoader,
              barrierDismissible: true,
              title: "Hata!",
              description: "Kalem oluşturulamadı.",
              icon: "failed",
            );
            await Future.delayed(Duration(seconds: 2));
            Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
          }


        },
        child: Icon(Icons.add),
      ),
    ), onWillPop: ()async{
      if(!await Dialogs.confirmDialog(context, "Bilgiler kaydedilmedi. Çıkmak istediğinize emin misiniz?"))return false;
      return true;
    });
  }

  Future<List<Products>> _getData() async {
    List<Products> _products = [];
    const String endpoint = "GetProducts";

    var params = {
      "trnNumber": widget.trnNumber,
      "sirketId": widget.declaration.sirketId,
    };
    var response = await ApiHelper().doListPostRequest(endpoint, params);
    print(response);
    for (var item in response) {
      _products.add(Products.fromJson(item));
    }
    print(_products.length);
    return _products;
  }
}
