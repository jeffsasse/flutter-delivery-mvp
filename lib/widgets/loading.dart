import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // children: <Widget>[
              //   Container(
              //     padding: EdgeInsets.only(top: 50, right: 20, bottom: 10),
              //     child: Image.asset("assets/images/logo.png"),
              //   ),
              // ],
            ),
            preferredSize: Size.fromHeight(45)),
        body: Center(
            child: Container(
          height: 60,
          margin: EdgeInsets.all(100),
          child: Image.asset("assets/images/spinner.gif"),
        )));
  }
}
