import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tobbund/controller/new_declerations_provider.dart';
import 'package:tobbund/model/TRNItem.dart';
import 'package:tobbund/model/declaration.dart';
import 'package:tobbund/model/newdeclaration/countries.dart';
import 'package:tobbund/model/newdeclaration/customs.dart';
import 'package:tobbund/model/newdeclaration/firms.dart';
import 'package:tobbund/screens/bottombar.dart';
import 'package:tobbund/screens/home/newDecleration/productListScreen.dart';
import 'package:tobbund/screens/home/newDecleration/searchDropdownDialog.dart';
import 'package:tobbund/widgets/dialog.dart';

class AddDeclarationScreen extends StatefulWidget {
  final Declaration declaration;
  final TRNItem trnItem;
  AddDeclarationScreen({this.declaration, this.trnItem});
  @override
  _AddDeclarationScreenState createState() => _AddDeclarationScreenState();
}

class _AddDeclarationScreenState extends State<AddDeclarationScreen> {

  NewDeclarationProvider _newDeclarationProvider;
  bool _checkActive = false;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  Widget _hareketWidget() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 0, left: 10, right: 10),
      child: Stack(
        alignment: Alignment(-1.005, -1),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            padding: EdgeInsets.only(top: 20, bottom: 40),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF0B40A2), width: 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: ()async{
                    if(_newDeclarationProvider.trnNumber != null) return;
                    var result = await showDialog(context: context, builder: (context)=>SearchDropdownDialog(
                      endpoint: "GetCustoms",
                      target: "gumrukTamTanim",
                      searchTarget: "searchCustom",
                      params: {
                        "searchCustom":""
                      },
                    ));
                    if(result==null)return;
                    print(result);
                    _newDeclarationProvider.gumruk = Customs.fromJson(result);
                    setState(() {

                    });
                  },
                  child: _ItemWidget('Gümrük *', _newDeclarationProvider.gumruk?.gumrukTamTanim?? ""),
                ),
                Divider(
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: ()async{
                 
                  },
                  child:  _ItemWidget('Ülke *', _newDeclarationProvider.gumruk?.ulkeKodu?? ""),
                ),

                Divider(
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: ()async{
                    if(_newDeclarationProvider.trnNumber != null) return;
                    var result = await showDialog(context: context, builder: (context)=>SearchDropdownDialog(
                        endpoint: "GetFirms",
                        target: "unvan",
                        searchTarget: "searchFirm",
                        params: {
                          //"firmId": 1007,
                          "firmId": _newDeclarationProvider.sekirtId,
                          "searchFirm": ""
                        }
                    ));
                    if(result==null)return;
                    _newDeclarationProvider.gonderici = Firms.fromJson(result);
                    setState(() {

                    });
                  },
                  child: _ItemWidget('Gönderici *', _newDeclarationProvider.gonderici?.unvan ?? ""),
                ),

                Divider(
                  color: Colors.grey,
                ),
                _ItemWidget(
                    'Gönderici Adres *', _newDeclarationProvider.gonderici?.adres?? ""),

                Divider(
                  color: Colors.grey,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Eşyanın Bulunduğu Yer", style: TextStyle(color: Colors.red[800]),),
                      Container(
                        height: 30,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: "",
                            hintStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            padding: EdgeInsets.only(top: 5, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              "Hareket",
              style: TextStyle(
                  color: Color(0xFF0B40A2),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ItemWidget(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.red[800]),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  subtitle,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _varisWidget() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 20, left: 10, right: 10),
      child: Stack(
        alignment: Alignment(-1.005, -1),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            padding: EdgeInsets.only(top: 20, bottom: 40),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF0B40A2), width: 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: ()async{
                    if(_newDeclarationProvider.trnNumber != null) return;
                    var result = await showDialog(context: context, builder: (context)=>SearchDropdownDialog(
                      endpoint: "GetCustoms",
                      target: "gumrukTamTanim",
                      searchTarget: "searchCustom",
                      params: {
                        "searchCustom":""
                      },
                    ));
                    if(result==null)return;
                    print(result);
                    _newDeclarationProvider.varisGumruk = Customs.fromJson(result);
                    setState(() {

                    });
                  },
                  child:_ItemWidget(
                      'Transitin Son. Gümrüğü *', _newDeclarationProvider.varisGumruk?.gumrukTamTanim ?? ""),
                ),

                Divider(
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: ()async{
                   
                  },
                  child: _ItemWidget('Ülke *', _newDeclarationProvider.varisGumruk?.ulkeKodu ?? ""),
                ),

                Divider(
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: ()async{
                    if(_newDeclarationProvider.trnNumber != null) return;
                    var result = await showDialog(context: context, builder: (context)=>SearchDropdownDialog(
                        endpoint: "GetFirms",
                        target: "unvan",
                        searchTarget: "searchFirm",
                        params: {
                          //"firmId": 1007,
                          "firmId" : _newDeclarationProvider.sekirtId,
                          "searchFirm": ""
                        }
                    ));
                    if(result==null)return;
                    _newDeclarationProvider.alci = Firms.fromJson(result);
                    setState(() {

                    });
                  },
                  child:  _ItemWidget('Alıcı *', _newDeclarationProvider.alci?.unvan ?? ""),
                ),

                Divider(
                  color: Colors.grey,
                ),
                _ItemWidget('Alıcı Adres *', _newDeclarationProvider.alci?.adres ?? ""),
              ],
            ),
          ),
          Container(
            width: 100,
            padding: EdgeInsets.only(top: 5, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              "Varış",
              style: TextStyle(
                  color: Color(0xFF0B40A2),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newDeclarationProvider = Provider.of<NewDeclarationProvider>(context,listen: false);
    _newDeclarationProvider.declaration = widget.declaration;
    _newDeclarationProvider.init();
  }

  @override
  Widget build(BuildContext context) {
    _checkActive = _newDeclarationProvider.checkActive();
    return WillPopScope(child: Scaffold(
      backgroundColor: Colors.white,
        appBar:  AppBar(
          backgroundColor: Color(0xFF187EA0),
          title: Text("${widget.declaration.id} / Beyan", style: TextStyle(fontSize: 16),
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
                          color: Color(0xFF0B40A2),
                          alignment: Alignment.center,
                          child: Text("Beyan", style: TextStyle(color: Colors.white),),
                        )),
                        Expanded(child: Container(
                          alignment: Alignment.center,
                          child: Text("Kalem", style: TextStyle(color: Colors.grey[800]),),
                        )),
                      ],
                    )),
                Divider(
                  color: Colors.grey[700],
                ),
                Container(
                    height: MediaQuery.of(context).size.height -
                        (Platform.isIOS ? 234 : 204),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _hareketWidget(),
                            _varisWidget(),
                          ]
                      ),
                    )
                ),
              ],
            ),
          )
        ),
        bottomNavigationBar: BottomBarWidget(
          pageIndex: 1,
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: !_checkActive?Colors.blue.withOpacity(0.5):Color(0xFF007DB9),
        onPressed: ()async{
          if(!_checkActive)return;
          //if(!await Dialogs.confirmDialog(context, "Are you sure?")) return;
          int status = await _newDeclarationProvider.addDeclaration();
          if(status == 2){
            Dialogs.showLoadingDialog(context,
              key: _keyLoader,
              barrierDismissible: false,
              title: "Başarılı!",
              description: "Beyan oluşturuldu.",
              icon: "success",
            );
            await Future.delayed(Duration(seconds: 2));
            Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
            await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductListScreen(
              declaration: _newDeclarationProvider.declaration, trnNumber: _newDeclarationProvider.trnNumber,
            )));
            _newDeclarationProvider.init();
            setState(() {

            });
          }

          if(status == 1){
            Dialogs.showLoadingDialog(context,
              key: _keyLoader,
              barrierDismissible: false,
              title: "Hata!",
              description: "Pozisyon oluşturulamadı.",
              icon: "failed",
            );
            await Future.delayed(Duration(seconds: 2));
            Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
          }

          return;
        },
        child: Icon(Icons.check),
      ),

    ), onWillPop: ()async{
      if(!await Dialogs.confirmDialog(context, "Bilgiler kaydedilmedi. Çıkmak istediğinize emin misiniz?")) return false;
      return true;
    });
  }
}
