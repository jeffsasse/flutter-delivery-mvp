import 'package:flutter/material.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/model/declaration.dart';
import 'package:tobbund/screens/bottombar.dart';
import 'package:tobbund/model/TRNItem.dart';
import 'package:tobbund/screens/home/newDecleration/addDeclarationScreen.dart';
import 'declerationDetailsPage.dart';
import 'package:tobbund/repository/UserRepository.dart';

class DeclerationPreviousDetailsPage extends StatefulWidget {
  final List<TRNItem> trns;
  final Declaration declaration;
  DeclerationPreviousDetailsPage({this.trns, this.declaration});

  @override
  _DeclerationPreviousDetailsPageState createState() => _DeclerationPreviousDetailsPageState();
}

class _DeclerationPreviousDetailsPageState extends State<DeclerationPreviousDetailsPage> {

  Widget _TRNItemWidget(TRNItem data){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.6
          )
        )
      ),
      child: InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder:
              (context)=>
                  DeclerationDetailsPage(
                    trnNumber: data.ref,
                    lrn_mrn: data.lrn,
                    declaration: widget.declaration,
                  )
              )
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              child: Image.asset("assets/images/list.png", fit: BoxFit.cover,),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Kayıt Numarası',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text('${data.ref}',
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('LRN / MRN',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text('${data.lrn??""}',
                    style: TextStyle(
                        fontSize: 16
                    ),
                  )
                ],
              ),
            ),
            new Builder(builder: (context){
              if(data.lrn == null || data.lrn == "")
                return Container(
                  height: 30,
                  margin: EdgeInsets.only(bottom: 10
                  ),
                  child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    color: Color(0xFF007DB9),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDeclarationScreen(declaration: widget.declaration, trnItem: data,)));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.edit, color: Colors.white70, size: 18,),
                        Text("Güncelle", style: TextStyle(color: Colors.white70, ),)
                      ],
                    ),
                  ),
                );
              if(data.lrn.contains("LR"))
                return Container(
                  height: 30,
                  margin: EdgeInsets.only(bottom: 10
                  ),
                  child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    color: Color(0xFF007DB9),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDeclarationScreen(declaration: widget.declaration, trnItem: data,)));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.edit, color: Colors.white70, size: 18,),
                        Text("Güncelle", style: TextStyle(color: Colors.white70, ),)
                      ],
                    ),
                  ),
                );
              return Container();
            }),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF187EA0),
          title: Text("${widget.declaration.id} / Beyan Listesi",
            style: TextStyle(fontSize: 16),
          ),
        ),
        body:  widget.trns.isEmpty?
        Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child:  Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                height: 200,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.info_outline, color: Colors.blue, size: 45,),
                    SizedBox(height: 10,),
                    Container(
                      child: Text("Bilgi", style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      child: Text('Bu pozisyon içerisinde beyan yoktur.\nSağ alttaki \"artı\" butonundan beyan ekleyebilirsiniz.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ):
        SingleChildScrollView(
            child: Container(
              child: Column(
                  children: widget.trns.map((data){
                    return _TRNItemWidget(data);
                  }).toList()
              ),
            )
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF007DB9),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDeclarationScreen(declaration: widget.declaration,)));
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomBarWidget(pageIndex: 0,)
    );
  }

}
