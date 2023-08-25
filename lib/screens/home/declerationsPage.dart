import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/model/TRNItem.dart';
import 'package:tobbund/repository/UserRepository.dart';
import 'package:tobbund/screens/bottombar.dart';
import 'package:tobbund/screens/home.dart';
import 'package:tobbund/screens/home/newDeclerationPage.dart';
import 'package:tobbund/screens/home/declerations/declerationPreviousDetailsPage.dart';
import 'package:tobbund/model/declaration.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'declerations/declerationDetailsPage.dart';
import 'package:toast/toast.dart';

class DeclerationsPage extends StatefulWidget {
  @override
  _DeclerationsPageState createState() => _DeclerationsPageState();
}

class _DeclerationsPageState extends State<DeclerationsPage> {
  final _searchController = new TextEditingController();
  bool _isSearching = true;
  bool _isLoading = false;
  List<Declaration> _declarationList = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String _lastItemId;
  String _searchText = ""; // "kar"
  int lastDeclarationCount = 10;
  Widget DeclerationItemWidget(Declaration _declaration, BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: InkWell(
          onTap: () {
            _getTRNsAndGo(_declaration);
          },
          child: Stack(
            children: <Widget>[
              Card(
                elevation: 5,
                color: Colors.grey[100],
                child: Padding(
                    padding: EdgeInsets.all(7),
                    child: Column(
                      children: <Widget>[
                        _detailsItemWidget(context, name: "Kayıt Numarası", value: "${_declaration.id}", image: "assets/images/1.PNG"),
                        _detailsItemWidget(context, name: "Firma", value: "${_declaration.firmaAd}", image: "assets/images/2.PNG"),
                        _detailsItemWidget(context, name: "Taşıyıcı", value: "${_declaration.tasiyici}", image: "assets/images/3.PNG"),
                        _detailsItemWidget(context, name: "Plaka", value: "${_declaration.plaka}", image: "assets/images/4.PNG"),
                        _detailsItemWidget(context, name: "LRN / MRN", value: "${_declaration.mrn??""}", image: "assets/images/5.PNG"),
                        _detailsItemWidget(context, name: "Tarih", value: "${_declaration.duzenliTarih}", image: "assets/images/6.PNG"),
                        _detailsItemWidget(context, name: "Rota", value: "${_declaration.rotaBilgi}", image: "assets/images/8.PNG"),
                        _detailsItemWidget(context, name: "Rejim", value: "${_declaration.rejimKodu}", image: "assets/images/9.PNG"),
                        _detailsItemWidget(context, name: "Statü", value: "${_declaration.ensStatu ?? ""}", image: "assets/images/7.PNG"),
                      ],
                    )
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  height: 30,
                  margin: EdgeInsets.only(bottom: 10
                  ),
                  child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    color: Color(0xFF007DB9),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewDeclerationPage(
                                declaration: _declaration,
                              )));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.edit, color: Colors.white, size: 18,),
                        Text("Güncelle", style: TextStyle(color: Colors.white, ),)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //Text("", style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold),),
                    //Icon(Icons.lens, color: Colors.lightGreen, size: 20,)
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _detailsItemWidget(BuildContext context, {@required String name, String value, String image}){

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
                width: MediaQuery.of(context).size.width-108,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _search("", "0"); // "kar"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                ModalRoute.withName('/'),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Color(0xFF187EA0),
          title: Text("Tescil Listesi"),
        ),
        // body:  SlidingUpPanel(
        //     renderPanelSheet: false,
        //     minHeight: 30,
        //     maxHeight: 170,
        // panel: Container(
        // color: Color(0xFFFFAB00),
        // child: Column(
        //   children: <Widget>[
        //     // Container(
        //     //   width: MediaQuery.of(context).size.width,
        //     //   height: 30,
        //     //   child: Icon(Icons.drag_handle, color: Colors.white, size: 30,),
        //     // ),
        //     // Container(
        //     //   height: 140,
        //     //   child: SingleChildScrollView(
        //     //       child: Column(
        //     //         children: <Widget>[
        //     //           Container(
        //     //             padding: EdgeInsets.only(
        //     //                 bottom: 20
        //     //             ),
        //     //             child: Row(
        //     //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     //               children: <Widget>[
        //     //                 Container(
        //     //                   color: Colors.white,
        //     //                   width: 40,
        //     //                   height: 50,
        //     //                 ),
        //     //                 Container(
        //     //                   color: Colors.white,
        //     //                   width: 40,
        //     //                   height: 50,
        //     //                 ),
        //     //                 Container(
        //     //                   color: Colors.white,
        //     //                   width: 40,
        //     //                   height: 50,
        //     //                 ),
        //     //                 Container(
        //     //                   color: Colors.white,
        //     //                   width: 40,
        //     //                   height: 50,
        //     //                 ),
        //     //               ],
        //     //             ),
        //     //           ),
        //     //           Container(
        //     //             padding: EdgeInsets.only(
        //     //                 bottom: 20
        //     //             ),
        //     //             child: Row(
        //     //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     //               children: <Widget>[
        //     //                 Container(
        //     //                   color: Colors.white,
        //     //                   width: 40,
        //     //                   height: 50,
        //     //                 ),
        //     //                 Container(
        //     //                   color: Colors.white,
        //     //                   width: 40,
        //     //                   height: 50,
        //     //                 ),
        //     //                 Container(
        //     //                   color: Colors.white,
        //     //                   width: 40,
        //     //                   height: 50,
        //     //                 ),
        //     //                 Container(
        //     //                   color: Colors.white,
        //     //                   width: 40,
        //     //                   height: 50,
        //     //                 ),
        //     //               ],
        //     //             ),
        //     //           ),
        //     //         ],
        //     //       )
        //     //   ),
        //     // ),
        //   ],
        // )
        // ),
        // collapsed: Container(
        //   color: Color(0xFFFFAB00),
        //   child: Icon(Icons.drag_handle, color: Colors.white, size: 30,),
        // ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _searchController,
                  onChanged: (val) async {
                    _searchText = val;

                    if (val.length == 0) {
                      _isSearching = true;
                      setState(() {});
                      _search("", "0");
                    }
                    if (val.length < 3) return;
                    _declarationList = [];
                    _isSearching = true;
                    setState(() {});

                    await _search(val, '0');
                  },

                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.only(top: 15, bottom: 15)),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height - 180,
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropHeader(),
                        footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus mode) {
                            Widget body;
                            if (mode == LoadStatus.loading) {
                              body = CupertinoActivityIndicator();
                            } else {
                              body = Container();
                            }
                            return Container(
                              padding: EdgeInsets.all(20),
                              child: body,
                            );
                          },
                        ),
                        controller: _refreshController,
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: ListView(
                          children: _declarationList.map((data) {
                            return DeclerationItemWidget(data, context);
                          }).toList(),
                        ),
                      ),
                    ),
                    _isSearching
                        ? Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 50),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 1.5,
                          ),
                        ))
                        : Container(),
                    _isLoading
                        ? Container(
                      color: Colors.grey.withOpacity(0.4),
                      height: MediaQuery.of(context).size.height - 220,
                      child: Center(
                          child: Container(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 1.5,
                            ),
                          )),
                    )
                        : Container(),
                  ],
                )
              ],
            ),
            // ),
          ),
        ),
        bottomNavigationBar: BottomBarWidget(
          pageIndex: 0,
        ));
  }

  Future _search(String _txt, String ref) async {
    if (ref == "0") {
      _declarationList = [];
      lastDeclarationCount = 10;
    }
    if(lastDeclarationCount < 10)return;

    Map<String, dynamic> _param = {
      "authorityLevel": UserRepository().user.yetkiDuzeyi,
      "firmId": UserRepository().user.sirketId,
      "userId": UserRepository().user.id,
      "basTarih": null,
      "bitisTarih": null,
      "search": _txt,
      "lastId": ref
    };

    String _endpoint = "GetPositions";

      var response = await ApiHelper().doListPostRequest(_endpoint, _param);

      print(response);
      for (var item in response) {
        Declaration _decleration = new Declaration.fromJson(item);
        _declarationList.add(_decleration);
      }
      if(_declarationList.isNotEmpty) {
        _lastItemId = _declarationList.last.ref;
        lastDeclarationCount = response.length;
      }
    _isSearching = false;
    setState(() {});
  }

  void _onRefresh() async {
    // monitor network fetch
    // if failed,use refreshFailed()
    _lastItemId = "0";

    await _search(_searchText, "0");
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    await _search(_searchText, _lastItemId);
    _refreshController.loadComplete();
  }

  void _getTRNsAndGo(Declaration declaration) async {
    setState(() {
      _isLoading = true;
    });
    List<TRNItem> _trns = [];

    const String endpoint = "GetTRNs";
    var params = {
      "refNumber": declaration.ref,
      "firmId": declaration.sirketId,
    };

    try {
      var response = await ApiHelper().doListPostRequest(endpoint, params);

      for (var item in response) {
        _trns.add(TRNItem.fromJson(item));
      }

//      if (_trns.isEmpty) {
//        setState(() {
//          _isLoading = false;
//        });
//        Toast.show("Bu pozisyon içerisinde beyan yoktur.", context,
//            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
//        return;
//      }
//
//      if (_trns.length == 1) {
//        await Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) => DeclerationDetailsPage(
//                      trnNumber: _trns[0].ref,
//                      lrn_mrn: _trns[0].lrn,
//                  declaration: declaration,
//                    )));
//      }

//      if (_trns.length > 1) {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DeclerationPreviousDetailsPage(
                      trns: _trns,
                  declaration: declaration,
                    )));
//      }
    } catch (e) {
      print("error: ${e.toString()}");
    }
    setState(() {
      _isLoading = false;
    });
  }
}
