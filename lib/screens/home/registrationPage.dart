import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tobbund/controller/localAuth.dart';
import 'package:tobbund/screens/login.dart';
import 'package:tobbund/screens/sidebarItemScreens/administrativeFunctionsScreen.dart';
import 'package:tobbund/screens/sidebarItemScreens/accountScreen.dart';
import 'package:tobbund/screens/sidebarItemScreens/registrationProcedures.dart';
import 'package:tobbund/screens/sidebarItemScreens/helpSupportScreen.dart';
import 'package:tobbund/screens/sidebarItemScreens/regulationScreen.dart';
import 'package:tobbund/screens/sidebarItemScreens/reportScreen.dart';
import 'package:tobbund/screens/sidebarItemScreens/settingScreen.dart';
import 'package:tobbund/screens/sidebar.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context)
  {
    return InnerDrawer(
        key: _innerDrawerKey,
        onTapClose: true, // default false
        swipe: true, // default true
        colorTransition: Colors.white, // default Color.black54
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
        backgroundColor: Color(0xFF405161), // default  Theme.of(context).backgroundColor

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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationProcedures()));
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
          backgroundColor: Colors.grey[100],
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
                  child: Icon(Icons.menu, color: Color(0xffFFCC1A), size: 35,),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 50, right: 20, bottom: 10
                ),
                child: Image.asset("assets/images/logo.png",),
              ),
            ],
          ), preferredSize: Size.fromHeight(80)),
          body:  SlidingUpPanel(
              renderPanelSheet: false,
              minHeight: 30,
              maxHeight: 170,
              panel: Container(
                  color: Color(0xFF405161),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: Icon(Icons.drag_handle, color: Colors.white, size: 30,),
                      ),
                      Container(
                        height: 140,
                        child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 20
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.grey,
                                        width: 50,
                                        height: 50,
                                      ),
                                      Container(
                                        color: Colors.grey,
                                        width: 50,
                                        height: 50,
                                      ),
                                      Container(
                                        color: Colors.grey,
                                        width: 50,
                                        height: 50,
                                      ),
                                      Container(
                                        color: Colors.grey,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 20
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.grey,
                                        width: 50,
                                        height: 50,
                                      ),
                                      Container(
                                        color: Colors.grey,
                                        width: 50,
                                        height: 50,
                                      ),
                                      Container(
                                        color: Colors.grey,
                                        width: 50,
                                        height: 50,
                                      ),
                                      Container(
                                        color: Colors.grey,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    ],
                  )
              ),
              collapsed: Container(
                color: Color(0xFF405161),
                child: Icon(Icons.drag_handle, color: Colors.white, size: 30,),
              ),
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
                          color: Color(0xFFFFF0C3),
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
                                    Text("Explicit", style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 16,
                                        color: Color(0xffED9B21)
                                    ),),
                                    Text("Declarations", style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 16,
                                        color: Color(0xffED9B21)
                                    ),),
                                  ],
                                ),
                                Text("1,668", style: TextStyle(
                                    fontFamily: "Helvetica",
                                    fontSize: 16,
                                    color: Color(0xffED9B21)
                                ),),
                              ],
                            ),
                            Icon(Icons.library_books, color: Color(0xffED9B21),)
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2-20,
                        height: (MediaQuery.of(context).size.width/2-20) * 0.6,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xFFA0C9F2),
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
                                    Text("Active", style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 16,
                                        color: Color(0xff0B62B7)
                                    ),),
                                    Text("Declarations", style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 16,
                                        color: Color(0xff0B62B7)
                                    ),),
                                  ],
                                ),
                                Text("7,685", style: TextStyle(
                                    fontFamily: "Helvetica",
                                    fontSize: 16,
                                    color: Color(0xff0B62B7)
                                ),),
                              ],
                            ),
                            Icon(Icons.event_note, color: Color(0xff0B62B7),)
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
                          color: Color(0xFFA0C9F2),
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
                                    Text("Registered", style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 16,
                                        color: Color(0xff0B62B7)
                                    ),),
                                    Text("Business", style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 16,
                                        color: Color(0xff0B62B7)
                                    ),),
                                    Text("Partners", style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 16,
                                        color: Color(0xff0B62B7)
                                    ),),
                                  ],
                                ),
                                Text("22,170", style: TextStyle(
                                    fontFamily: "Helvetica",
                                    fontSize: 16,
                                    color: Color(0xff0B62B7)
                                ),),
                              ],
                            ),
                            Icon(Icons.event_note, color: Color(0xff0B62B7),)
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2-20,
                        height: (MediaQuery.of(context).size.width/2-20) * 0.6,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xFFA0C9F2),
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
                                    Text("Registered", style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 16,
                                        color: Color(0xff0B62B7)
                                    ),),
                                    Text("Vehicles", style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontSize: 16,
                                        color: Color(0xff0B62B7)
                                    ),),
                                  ],
                                ),
                                Text("156,685", style: TextStyle(
                                    fontFamily: "Helvetica",
                                    fontSize: 16,
                                    color: Color(0xff0B62B7)
                                ),),
                              ],
                            ),
                            Icon(Icons.event_note, color: Color(0xff0B62B7),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
          bottomNavigationBar: Platform.isIOS?
          Container(
            height: 100,
            padding: EdgeInsets.only(top: 10),
            color: Color(0xFF0B52A2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Image.asset("assets/images/registration.png",fit: BoxFit.contain, color: Colors.white,),
                          ),
                          SizedBox(height: 5,),
                          Text("Registration List", style: TextStyle(color: Colors.white, fontFamily: "Helvetica", fontSize: 12),)
                        ],
                      )
                  ),
                ),

                ///////////
                InkWell(
                  onTap: (){},
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 40,
                            child: Image.asset("assets/images/decleration.png",fit: BoxFit.contain, color: Colors.white,),
                          ),
                          SizedBox(height: 5,),
                          Text("New Decleration", style: TextStyle(color: Colors.white, fontFamily: "Helvetica", fontSize: 12),)
                        ],
                      )
                  ),
                ),

                //////////
                InkWell(
                  onTap: (){},
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Image.asset("assets/images/client.png",fit: BoxFit.contain, color: Colors.white,),
                          ),
                          SizedBox(height: 5,),
                          Text("Client Data", style: TextStyle(color: Colors.white, fontFamily: "Helvetica", fontSize: 12),)
                        ],
                      )
                  ),
                ),

                //////////
                InkWell(
                  onTap: (){},
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Image.asset("assets/images/invoice.png",fit: BoxFit.contain, color: Colors.white,),
                          ),
                          SizedBox(height: 5,),
                          Text("Invoice Report", style: TextStyle(color: Colors.white, fontFamily: "Helvetica", fontSize: 12),)
                        ],
                      )
                  ),
                )
              ],
            ),
          ):
          Container(
            height: 80,
            padding: EdgeInsets.only(top: 10),
            color: Color(0xFF0B52A2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Image.asset("assets/images/registration.png",fit: BoxFit.contain,),
                          ),
                          SizedBox(height: 5,),
                          Text("Registration List", style: TextStyle(color: Colors.white, fontFamily: "Helvetica", fontSize: 12),)
                        ],
                      )
                  ),
                ),

                ///////////
                InkWell(
                  onTap: (){},
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 40,
                            child: Image.asset("assets/images/decleration.png",fit: BoxFit.contain,),
                          ),
                          SizedBox(height: 5,),
                          Text("New Decleration", style: TextStyle(color: Colors.white, fontFamily: "Helvetica", fontSize: 12),)
                        ],
                      )
                  ),
                ),

                //////////
                InkWell(
                  onTap: (){},
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Image.asset("assets/images/client.png",fit: BoxFit.contain,),
                          ),
                          SizedBox(height: 5,),
                          Text("Client Data", style: TextStyle(color: Colors.white, fontFamily: "Helvetica", fontSize: 12),)
                        ],
                      )
                  ),
                ),

                //////////
                InkWell(
                  onTap: (){},
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Image.asset("assets/images/invoice.png",fit: BoxFit.contain,),
                          ),
                          SizedBox(height: 5,),
                          Text("Invoice Report", style: TextStyle(color: Colors.white, fontFamily: "Helvetica", fontSize: 12),)
                        ],
                      )
                  ),
                )
              ],
            ),
          ),
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