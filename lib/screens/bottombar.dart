import 'package:flutter/material.dart';
import 'package:tobbund/controller/connectivity_provider.dart';
import 'dart:io' show Platform;
import 'package:tobbund/screens/home/declerationsPage.dart';
import 'package:tobbund/screens/home/newDeclerationPage.dart';
import 'package:tobbund/screens/home/customerInformation.dart';
import 'package:tobbund/widgets/dialog.dart';

class BottomBarWidget extends StatelessWidget {
  BottomBarWidget({Key key, this.pageIndex}) : super(key: key);
  int pageIndex;

  @override
  Widget build(BuildContext context) {
    dialogcontext = context;
    return Platform.isIOS
        ? Container(
            height: 65,
            color: Color(0xFF007DB9),
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async{
                    if (pageIndex != 0)
                    if(pageIndex == 1)
                    if(!await Dialogs.confirmDialog(context, "Bilgiler kaydedilmedi. Sayfadan çıkmak istediğinize emin misiniz?")) return;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeclerationsPage()));
                  },
                  child: Container(
                      child: Column(children: <Widget>[
                    Container(
                      height: 35,
                      child: Image.asset(
                        "assets/images/registration.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      "Tescil Listesi",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ])),
                ),

                ///////////
                InkWell(
                  onTap: () async{
                    print("Decleration");
                    if (pageIndex != 1)

                    
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewDeclerationPage()));
                  },
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Container(
                        height: 35,
                        child: Image.asset(
                          "assets/images/decleration.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "Yeni Beyan Yaz",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )
                    ],
                  )),
                ),

                //////////
                InkWell(
                  onTap: () async{
                    if (pageIndex != 2)
                    if(pageIndex == 1)
                    if(!await Dialogs.confirmDialog(context, "Bilgiler kaydedilmedi. Sayfadan çıkmak istediğinize emin misiniz?")) return;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerInformation()));
                  },
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Container(
                        height: 35,
                        child: Image.asset(
                          "assets/images/client.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "Müşteri Bilgileri",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )
                    ],
                  )),
                ),

                //////////
                // InkWell(
                //   onTap: (){},
                //   child: Container(
                //       child: Column(
                //         children: <Widget>[
                //           Container(
                //             height: 35,
                //             child: Image.asset("assets/images/invoice.png",fit: BoxFit.cover,),
                //           ),
                //           Text("Fatura Rapor", style: TextStyle(fontSize: 12, color: Colors.white),)
                //         ],
                //       )
                //   ),
                // )
              ],
            ),
          )
        : Container(
            height: 58,
            color: Color(0xFF007DB9),
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async{
                    if (pageIndex != 0)
                      if(pageIndex == 1)
                        if(!await Dialogs.confirmDialog(context, "Bilgiler kaydedilmedi. Sayfadan çıkmak istediğinize emin misiniz?")) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeclerationsPage()));
                  },
                  child: Container(
                      child: Column(children: <Widget>[
                        Container(
                          height: 35,
                          child: Image.asset(
                            "assets/images/registration.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "Tescil Listesi",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )
                      ])),
                ),

                ///////////
                InkWell(
                  onTap: () async{
                    print("Decleration");
                    if (pageIndex != 1)


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewDeclerationPage()));
                  },
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 35,
                            child: Image.asset(
                              "assets/images/decleration.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Yeni Beyan Yaz",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      )),
                ),

                //////////
                InkWell(
                  onTap: () async{
                    if (pageIndex != 2)
                      if(pageIndex == 1)
                        if(!await Dialogs.confirmDialog(context, "Bilgiler kaydedilmedi. Sayfadan çıkmak istediğinize emin misiniz?")) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerInformation()));
                  },
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 35,
                            child: Image.asset(
                              "assets/images/client.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Müşteri Bilgileri",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      )),
                ),

                //////////
                // InkWell(
                //   onTap: (){},
                //   child: Container(
                //       child: Column(
                //         children: <Widget>[
                //           Container(
                //             height: 35,
                //             child: Image.asset("assets/images/invoice.png",fit: BoxFit.cover,),
                //           ),
                //           Text("Fatura Rapor", style: TextStyle(fontSize: 12, color: Colors.white),)
                //         ],
                //       )
                //   ),
                // )
              ],
            ),
          );
  }
}
