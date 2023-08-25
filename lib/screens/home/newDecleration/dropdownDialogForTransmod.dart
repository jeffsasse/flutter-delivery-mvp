import 'package:flutter/material.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:flutter/cupertino.dart';

class DropdownDialogForTransmod extends StatefulWidget {
  @override
  _DropdownDialogForTransmodState createState() =>
      _DropdownDialogForTransmodState();
}

class _DropdownDialogForTransmodState extends State<DropdownDialogForTransmod> {
  List<String> _transMod = [];

  final Map<String, String> _tasimaModuMap = {
    "UND": "UN RoRo",
    "ULU": "Ulusoy",
    "SLS":"Sea Lines"
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void _init() async {
    var response =
        await ApiHelper().doListPostRequest('GetTransportMode', null);

    for (var item in response) {
      if (item['kod'] == 'UND' || item['kod'] == 'ULU' || item['kod'] == 'SLS')
        _transMod.add(item['kod']); // Burayi kod'a cevir.
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SingleChildScrollView(
      child: _transMod.isEmpty
          ? Container(
              height: 100,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: _transMod.map((val) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context, val);
                  },
                  title: Text(_tasimaModuMap[val]),
                );
              }).toList(),
            ),
    ));
  }
}
