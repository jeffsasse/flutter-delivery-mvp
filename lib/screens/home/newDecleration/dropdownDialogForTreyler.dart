import 'package:flutter/material.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:tobbund/repository/UserRepository.dart';

class DropdownDialogForTreyler extends StatefulWidget {
  final Map<String, dynamic> company;
  DropdownDialogForTreyler({this.company});
  @override
  _DropdownDialogForTreylerState createState() =>
      _DropdownDialogForTreylerState();
}

class _DropdownDialogForTreylerState extends State<DropdownDialogForTreyler> {
  List<Map<String, dynamic>> _licenses;
  final _searchController = new TextEditingController();
  bool _isLoading = false;
  String _searchKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchKey = "34";
    _search();
  }

  Future _search() async {
    _isLoading = true;
    setState(() {});
    Map<String, dynamic> param = {
      "firmId": widget.company['firmaId'],
      "company": widget.company['id'],
      "type": 2,
      "licensePlate": _searchKey
    };
    var response =
        await ApiHelper().doListPostRequest('GetLicensePlates', param);
    print(response);
    _licenses = [];
    for (var item in response) {
      _licenses.add(item);
    }
    //print("0000000000000000000");
    print(_licenses);
    if (mounted)
      setState(() {
        _isLoading = false;
      });
  }

  Widget _searchWidget() {
    return TextField(
      style: TextStyle(color: Colors.black),
      autofocus: true,
      controller: _searchController,
      onChanged: (val) async {
        _searchKey = val;
        if (val.length == 0) _searchKey = "34";
        await _search();
      },
      decoration: InputDecoration(
        hintText: "Ara",
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 10, right: 10),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            _isLoading
                ? Container(
                    height: 100,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : (_licenses == null
                    ? Container()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _licenses.map((val) {
                          return ListTile(
                            onTap: () {
                              Navigator.pop(context, val['plakaNo']);
                              //Navigator.pop(context, val['plaka']);
                            },
                            title: Text(val['plakaNo']),
                            //title: Text(val['plaka']),
                          );
                        }).toList(),
                      ))
          ],
        ),
        _searchWidget(),
      ],
    ));
  }
}
