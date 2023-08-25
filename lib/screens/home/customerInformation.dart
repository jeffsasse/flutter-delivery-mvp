import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tobbund/repository/UserRepository.dart';
import 'package:tobbund/screens/bottombar.dart';
import 'package:tobbund/screens/home.dart';
import 'package:tobbund/controller/apiHelper.dart';

class CustomerInformation extends StatefulWidget {
  @override
  _CustomerInformationState createState() => _CustomerInformationState();
}

class _CustomerInformationState extends State<CustomerInformation> {
  final _companyNameController = new TextEditingController();
  final _taxNumberController = new TextEditingController();
  final _eoriNumberController = new TextEditingController();
  final _addressController = new TextEditingController();
  final _postCodeController = new TextEditingController();

  @override
  void initState() {
    _search(UserRepository().user.ticaretUnvani);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF187EA0),
        title: Text("Müşteri Bilgileri", style: TextStyle(fontFamily: "Verdana"),),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              TextField(
                controller: _companyNameController,
                enabled: false,
                style: TextStyle(fontFamily: "Verdana"),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.business,
                    color: Colors.grey[700],
                  ),
                  labelText: "Ünvan",
                ),
              ),
              TextField(
                controller: _taxNumberController,
                enabled: false,
                style: TextStyle(fontFamily: "Verdana"),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.work,
                    color: Colors.grey[700],
                  ),
                  labelText: 'Vergi Numarası',
                ),
              ),
              TextField(
                controller: _eoriNumberController,
                enabled: false,
                style: TextStyle(fontFamily: "Verdana"),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.business_center,
                    color: Colors.grey[700],
                  ),
                  labelText: 'Eori Numarası',
                ),
              ),
              TextField(
                controller: _addressController,
                enabled: false,
                style: TextStyle(fontFamily: "Verdana"),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.grey[700],
                  ),
                  labelText: 'Adres',
                ),
                maxLines: 2,
              ),
              TextField(
                controller: _postCodeController,
                enabled: false,
                style: TextStyle(fontFamily: "Verdana"),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.pin_drop,
                    color: Colors.grey[700],
                  ),
                  labelText: 'Posta Kodu',
                ),
              ),
            ],
          )),
      bottomNavigationBar: BottomBarWidget(
        pageIndex: 2,
      ),
    );
  }

  _search(String _txt) async {
    Map<String, dynamic> _param = {"companyName": _txt};
    String _endpoint = "GetCompanies";
    var response = await ApiHelper().doListPostRequest(_endpoint, _param);
    for (var item in response) {
      setState(() {
        _companyNameController.text = item['unvan'];
        _taxNumberController.text = item['vergiNo'];
        _eoriNumberController.text = item['eoriNo'];
        _addressController.text = item['adres'];
        _postCodeController.text = item['postaKodu'];
      });
    }
  }
}
