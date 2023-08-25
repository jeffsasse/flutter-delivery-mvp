import 'package:flutter/material.dart';
import 'package:tobbund/screens/bottombar.dart';
import 'package:tobbund/screens/home/declerations/zeroDetailsWidget.dart';
import 'firstDetailsWidget.dart';
import 'secondDetailsWidget.dart';
import 'dart:io' show Platform;
import 'package:tobbund/model/declaration.dart';

class DeclerationDetailsPage extends StatefulWidget {
  final String trnNumber;
  final String lrn_mrn;
  Declaration declaration;
  DeclerationDetailsPage({this.trnNumber, this.lrn_mrn, this.declaration});

  @override
  _DeclerationDetailsPageState createState() => _DeclerationDetailsPageState();
}

class _DeclerationDetailsPageState extends State<DeclerationDetailsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  Widget _tabWidget() {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
                color: Colors.grey[200],
                height: 40,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelPadding: EdgeInsets.all(0),
                  indicatorPadding: EdgeInsets.all(0),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Color(0xFF0B40A2),
                      border: Border.all(color: Colors.grey)),
                  indicatorWeight: 1,
                  tabs: [
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                BorderSide(color: Colors.white, width: 2))),
                        child: Text("Is Emri"),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Colors.white, width: 2))),
                        child: Text("Beyanname"),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Colors.white, width: 2))),
                        child: Text("Kalem"),
                      ),
                    ),
                  ],
                )),
            Divider(
              color: Colors.grey[700],
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  (Platform.isIOS ? 231 : 204),
              child: TabBarView(controller: _tabController, children: [
                ZeroDetailsWidget(declaration: widget.declaration, trnNum: widget.trnNumber,),
                FirstDetailsWidget(widget.trnNumber, widget.declaration),
                SecondDetailsWidget(widget.trnNumber, widget.declaration),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      print("Listen");
      print(_tabController.index);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF187EA0),
          title: Text("Beyan Detayı"),
        ),
        body: Container(
          child: Column(children: <Widget>[
            SizedBox(height: 10,),
            _tabWidget()
          ]),
        ),
        bottomNavigationBar: BottomBarWidget(
          pageIndex: 0,
        ));
  }
}
