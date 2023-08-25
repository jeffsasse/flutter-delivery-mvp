import 'package:flutter/material.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/model/declaration.dart';
import 'package:tobbund/model/products.dart';
import 'package:tobbund/repository/UserRepository.dart';


class SecondDetailsWidget extends StatefulWidget {
  final String trnNumber;
  final Declaration declaration;
  SecondDetailsWidget(this.trnNumber, this.declaration);
  @override
  _SecondDetailsWidgetState createState() => _SecondDetailsWidgetState();
}

class _SecondDetailsWidgetState extends State<SecondDetailsWidget> {
  final _titleStyle = TextStyle(color: Colors.grey);

  final _bodyStyle = TextStyle(color: Colors.black);

  Widget _itemWidget(Products _products, int number) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Card(
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "G.Tip",
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            _products.gtipNokta,
                            style: _bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Kalem No:",
                              style: _titleStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              number.toString(),
                              style: _bodyStyle,
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Parçalı:",
                              style: _titleStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              _products.parcali,
                              style: _bodyStyle,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Ticari Tanım",
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            _products.tanim,
                            style: _bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Kap Tipi",
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            _products.kapTipi ?? "",
                            style: _bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Kap Adet",
                            style: _titleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _products.kapAdet.toString() ?? "",
                            style: _bodyStyle,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Brüt kg",
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            _products.brut.toString(),
                            style: _bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Net kg",
                            style: _titleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _products.net.toString(),
                            style: _bodyStyle,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tutar",
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            _products.tutar.toString(),
                            style: _bodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Döviz",
                            style: _titleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _products.doviz,
                            style: _bodyStyle,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Products>>(
      future: _getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = List.generate(snapshot.data.length, (i) {
            return _itemWidget(snapshot.data[i], i + 1);
          });
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

  Future<List<Products>> _getData() async {
    List<Products> _products = [];
    const String endpoint = "GetProducts";
//    var params = {
//      "trnNumber": widget.refNumber,
//      "firmId": UserRepository().user.sirketId
//    };

    var params = {
      "trnNumber": widget.trnNumber,
      "sirketId": widget.declaration.sirketId,
    };
    var response = await ApiHelper().doListPostRequest(endpoint, params);
    print(response);
    for (var item in response) {
      _products.add(Products.fromJson(item));
    }
    print(_products.length);
    return _products;
  }
}
