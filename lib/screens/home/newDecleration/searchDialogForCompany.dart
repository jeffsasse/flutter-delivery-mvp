import 'package:flutter/material.dart';
import 'package:tobbund/model/company.dart';
import 'package:tobbund/controller/apiHelper.dart';

class SearchDialogForCompany extends StatefulWidget {
  @override
  _SearchDialogForCompanyState createState() => _SearchDialogForCompanyState();
}

class _SearchDialogForCompanyState extends State<SearchDialogForCompany> {
  final _searchController = new TextEditingController();
  List<Company> _companies = [];
  bool _isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Widget _searchWidget(){
    return TextField(
      style: TextStyle(
          color: Colors.black
      ),
      autofocus: true,
      controller: _searchController,
      onChanged: (val){
        if(val.length == 2){
          _companies = [];
          setState(() {

          });
          return;
        }
        if(val.length < 3)return;
        _search(val);
      },
      decoration: InputDecoration(
        hintText: "Ara...",
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 10, right: 10),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }

  Widget _searchResultWidget(){
    return Container(
      child:  _isSearching?
      Container(
        padding: EdgeInsets.all(30),
        child: Text("Aranıyor...", style: TextStyle(
            color: Colors.grey
        ),),
      ):Column(
        children: _companies.map((data){
          return
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 2,),
                  ListTile(
                    onTap: (){
                      Map<String, dynamic> company = {};
                      company['name'] = data.unvan;
                      company['id'] = data.id;
                      company['firmaId'] = data.sirketId;
                      Navigator.of(context).pop(company);
                    },
                    title: Text(data.unvan),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Text("TR/VKN:${data.sirketId}", style: TextStyle(fontSize: 12),),
                        SizedBox(height: 10,),
                        Text("${data.adres}")
                      ],
                    ),
                  ),
                  SizedBox(height: 2,),
                  Container(
                    color: Colors.grey[300],
                    height: 1,
                  ),
                ],
              ),
            );
        }).toList(),
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
                SizedBox(height: 50,),
                _searchResultWidget(),
              ],
            ),

          _searchWidget(),
        ],
      )
    );
  }

  _search(String _txt)async{
    _isSearching = true;
    setState(() {

    });
    Map<String, dynamic> _param = {"companyName": _txt};
    String _endpoint = "GetCompanies";
    _companies = [];
    var response = await ApiHelper().doListPostRequest(_endpoint, _param);
    for(var item in response){
      Company _company = new Company.fromJson(item);
      _companies.add(_company);
    }
    _isSearching = false;
    setState(() {

    });
  }
}