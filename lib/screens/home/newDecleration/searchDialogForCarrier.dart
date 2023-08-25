import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tobbund/model/company.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/repository/UserRepository.dart';

class SearchDialogForCarrier extends StatefulWidget {
  final Map<String, dynamic> company;
  SearchDialogForCarrier({this.company});
  @override
  _SearchDialogForCarrierState createState() => _SearchDialogForCarrierState();
}

class _SearchDialogForCarrierState extends State<SearchDialogForCarrier> {
  final _searchController = new TextEditingController();
  List<Company> _companies = [];
  bool _isSearching = false;
  bool _isLoading = false;
  String _searchKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchKey = "";
    _search();
  }

  //Future _search(String _txt)async{
    Future _search() async{
    _isLoading = true;
    _isSearching = true;
    setState(() {

    });
    //Map<String, dynamic> _param = {"companyName": _txt, "firmId": UserRepository().user.sirketId};
    Map<String, dynamic> _param = {
      "companyName": _searchKey,
      "firmId": widget.company['sirkatId']};
    String _endpoint = "GetCarriers";

    var response = await ApiHelper().doListPostRequest(_endpoint, _param);
    _companies = [];
    for(var item in response){
      Company _company = new Company.fromJson(item);
      _companies.add(_company);
    }
    _isSearching = false;
    setState(() {
    });
  }

  Widget _searchWidget(){
    return TextField(
      style: TextStyle(
          color: Colors.black
      ),
      autofocus: true,
      controller: _searchController,
      onChanged: (val)async{
        if(val.length == 2){
          _companies = [];
          setState(() {

          });
          return;
        }
        if(val.length < 3)return;
        _searchKey = val;
        await _search();
      },
      decoration: InputDecoration(
        hintText: "Taşıyıcı ara",
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
                        Text("TR/VKN:${data.vergiNo}", style: TextStyle(fontSize: 12),),
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
}