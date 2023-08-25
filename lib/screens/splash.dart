import 'package:flutter/material.dart';
import 'package:tobbund/controller/connectivity_provider.dart';
import 'package:tobbund/screens/login.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  Animation animation, delayedAnimation, muchDelayAnimation, transfor,fadeAnimation;
  AnimationController animationController;


  @override
  void initState(){
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    animation = Tween(begin: 0.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn
    ));

    transfor = BorderRadiusTween(
        begin: BorderRadius.circular(125.0),
        end: BorderRadius.circular(0.0)).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease)
    );
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    new Timer(new Duration(seconds: 3), ()async{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (Route<dynamic> route) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dialogcontext = context;
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            body: new Container(
              decoration: new BoxDecoration(color: Color(0xff0D1C3B)),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          // padding: EdgeInsets.all(25.0),
                          child: Image.asset(
                            "assets/images/logo-tagline-skyblue.png",
                            width: 450.0,
                          ),
                        ),
                        // SizedBox(height: 80,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: <Widget>[
                        //     Text("NCTS", style:
                        //     TextStyle(
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 50,
                        //     ),),
                        //     Container(
                        //       padding: EdgeInsets.only(bottom: 5),
                        //       child: Text("mobil",
                        //         style:
                        //       TextStyle(
                        //           color: Colors.white, fontWeight: FontWeight.w500, fontSize: 35,
                        //           fontFamily: "Helvetica"),),
                        //     ),
                        //   ],
                        // ),

                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   child: Image.asset("assets/images/bottomimg.png"),
                        // ),
                        SizedBox(height: 30,),
                        Container(
                          alignment: Alignment.bottomCenter,
                          // padding: EdgeInsets.only(bottom: 15),
                          child: Text("v1.0", style: TextStyle(color: Color(0xff009BD4)),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
