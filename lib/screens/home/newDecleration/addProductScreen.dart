import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/controller/new_declerations_provider.dart';
import 'package:tobbund/model/declaration.dart';
import 'package:tobbund/model/newproduct/gtip_model.dart';
import 'package:tobbund/model/products.dart';
import 'package:tobbund/repository/UserRepository.dart';
import 'package:tobbund/screens/bottombar.dart';
import 'package:tobbund/screens/home/newDecleration/searchDropdownDialog.dart';
import 'package:tobbund/widgets/dialog.dart';


class AddProductScreen extends StatefulWidget {
  String trnNumber;
  Declaration declaration;
  AddProductScreen({this.declaration, this.trnNumber});
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final _labelStyle = TextStyle(
    color: Colors.grey,
    fontSize: 12
  );
  final _labelMandatoryStyle = TextStyle(
    color: Colors.red[800],
    fontSize: 12
  );
  final _valueStyle = TextStyle(
    color: Colors.grey[800],
    fontSize: 14,
    fontWeight: FontWeight.w600
  );

  bool _loading = false;
  bool _active = false;
  bool _parcali = true;
  String _gtip;
  String _vergiOrani;
  final _tricariTanimController = TextEditingController();
  String _kapTipi;
  final _kapAdetController = TextEditingController();
  final _brutKgController = TextEditingController();
  final _netKgController = TextEditingController();
  final _tutarController = TextEditingController();
  String _doviz;

  bool _checkActive(){
    if(_gtip == null||
        _tricariTanimController.text == null||
        _kapAdetController.text == ""||
        _brutKgController.text == ""||
        _netKgController.text == ""||
        _tutarController.text == ""||
        _doviz == null
    ){
        
        return false;
    }
    
      
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kapTipi = "BI - Kap";
  }

  @override
  Widget build(BuildContext context) {
    _active = _checkActive();
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color(0xFF187EA0),
        title: Text("${widget.declaration.id} / ${widget.trnNumber} / Kalem", style: TextStyle(fontSize: 16),
        ),
      ),
      body: _loading?
      Container(
        color: Colors.grey[200].withOpacity(0.5),
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      ):
      Container(
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
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Material(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 8,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("G.T.i.P *", style: _labelMandatoryStyle,),
                                                Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text("Vergi Orani: "
                                                            "", style: _labelStyle,),
                                                        Text(_vergiOrani == null?"":"%${_vergiOrani}", style: _valueStyle,)
                                                      ],
                                                    )
                                                )
                                              ],
                                            ),
                                            InkWell(
                                              onTap: ()async{
                                                var result = await showDialog(context: context, builder: (context)=>SearchDropdownDialog(
                                                  endpoint: "GetGtipNo",
                                                  target: "fGtip",
                                                  searchTarget: "gtip",
                                                  params: {"gtip": "vv"},
                                                ));
                                                if(result==null)return;
                                                GtipNo _gtipNo = GtipNo.fromJson(result);
                                                _gtip = _gtipNo.fGtip;
                                                _vergiOrani = _gtipNo.vergiOrani.toString();
                                                _tricariTanimController.text = _gtipNo.tanimTr;
                                                TextField(keyboardType: TextInputType.number,);

                                                setState(() {

                                                });
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                                                  padding: EdgeInsets.all(3),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.grey[600], width: 1)
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(_gtip??"", style: _valueStyle,),
                                                      ),
                                                      Icon(Icons.arrow_drop_down, color: Colors.grey[600],)
                                                    ],
                                                  )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text('Kalem No: 1', style: _labelStyle,)
                                                ],
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Switch(
                                                    value: _parcali,
                                                    onChanged: (val){
                                                      _parcali = val;
                                                      setState(() {

                                                      });
                                                    },
                                                    activeColor: Color(0xFF0B40A2),
                                                  ),
                                                  SizedBox(width: 20,),
                                                  Text('Parcali: ${_parcali?"E":"H"}', style: _labelStyle,)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Ticari Tanim *", style: _labelMandatoryStyle,),
                                      SizedBox(height: 5,),
                                      TextField(
                                        controller: _tricariTanimController,
                                        maxLines: 4,
                                        minLines: 4,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("Kap Tipi *", style: _labelMandatoryStyle,),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: ()async{
                                                var result = await showDialog(context: context, builder: (context)=>SearchDropdownDialog(
                                                  endpoint: "GetCaseTypes",
                                                  target: "kod",
                                                  nonSearchable: true,
                                                ));
                                                if(result==null)return;
                                                _kapTipi = result['kod'];
                                                setState(() {

                                                });
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  margin: EdgeInsets.only(top: 5, right: 10),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.grey[600], width: 1)
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(_kapTipi??"", style: _valueStyle,),
                                                      ),
                                                      Icon(Icons.arrow_drop_down, color: Colors.grey[600],)
                                                    ],
                                                  )
                                              )
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(width: 10,),
                                                Text("Kap Adet *", style: _labelMandatoryStyle,),
                                              ],
                                            ),
                                            Container(
                                              height: 32,
                                              margin: EdgeInsets.only(top: 5, left: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey[600], width: 1)
                                              ),
                                              child: TextField(
                                                controller: _kapAdetController,
                                                keyboardType: TextInputType.number,
                                                onEditingComplete: (){
                                                  setState(() {

                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.all(5),
                                                  border: OutlineInputBorder(borderSide: BorderSide.none)
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Brut Kg *", style: _labelMandatoryStyle,),
                                              ],
                                            ),
                                            Container(
                                              height: 32,
                                              margin: EdgeInsets.only(top: 5, right: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey[600], width: 1)
                                              ),
                                              child: TextField(
                                                controller: _brutKgController,
                                                keyboardType: TextInputType.number,
                                                onEditingComplete: (){
                                                  setState(() {

                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.all(5),
                                                    border: OutlineInputBorder(borderSide: BorderSide.none)
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(width: 10,),
                                                Text("Net Kg *", style: _labelMandatoryStyle,),
                                              ],
                                            ),
                                            Container(
                                              height: 32,
                                              margin: EdgeInsets.only(top: 5, left: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey[600], width: 1)
                                              ),
                                              child: TextField(
                                                controller: _netKgController,
                                                keyboardType: TextInputType.number,
                                                onEditingComplete: (){
                                                  setState(() {

                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.all(5),
                                                    border: OutlineInputBorder(borderSide: BorderSide.none)
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Tutar *", style: _labelMandatoryStyle,),
                                              ],
                                            ),
                                            Container(
                                              height: 32,
                                              margin: EdgeInsets.only(top: 5, right: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey[600], width: 1)
                                              ),
                                              child: TextField(
                                                controller: _tutarController,
                                                keyboardType: TextInputType.number,
                                                onEditingComplete: (){
                                                  setState(() {

                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.all(5),
                                                    border: OutlineInputBorder(borderSide: BorderSide.none)
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(width: 10,),
                                                Text("Doviz *", style: _labelMandatoryStyle,),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: ()async{
                                                var result = await showDialog(context: context, builder: (context)=>SearchDropdownDialog(
                                                  endpoint: "GetCurrencys",
                                                  target: "kod",
                                                  nonSearchable: true,
                                                ));
                                                if(result==null)return;
                                                _doviz = result['kod'];
                                                setState(() {

                                                });
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  margin: EdgeInsets.only(top: 5, left: 10),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.grey[600], width: 1)
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(_doviz??"", style: _valueStyle,),
                                                      ),
                                                      Icon(Icons.arrow_drop_down, color: Colors.grey[600],)
                                                    ],
                                                  )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),
          )
      ),
      bottomNavigationBar: BottomBarWidget(
        pageIndex: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: !_active?Colors.blue.withOpacity(0.5):Color(0xFF007DB9),
        onPressed: ()async{

          if(!_active)
            return;
          try{
          if(int.parse(_brutKgController.text) < int.parse(_netKgController.text)){
            Toast.show("Net kg, Brüt kg'dan fazla olamaz.", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            return;
          }
        }catch(e){
          print(e.toString());
          Toast.show("msg", context);
            return;
        }
        //if(!await Dialogs.confirmDialog(context, "Are you sure?")) return;
          setState(() {
            _loading = true;
          });
          String _endpoint = "AddProduct";
          var _params = {
            "sirket_Id": Provider.of<NewDeclarationProvider>(context, listen:false).sekirtId,
            "ref": widget.trnNumber,
            "gtip": _gtip,
            "net": int.parse(_netKgController.text),
            "burut": int.parse(_brutKgController.text),
            "gtipTanim": _tricariTanimController.text,
            "rejimKodu": widget.declaration.rejimKodu,
            "userId": UserRepository().user.id.toString(),
            "fTutar": int.parse(_tutarController.text),
            "fDoviz": _doviz
          };

          var result = await ApiHelper().doListPostRequest(_endpoint, _params);
          var _kapParams = {
            "sirket_Id": Provider.of<NewDeclarationProvider>(context, listen:false).sekirtId,
            "ref": widget.trnNumber,
            "kalem_No": 1,
            "kapMarkaNo": "ADDR",
            "kapTipi": "BI - Kap",
            "kapAdet": 100,
            "kalemSayisi": 1,
            "kapMarkaNo_LNG": "TR",
            "giris": UserRepository().user.id,
          };
          await ApiHelper().doListPostRequest("AddCase", _kapParams);
          print(result);
          int status = 1;
          if(result.isEmpty)
            status = 0;
          Navigator.pop(context, status);

        },
        child: Icon(Icons.check),
      ),
    );
  }
}
