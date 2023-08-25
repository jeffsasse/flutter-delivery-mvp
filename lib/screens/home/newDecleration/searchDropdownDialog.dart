import 'package:flutter/material.dart';
import 'package:tobbund/controller/apiHelper.dart';

class SearchDropdownDialog extends StatefulWidget {
  final String endpoint;
  final String target;
  final Map<String, dynamic> params;
  final String searchTarget;
  final bool nonSearchable;
  SearchDropdownDialog({this.endpoint, this.target, this.params, this.searchTarget, this.nonSearchable=false});
  @override
  _SearchDropdownDialogState createState() => _SearchDropdownDialogState();
}

class _SearchDropdownDialogState extends State<SearchDropdownDialog> {
  final _searchController = new TextEditingController();
  List<Map<String, dynamic>> _resuls = [];
  bool _isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.params != null){
      String _searchText = "";
      _searchText = widget.params[widget.searchTarget]??"";
      _search(widget.params[widget.searchTarget]);
    }
    else
      _search("");
  }

  Widget _searchWidget(){
    return TextField(
      style: TextStyle(
          color: Colors.black
      ),
      autofocus: true,
      controller: _searchController,
      onChanged: (val){
        if(val.length == 1){
          _resuls = [];
          setState(() {

          });
          return;
        }
        if(val.length < 2)return;
        _search(val);
      },
      decoration: InputDecoration(
        hintText: "Ara",
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
        children: _resuls.map((data){
          return
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: (){
                      Navigator.pop(context, data);
                    },
                    title: Text(data[widget.target]??""),
                  ),
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
                widget.nonSearchable?Container():SizedBox(height: 50,),
                _searchResultWidget(),
              ],
            ),

            widget.nonSearchable?Container():_searchWidget(),
          ],
        )
    );
  }

  _search(String _txt)async{
    if(widget.endpoint==null)return;
    _isSearching = true;
    setState(() {

    });
    Map<String, dynamic> _param = widget.params??{};
    if(widget.searchTarget != null)
      _param[widget.searchTarget] = _txt;
    String _endpoint = widget.endpoint;
    var response = await ApiHelper().doListPostRequest(_endpoint, _param);
    _resuls = [];
    for(var item in response){
      _resuls.add(item);
    }
    _isSearching = false;
    setState(() {

    });
  }
}
