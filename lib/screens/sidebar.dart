import 'package:flutter/material.dart';
import 'package:tobbund/repository/UserRepository.dart';
import 'dart:io' show Platform;

class SideBarWidget extends StatelessWidget {
  SideBarWidget({this.callback});
  final ValueChanged<String> callback;
  int logoHeight;

  @override
  Widget build(BuildContext context) {
    
    Widget _administrativeFunctions() {
      if(UserRepository().user.sirketId == 1000){
         return InkWell(
            onTap: () {
              callback("administrativeFunctions");
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      radius: 12,
                      child: Icon( Icons.functions),
                      backgroundColor: Colors.white,
                      ),
                    ),
                    // child: Icon(Icons.functions, color: Color(0xFFFFCC00), size: 25,)
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Yönetsel İşlevler",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Verdana",
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
          );
      }else {
        return InkWell(
          child: Container(),
        );
      }
    }
    
    return Scaffold(
      backgroundColor: Color(0xFF00507D),
      body: Container(
          padding: EdgeInsets.only(left: 10, top: 30),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                  SizedBox(height: 20,),
                  ListTile(
                    title: Text(
                      UserRepository().user.adiSoyadi,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Verdana"
                      ),
                    ),
                    subtitle: Text(
                      UserRepository().user.ticaretUnvani,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: "Verdana"
                      ),
                    ),
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.account_circle,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 2,
                    color: Colors.white,
                    indent: 2,
                    endIndent: 15,
                  ),
                  
                //Administrative Functions
                _administrativeFunctions(),

                //Account
                InkWell(
                  onTap: () {
                    callback("account");
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon( 
                            Icons.account_circle, 
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Hesabım",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Verdana",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //declerations list
                InkWell(
                  onTap: () {
                    callback("registrationProcedures");
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon( 
                            Icons.view_list, 
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Tescil Listesi",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Verdana",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //new declerations
                InkWell(
                  onTap: () {
                    callback("newDeclerations");
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon( 
                            Icons.edit, 
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Yeni ENS Beyanı",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Verdana",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //customer information
                InkWell(
                  onTap: () {
                    callback("customerInformation");
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon( 
                            Icons.people, 
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Müşteri Bilgileri",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Verdana",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // help and support
                InkWell(
                  onTap: () {
                    callback("helpandsupport");
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon( 
                            Icons.help, 
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Yardım ve Destek",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Verdana",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // reports
                InkWell(
                  onTap: () {
                    callback("reports");
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon( 
                            Icons.report, 
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Raporlar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Verdana",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // SettingScreen-Start //
                InkWell(
                  onTap: () {
                    callback("settings");
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon( 
                            Icons.settings, 
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Ayarlar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Verdana",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // SettingScreen-End //
                InkWell(
                  onTap: () {
                    callback("logout");
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon( 
                            Icons.close, 
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Güvenli Çıkış",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Verdana",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                //logo
                Container(
                  height: MediaQuery.of(context).size.height - (Platform.isIOS?170:298),
                  width: 225,
                  child: Image.asset("assets/images/logo-tagline-white.png"),
                )
              ],
            ),
          )
        ),
    );
  }
}