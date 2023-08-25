import 'package:flutter/material.dart';
import 'package:tobbund/screens/home.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF187EA0),
        title: Text("Raporlar", style: TextStyle(fontFamily: "Verdana"),),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => SecondDetailsDeclerationPage()));
                  },
                  child: Icon(
                    Icons.check,
                    size: 28.0,
                  ),
                )),
          ],
      ),
    );
  }
}
