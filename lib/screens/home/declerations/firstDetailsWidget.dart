import 'package:flutter/material.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/model/declaration.dart';
import 'package:tobbund/model/positionDetails.dart';
import 'package:tobbund/repository/UserRepository.dart';

class FirstDetailsWidget extends StatefulWidget {
  final String trnNumber;
  final Declaration declaration;
  FirstDetailsWidget(this.trnNumber, this.declaration);
  @override
  _FirstDetailsWidgetState createState() => _FirstDetailsWidgetState();
}

class _FirstDetailsWidgetState extends State<FirstDetailsWidget> {
  Widget _hareketWidget(PositionDetails _positionDetails) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 0, left: 10, right: 10),
      child: Stack(
        alignment: Alignment(-1.005, -1),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            padding: EdgeInsets.only(top: 20, bottom: 40),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF0B40A2), width: 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _ItemWidget('Gümrük', _positionDetails.hareketGumrugu ?? "", true),
                Divider(
                  color: Colors.grey,
                ),
                _ItemWidget('Ülke', _positionDetails.hareketUlkesi ?? "", true),
                Divider(
                  color: Colors.grey,
                ),
                _ItemWidget('Gönderici', _positionDetails.gonderici ?? "", true),
                Divider(
                  color: Colors.grey,
                ),
                _ItemWidget(
                    'Gönderici Adres', _positionDetails.gondericiAdres ?? "", true),
                Divider(
                  color: Colors.grey,
                ),
                _ItemWidget(
                    'Eşyanın Bulunduğu Yer', "", false),
              ],
            ),
          ),
          Container(
            width: 100,
            padding: EdgeInsets.only(top: 5, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              "Hareket",
              style: TextStyle(
                  color: Color(0xFF0B40A2),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ItemWidget(String title, String subtitle, bool editable) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  subtitle,
                ),
              ),
              editable?Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ):Container()
            ],
          ),
        ],
      ),
    );
  }

  Widget _varisWidget(PositionDetails _positionDetails) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 20, left: 10, right: 10),
      child: Stack(
        alignment: Alignment(-1.005, -1),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            padding: EdgeInsets.only(top: 20, bottom: 40),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF0B40A2), width: 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _ItemWidget(
                    'Son Gümrük', _positionDetails.transitinSonGumrugu ?? "", true),
                Divider(
                  color: Colors.grey,
                ),
                _ItemWidget('Ülke', _positionDetails.gidecegiUlke ?? "", true),
                Divider(
                  color: Colors.grey,
                ),
                _ItemWidget('Alıcı', _positionDetails.alici ?? "", true),
                Divider(
                  color: Colors.grey,
                ),
                _ItemWidget('Alıcı Adres', _positionDetails.aliciAdres ?? "", true),
              ],
            ),
          ),
          Container(
            width: 100,
            padding: EdgeInsets.only(top: 5, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              "Varış",
              style: TextStyle(
                  color: Color(0xFF0B40A2),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PositionDetails>>(
      future: _getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context,
          AsyncSnapshot<List<PositionDetails>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = snapshot.data
              .map((data) => Column(
                    children: <Widget>[
                      _hareketWidget(data),
                      _varisWidget(data),
                    ],
                  ))
              .toList();
        } else if (snapshot.hasError) {
          children = <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: CircularProgressIndicator(),
              width: 30,
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Sonuç bekleniyor..'),
            )
          ];
        }
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  Future<List<PositionDetails>> _getData() async {
    List<PositionDetails> _PositionDetails = [];
    const String endpoint = "GetPositionDetails";

    var params = {
      "trnNumber": widget.trnNumber,
      "firmId": widget.declaration.sirketId
    };
    var response = await ApiHelper().doListPostRequest(endpoint, params);
    print(response);
    for (var item in response) {
      _PositionDetails.add(PositionDetails.fromJson(item));
    }
    print(_PositionDetails.length);
    return _PositionDetails;
  }
}
