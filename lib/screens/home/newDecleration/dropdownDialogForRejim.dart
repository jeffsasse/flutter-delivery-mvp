import 'package:flutter/material.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:flutter/cupertino.dart';

class DropdownDialogForRejim extends StatefulWidget {
  @override
  _DropdownDialogForRejimState createState() => _DropdownDialogForRejimState();
}

class _DropdownDialogForRejimState extends State<DropdownDialogForRejim> {
  List<String> _regimeCodes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void _init()async{
    var response = await ApiHelper().doBodyPostRequest('GetRegimeCodes', null);
    if(response['name'] == null){
      return;
    }
    for(var item in response['name']){
      if(item == "ENS")
      _regimeCodes.add(item);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: _regimeCodes.isEmpty?
        Container(
          height: 100,
          child: Center(
            child:  CupertinoActivityIndicator(),
          ),
        ):
        Column(
          mainAxisSize: MainAxisSize.min,
          children: _regimeCodes.map((val){
            return ListTile(
              onTap: (){
                if(val != "ENS") return;
                Navigator.pop(context, val);
              },
              title: Text(val),
            );
          }).toList(),
        ),
      )
    );
  }
}
