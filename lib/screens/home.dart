import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tobbund/controller/localAuth.dart';
import 'package:tobbund/screens/bottombar.dart';
import 'package:tobbund/screens/login.dart';
import 'package:tobbund/screens/sidebarItemScreens/administrativeFunctionsScreen.dart';
import 'package:tobbund/screens/sidebarItemScreens/accountScreen.dart';
import 'package:tobbund/screens/sidebarItemScreens/registrationProcedures.dart';
import 'package:tobbund/screens/home/customerInformation.dart';
import 'package:tobbund/screens/sidebarItemScreens/helpSupportScreen.dart';
import 'package:tobbund/screens/sidebarItemScreens/regulationScreen.dart';
import 'package:tobbund/screens/sidebarItemScreens/reportScreen.dart';
import 'package:tobbund/screens/sidebarItemScreens/settingScreen.dart';
import 'package:tobbund/screens/sidebar.dart';
import 'package:tobbund/screens/home/newDeclerationPage.dart';
import 'package:tobbund/screens/home/declerationsPage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'dart:io' show Platform;
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    List<charts.Series<Declerations, String>> _seriesPieData;

   _generateData(){
    var pieData=[
      new Declerations ('Açık Beyan Sayısı', 120, Color(0xFFFFAB00)),
      new Declerations ('Hazırlanan Beyan Sayısı', 130, Color(0xFF12C8F5)),
      new Declerations ('Tamamlanmış Beyan Sayısı', 100, Color(0xFF0B1C3A)),
    ];

    _seriesPieData.add(
      charts.Series(
        data: pieData,
        domainFn: (Declerations declerations,_) => declerations.name,
        measureFn: (Declerations declerations,_) => declerations.value,
        colorFn: (Declerations declerations,_) => charts.ColorUtil.fromDartColor(declerations.colorValue),
        id: 'Beyan Sayıları',
        labelAccessorFn: (Declerations row,_) => '${row.value}'
      )
    );
  }

  pieChart(){
    return charts.PieChart(
      _seriesPieData,
      animate: true,
      animationDuration: Duration(seconds: 2),
      behaviors: [
        new charts.DatumLegend(
          outsideJustification: charts.OutsideJustification.middleDrawArea,
          horizontalFirst: false,
          desiredMaxRows: 5,
          // cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          entryTextStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Color(0xFF0B1C3A)),
            fontFamily: 'Verdana',
            fontSize: 14
          ),
        ),
      ],
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 100,
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.inside
          )
        ]
      ),
    );
  }

  bool _isLoading = false;
  
  @override
  
  void initState(){
    super.initState();
    _seriesPieData = List<charts.Series<Declerations, String>>();
    _generateData();
  }

  Widget build(BuildContext context)
  {
    return InnerDrawer(
        key: _innerDrawerKey,
        onTapClose: true, // default false
        swipe: true, // default true
        // colorTransition: Colors.white, // default Color.black54
        // DEPRECATED: use offset
        leftOffset: 0.6, // Will be removed in 0.6.0 version
        rightOffset: 0.6,// Will be removed in 0.6.0 version
        //When setting the vertical offset, be sure to use only top or bottom
        offset: IDOffset.only(
            left: 0.5,
            top: 0,
            bottom: 0
        ),
        proportionalChildArea : true, // default true
        leftAnimationType: InnerDrawerAnimation.static, // default static
        rightAnimationType: InnerDrawerAnimation.quadratic,
        // backgroundColor: Color(0xFF405161), // default  Theme.of(context).backgroundColor

//        //when a pointer that is in contact with the screen and moves to the right or left
//        onDragUpdate: (double val, InnerDrawerDirection direction) {
//
//        },
//        innerDrawerCallback: (a) => print(a), // return  true (open) or false (close)
        leftChild: SideBarWidget(
          callback: (val){
            _toggle();
            switch(val){
              case "administrativeFunctions":
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdministrativeFunctionsScreen()));
                break;
              case "account":
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountScreen()));
                break;
              case "registrationProcedures":
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeclerationsPage()));
                break;
              case "newDeclerations":
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewDeclerationPage()));
                break;
              case "customerInformation":
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerInformation()));
              break;
              case "regulation":
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegulationScreen()));
                break;
              case "helpandsupport":
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HelpSupportScreen()));
                break;
              case "reports":
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReportScreen()));
                break;
              case "settings":
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingScreen()));
                break;
              default:
                _logout();
            }
          },
        ),

        scaffold: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 50, left: 20, bottom: 10
                ),
                child: InkWell(
                  onTap: (){
                    _toggle();
                  },
                  child: Icon(Icons.menu, color: Colors.red, size: 35,),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: 50, right: 20, bottom: 10
                  ),
                  child: Image.asset(
                    "assets/images/logo-skyblue.png",
                    height: 45.0,
                  ),
              ),
            ],
          ), preferredSize: Size.fromHeight(80)),
          body: SlidingUpPanel(
            // slideDirection: SlideDirection.UP,
            renderPanelSheet: false,
            minHeight: 30,
            maxHeight: 170,
            panel: Container(
            //   color: Color(0xFF009BD4),
            //   child: Column(
            //     children: <Widget>[
            //       Container(
            //         width: MediaQuery.of(context).size.width,
            //         height: 30,
            //         child: Icon(Icons.drag_handle, color: Colors.white, size: 30,),
            //       ),
            //       Container(
            //         height: 140,
            //         child: SingleChildScrollView(
            //           child: Column(
            //             children: <Widget>[
            //               Container(
            //                 padding: EdgeInsets.only(
            //                     bottom: 20
            //                 ),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                   children: <Widget>[
            //                     Container(
            //                       color: Colors.white,
            //                       width: 50,
            //                       height: 50,
            //                     ),
            //                     Container(
            //                       color: Colors.white,
            //                       width: 50,
            //                       height: 50,
            //                     ),
            //                     Container(
            //                       color: Colors.white,
            //                       width: 50,
            //                       height: 50,
            //                     ),
            //                     Container(
            //                       color: Colors.white,
            //                       width: 50,
            //                       height: 50,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Container(
            //                 padding: EdgeInsets.only(
            //                     bottom: 20
            //                 ),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                   children: <Widget>[
            //                     Container(
            //                       color: Colors.white,
            //                       width: 50,
            //                       height: 50,
            //                     ),
            //                     Container(
            //                       color: Colors.white,
            //                       width: 50,
            //                       height: 50,
            //                     ),
            //                     Container(
            //                       color: Colors.white,
            //                       width: 50,
            //                       height: 50,
            //                     ),
            //                     Container(
            //                       color: Colors.white,
            //                       width: 50,
            //                       height: 50,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           )
            //         ),
            //       ),
            //     ],
            //   )
            ),
            // collapsed: Container(
            //   color: Color(0xFF009BD4),
            //   child: Icon(Icons.drag_handle, color: Colors.white, size: 30,),
            // ),
            body: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/2-20,
                      height: (MediaQuery.of(context).size.width/2-20) * 0.6,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFAD8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Kalan Bakiye", style: TextStyle(
                                      fontFamily: "Verdana",
                                      fontSize: 14,
                                      color: Color(0xFF12C8F5)
                                  ),),
                                ],
                              ),
                              Text("1668,89 ₺", style: TextStyle(
                                fontFamily: "Verdana",
                                fontSize: 20,
                                color: Color(0xFF12C8F5)
                              ),),
                            ],
                          ),
                          Icon(Icons.account_balance_wallet, color: Color(0xFF12C8F5),)
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2-20,
                      height: (MediaQuery.of(context).size.width/2-20) * 0.6,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFAD8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Yıllık Toplam", style: TextStyle(
                                      fontFamily: "Verdana",
                                      fontSize: 16,
                                      color: Color(0xFF0E1D3A)
                                  ),),
                                  Text("Teminat Bedeli", style: TextStyle(
                                      fontFamily: "Verdana",
                                      fontSize: 14,
                                      color: Color(0xFF0E1D3A)
                                  ),),
                                ],
                              ),
                              Text("1000000,00 ₺", style: TextStyle(
                                  fontFamily: "Verdana",
                                  fontSize: 16,
                                  color: Color(0xFF0E1D3A)
                              ),),
                            ],
                          ),
                          Icon(Icons.queue, color: Color(0xFF0E1D3A),)
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/2-20,
                      height: (MediaQuery.of(context).size.width/2-20) * 0.6,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFAD8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Kayıtlı", style: TextStyle(
                                      fontFamily: "Verdana",
                                      fontSize: 14,
                                      color: Color(0xFF0E1D3A)
                                  ),),
                                  Text("İş Ortağı Sayısı", style: TextStyle(
                                      fontFamily: "Verdana",
                                      fontSize: 14,
                                      color: Color(0xFF0E1D3A)
                                  ),),
                                ],
                              ),
                              Text("22,170", style: TextStyle(
                                  fontFamily: "Verdana",
                                  fontSize: 20,
                                  color: Color(0xFF0E1D3A)
                              ),),
                            ],
                          ),
                          Icon(Icons.people, color: Color(0xFF0E1D3A),)
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2-20,
                      height: (MediaQuery.of(context).size.width/2-20) * 0.6,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFAD8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Kayıtlı Araç", style: TextStyle(
                                      fontFamily: "Verdana",
                                      fontSize: 16,
                                      color: Color(0xFF12C8F5)
                                  ),),
                                  Text("Sayısı", style: TextStyle(
                                      fontFamily: "Verdana",
                                      fontSize: 16,
                                      color: Color(0xFF12C8F5)
                                  ),),
                                ],
                              ),
                              Text("156,685", style: TextStyle(
                                  fontFamily: "Verdana",
                                  fontSize: 20,
                                  color: Color(0xFF12C8F5)
                              ),),
                            ],
                          ),
                          Icon(Icons.local_shipping, color: Color(0xFF12C8F5),)
                        ],
                      ),
                    ),
                  ],
                ),
                // Pasta diliminin gösterildiği kısım...
                // Container(
                //   width: 550,
                //   height: 450,
                //   padding: EdgeInsets.only(top: 50),
                //   child: pieChart(),
                // ),

                //Toplam beyan adedinin gösterildiği kısım...
                // Container(
                //   child: Text(
                //     'Toplam Beyan Sayısı: 350',
                //     style: TextStyle(
                //       fontFamily: "Verdana",
                //       fontSize: 20,
                //       color: Color(0xFF0B1C3A)
                //     ),
                //   ),
                // )
              ],
            )
          ),
          bottomNavigationBar: BottomBarWidget()
        )

    );
  }

  //  Current State of InnerDrawerState
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

  void _toggle()
  {
    _innerDrawerKey.currentState.toggle(
      // direction is optional
      // if not set, the last direction will be used
      //InnerDrawerDirection.start OR InnerDrawerDirection.end
        direction: InnerDrawerDirection.start
    );
  }

  void _logout()async{
    if(_isLoading) return;
    _isLoading = true;
    SharedPreferencesUtils.getInstance().then((pref)async{
      bool result = await pref.logoout();
      _isLoading = false;
      if(result)
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    });
  }
}

class Declerations{
  String name;
  int value;
  Color colorValue;

  Declerations(this.name, this.value, this.colorValue);
}
