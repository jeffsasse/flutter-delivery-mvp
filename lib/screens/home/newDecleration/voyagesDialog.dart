import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/model/voyages.dart';

class VoyagesDialog extends StatefulWidget {
  final String endpoint;
  VoyagesDialog({this.endpoint});
  @override
  _VoyagesDialogState createState() => _VoyagesDialogState();
}

class _VoyagesDialogState extends State<VoyagesDialog> {
  List<Voyages> _voyages = [];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: _isLoading
            ? Container(
          height: 100,
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        ):
        Column(
          children: _voyages.map((data) {
            return InkWell(
              onTap: (){
                Navigator.of(context).pop(data.toJson());
              },
              child: Container(
                padding: EdgeInsets.all(2),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex:2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Gemi Adi", style: TextStyle(fontSize: 12, color: Colors.blue[900]),),
                                    Text("${data.vesselName}"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Kalkis Yeri", style: TextStyle(fontSize: 12, color: Colors.blue[900]),),
                                    Text("${data.departurePort}"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Varis Yeri", style: TextStyle(fontSize: 12, color: Colors.blue[900]),),
                                    Text("${data.arrivalPort}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Kalkis Tarihi: ", style: TextStyle(fontSize: 12, color: Colors.blue[900]),),
                              Text("${data.departureDate}"),
                            ],
                          ),
                        ),
                        Container(
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Varis Tarihi  : ", style: TextStyle(fontSize: 12, color: Colors.blue[900]),),
                              Text("${data.arrivalDate}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      )
    );
  }

  _init()async{
    _isLoading = true;
    setState(() {});
    var response = await ApiHelper().doListPostRequest('${widget.endpoint}', {});
    for (var item in response) {
      _voyages.add(Voyages.fromJson(item));
    }

    if (mounted)
      setState(() {
        _isLoading = false;
      });
  }
}
