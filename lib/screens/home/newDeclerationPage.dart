import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/controller/new_declerations_provider.dart';
import 'package:tobbund/model/TRNItem.dart';
import 'package:tobbund/model/voyages.dart';
import 'package:tobbund/repository/UserRepository.dart';
import 'package:tobbund/model/declaration.dart';
import 'package:tobbund/screens/bottombar.dart';
import 'package:tobbund/screens/home/declerations/declerationPreviousDetailsPage.dart';
import 'package:tobbund/screens/home/newDecleration/searchDialogForCompany.dart';
import 'package:tobbund/screens/home/newDecleration/searchDialogForCarrier.dart';
import 'package:tobbund/screens/home/newDecleration/dropdownDialogForRejim.dart';
import 'package:tobbund/screens/home/newDecleration/dropdownDialogForTransmod.dart';
import 'package:tobbund/screens/home/newDecleration/dropdownDialogForCekici.dart';
import 'package:tobbund/screens/home/newDecleration/dropdownDialogForTreyler.dart';
import 'package:tobbund/screens/home/newDecleration/voyagesDialog.dart';
import 'package:tobbund/screens/home.dart';
import 'package:toast/toast.dart';
import 'package:tobbund/widgets/dialog.dart';

class NewDeclerationPage extends StatefulWidget {
  final Declaration declaration;
  NewDeclerationPage({this.declaration});
  @override
  _NewDeclerationPageState createState() => _NewDeclerationPageState();
}

class _NewDeclerationPageState extends State<NewDeclerationPage> {
  bool _isLoading = false;
  bool _companyChange;
  Map<String, dynamic> _companyName = {};
  int _companyId = UserRepository().user.sirketId;
  Map<String, dynamic> _carrier;
  String _truckCode;
  String _trailerCode;
  //String _selectedRegimeCode;
  String _selectedRegimeCode = 'ENS';
  String _selectedTransMode;
  final _konteynerController = new TextEditingController();
  bool _isValid = false;
  Voyages _voyages;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final Map<String, String> _tasimaModuMap = {
    "UND": "UN RoRo",
    "ULU": "Ulusoy",
    "SLS":"Sea Lines"
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.declaration != null) {
      print(widget.declaration.toJson());
      _companyName['name'] = widget.declaration.firmaAd;
      _companyName['id'] = widget.declaration.firmaId;
      _companyName['firmaId'] = UserRepository().user.sirketId;
      _carrier = {
        "id": widget.declaration.tasiyiciId,
        "name": widget.declaration.tasiyici
      };
      _truckCode = widget.declaration.plaka;
      _selectedRegimeCode = widget.declaration.rejimKodu;
      _selectedTransMode = widget.declaration.tasimaModu;
    } else {
      _companyName['name'] = UserRepository().user.ticaretUnvani ?? "";
      _companyName['id'] = UserRepository().user.firmaId;
      _companyName['firmaId'] = UserRepository().user.sirketId;

      if (_companyId != 1000) {
        _companyName["name"] = UserRepository().user.ticaretUnvani;
        _companyChange = false;
        setState(() {});
      }else{
        _companyName["name"] == "";
        _companyChange = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Color(0xFF187EA0),
          title: Text("Yeni ENS Beyanı"),
          // Eray - Start //
          leading: GestureDetector(
            onTap: () {
              if (widget.declaration != null) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            },
            child: Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 60,
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        "assets/images/icon1-company.png",
                        width: 50,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: !UserRepository().user.superUser?
                      ListTile(
                        title: Text(
                          "Firma",
                          style:
                          TextStyle(color: Colors.grey[400], fontSize: 15),
                        ),
                        subtitle: Text(
                          _companyName['name'],
                          style:
                          TextStyle(color: Colors.grey[400], fontSize: 17),
                        ),
                        trailing: Icon(Icons.arrow_drop_down, color: Colors.grey[300],),
                      ):
                      ListTile(
                          enabled: _companyChange,
                          onTap: () async {
                            Map<String, dynamic> result = await showDialog<Map<String, dynamic>>(
                                  context: context,
                                  builder: (context) {
                                    return SearchDialogForCompany();
                                  });
                              if (result == null) return;
                              _carrier = null;
                              _truckCode = null;
                              _trailerCode = null;
                              _companyName = result;
                              setState(() {});
                            },
                          title: Text("Firma", style: TextStyle(color: Colors.grey, fontSize: 15),),
                          subtitle: Text(_companyName['name'] ?? "Seçiniz...", style: TextStyle(color: Colors.black, fontSize: 17),),
                          trailing: Icon(Icons.arrow_drop_down),
                        ),
                      ),                    
                  ],
                ),
                Container(
                  color: Colors.grey[200],
                  height: 1,
                ),
              ],
            ),
            Stack(
              alignment: Alignment(1, -1),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 60,
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/images/icon2-carrier.png",
                            width: 50,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: ListTile(
                            onTap: () async {
                              Map<String, dynamic> result =
                              await showDialog<Map<String, dynamic>>(
                                  context: context,
                                  builder: (context) {
                                    return SearchDialogForCarrier(company: _companyName,);
                                  });
                              if (result != null) {
                                if(result != _carrier){
                                  _truckCode = null;
                                  _trailerCode = null;
                                }
                                _carrier = result;
                                setState(() {});
                              }
                            },
                            title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                            Text(
                            "Taşıyıcı",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 15),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red[800], fontSize: 15),
                            ),
                            ],),
                            subtitle: Text(
                              _carrier == null
                                  ? "Seçiniz"
                                  : _carrier['name'],
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 17),
                            ),
                            trailing: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 1,
                    ),
                  ],
                ),
                _isValid && _carrier == null
                    ? Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Zorunlu alan",
                    style: TextStyle(color: Colors.red[300]),
                  ),
                )
                    : Container()
              ],
            ),
            Stack(
              alignment: Alignment(1, -1),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 60,
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/images/icon3-rcode.png",
                            width: 50,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: ListTile(
                            onTap: () async {
                              String result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DropdownDialogForRejim();
                                  });
                              if (result == null) return;
                              _selectedRegimeCode = result;
                              setState(() {});
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                              Text(
                              "Rejim",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 15),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red[800], fontSize: 15),
                            ),
                            ],),
                            subtitle: Text(
                              _selectedRegimeCode ?? "Seçiniz",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 17),
                            ),
                            trailing: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 1,
                    ),
                  ],
                ),
                _isValid && _selectedRegimeCode == null
                    ? Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Zorunlu Alan",
                    style: TextStyle(color: Colors.red[300]),
                  ),
                )
                    : Container()
              ],
            ),
            Stack(
              alignment: Alignment(1, -1),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 60,
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/images/icon4-tmode.png",
                            width: 50,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: ListTile(
                            onTap: () async {
                              String result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DropdownDialogForTransmod();
                                  });
                              if (result == null) return;
                              _selectedTransMode = result;
                              setState(() {});
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                              Text(
                              "Taşıma Modu",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 15),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red[800], fontSize: 15),
                            ),
                            ],),
                            subtitle: Text(
                              _tasimaModuMap[_selectedTransMode] ?? "Seçiniz",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 17),
                            ),
                            trailing: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 1,
                    ),
                  ],
                ),
                _isValid && _selectedTransMode == null
                    ? Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Zorunlu Alan",
                    style: TextStyle(color: Colors.red[300]),
                  ),
                )
                    : Container()
              ],
            ),
            Stack(
              alignment: Alignment(1, -1),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 60,
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/images/icon5-expedition.png",
                            width: 50,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: ListTile(
                            onTap: () async {
                              String endpoint;
                              if(_selectedTransMode == "UND"){
                                endpoint = "GetVoyagesUnRoro";
                              }
                              if(_selectedTransMode == "ULU"){
                                endpoint = "GetVoyagesUlusoy";
                              }
                              if(endpoint==null)return;
                              var result = await showDialog(context: context, builder: (context){
                                return VoyagesDialog(endpoint: endpoint,);
                              });
                              if(result!=null){
                                _voyages = Voyages.fromJson(result);
                                setState(() {

                                });
                              }
                            },
                            title: Text(
                              "Sefer",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 15),
                            ),
                            subtitle: Text(
                              _voyages==null?"Seçiniz":"${_voyages.vesselName} / ${_voyages.departureDate} \n/ ${_voyages.departurePort} - ${_voyages.arrivalPort}",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 15),
                            ),
                            trailing: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 1,
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              alignment: Alignment(1, -1),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 60,
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/images/icon6-wrecker.png",
                            width: 50,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: ListTile(
                            onTap: () async {
                              if(_carrier == null) return;
                              String result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DropdownDialogForCekici(company: _companyName);
                                  });
                              if (result == null) return;
                              _truckCode = result;
                              setState(() {});
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                              Text(
                              "Çekici",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 15),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.red[800], fontSize: 15),
                            ),
                            ],),
                            subtitle: Text(
                              _truckCode ?? "Seçiniz",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 17),
                            ),
                            trailing: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 1,
                    ),
                  ],
                ),
                _isValid && _truckCode == null
                    ? Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Zorunlu Alan",
                    style: TextStyle(color: Colors.red[300]),
                  ),
                )
                    : Container()
              ],
            ),
            Stack(
              alignment: Alignment(1, -1),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 60,
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/images/icon7-trailer.png",
                            width: 50,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: ListTile(
                            onTap: () async {
                              if(_carrier == null) return;
                              String result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DropdownDialogForTreyler(company: _companyName,);
                                  });
                              if (result == null) return;
                              _trailerCode = result;
                              setState(() {});
                            },
                            title: Text(
                              "Treyler",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 15),
                            ),
                            subtitle: Text(
                              _trailerCode ?? "Seçiniz",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 17),
                            ),
                            trailing: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 1,
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              alignment: Alignment(1, -1),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 60,
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/images/icon8-container.png",
                            width: 50,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: TextField(
                            controller: _konteynerController,
                            maxLength: 11,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: "Varsa konteyner numarası giriniz.",
                              hintStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              labelText: "Konteyner",
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey[200],
                      height: 1,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF007DB9),
          onPressed: ()async{

            if (_carrier == null ||
                _selectedRegimeCode == null ||
                _selectedTransMode == null ||
                _truckCode == null ||
                (_konteynerController.text.length < 11 &&
                    _konteynerController.text.length > 0)) {
              print(_konteynerController.text.length);
              Toast.show("Lütfen zorunlu alanları doldurun.", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              setState(() {
                _isValid = true;
              });
              return;
            }
            //if(!await Dialogs.confirmDialog(context, "Are you sure?")) return;
            if(_isLoading)return;
              _isLoading = true;

            Map _param;
            String _url;

            if (widget.declaration == null) {
              _param = {
                "sirket_Id": _companyId,
                "firma": "${_companyName['id']}",
                "kFirma": "${_carrier['id']}",
                "rejimKodu": _selectedRegimeCode,
                "giris": UserRepository().user.id,
                "gumruk": "TR999999",
                "tasima_Mod": "${_selectedTransMode}",
                "plaka": _truckCode,
                "plaka2": _trailerCode,
                "container": _konteynerController.text,
              };
              _url = "AddPosition";
            } else {
              print(widget.declaration.otoId);
              _param = {
                "oto_Id": widget.declaration.otoId,
                "sirket_Id": _companyId,
                "firma": "${_companyName['id']}",
                "kFirma": "${_carrier['id']}",
                "rejimKodu": _selectedRegimeCode,
                "giris": UserRepository().user.id,
                "gumruk": "TR999999",
                "plaka": _truckCode,
                "plaka2": _trailerCode,
                "container": _konteynerController.text
              };
              _url = "UpdatePosition";
            }

            var result =
            await ApiHelper().doListPostRequest(_url, _param);
            _isLoading = false;
            print(result);
            if(result.isNotEmpty){
              Provider.of<NewDeclarationProvider>(context, listen: false).sekirtId = _companyName['firmaId'];
              Dialogs.showLoadingDialog(context,
                key: _keyLoader,
                barrierDismissible: false,
                title: "Başarılı!",
                description: "Pozisyon oluşturuldu.",
                icon: "success",
              );
              await Future.delayed(Duration(seconds: 2));
              Map<String, dynamic> _param = {
                "authorityLevel": UserRepository().user.yetkiDuzeyi,
                "firmId": UserRepository().user.sirketId,
                "userId": UserRepository().user.id,
                "search": result[0]['reF_POS'],
                "lastId": "0"
              };
              String _endpoint = "GetPositions";
              var declaration;
              List<TRNItem> _trns = [];
              try {
                var responseForDeclaration = await ApiHelper().doListPostRequest(_endpoint, _param);
                declaration = new Declaration.fromJson(responseForDeclaration[0]);
                const String endpoint = "GetTRNs";
                var params = {
                  "refNumber": declaration.ref,
                  "firmId": declaration.sirketId,
                };

                var response = await ApiHelper().doListPostRequest(endpoint, params);

                for (var item in response) {
                  _trns.add(TRNItem.fromJson(item));
                }}
              catch(e){
                Dialogs.showLoadingDialog(context,
                  key: _keyLoader,
                  barrierDismissible: true,
                  title: "Hata!",
                  description: "Pozisyon oluşturulamadı!",
                  icon: "failed",
                );
                await Future.delayed(Duration(seconds: 2));

                Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                return;
              }
              Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DeclerationPreviousDetailsPage(trns: _trns, declaration: declaration,)));
            }else{
              Dialogs.showLoadingDialog(context,
                key: _keyLoader,
                barrierDismissible: true,
                title: "Hata!",
                description: "Pozisyon oluşturulamadı!",
                icon: "failed",
              );
              await Future.delayed(Duration(seconds: 2));

              Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
            }
          },
          child: Icon(Icons.check),
        ),
        bottomNavigationBar: BottomBarWidget(
          pageIndex: 1,
        ));
  }
}
