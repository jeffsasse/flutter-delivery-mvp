import 'package:flutter/material.dart';
import 'package:tobbund/controller/connectivity_provider.dart';
import 'package:tobbund/screens/home.dart';
import 'package:tobbund/model/user.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/controller/localAuth.dart';
import 'package:tobbund/screens/home/declerationsPage.dart';
import 'package:tobbund/widgets/loading.dart';
import 'package:tobbund/repository/UserRepository.dart';
import 'package:toast/toast.dart';
import 'dart:io';

//login screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  bool _isLoading = false;

  // Start //

  //email input field
  Widget _EmailField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
              validator: (value){
                String pattern =
                    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                RegExp regExp = new RegExp(pattern);
                if (value.isEmpty) {
                  return "E-Posta adresinizi kontrol ediniz.";
                } else if (!regExp.hasMatch(value)) {
                  return "Hatalı E-Posta adresi";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "E - Posta",
                  hintStyle: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: "Verdana",
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey[400], width: 0.5)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey[700], width: 0.5)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.red[400], width: 1)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.red[400], width: 0.5)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  //password input field
  Widget _PasswordField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _passwordController,
              validator: (value){
                if(value.isEmpty){
                  return "Şifre girmeniz gerekiyor.";
                }else if(value.length < 6){
                  return "Hatalı şifre.";
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Şifre",
                  hintStyle: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: "Verdana",
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey[400], width: 0.5)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey[700], width: 0.5)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.red[400], width: 0.5)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.red[400], width: 1)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  // Other Buttons //
  Widget _ButtonsField() {

  // End //

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
              height: 35,
              width: 100,
              child: FlatButton(
                color: Color(0xff009BD4),
                onPressed: _login,
                child: Text("Giriş", style: TextStyle(color: Colors.white, fontFamily: "Verdana"),),
              ),
            ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: (){},
                    child: Text("Şifre Unuttum?",
                      style: TextStyle(
                          color: Color(0xff0D1C3B),
                          fontSize: 14,
                          fontFamily: "Verdana"
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  InkWell(
                    onTap: (){},
                    child: Text("Yeni Üyelik Başvurusu",
                      style: TextStyle(
                        color: Color(0xff0D1C3B),
                        fontSize: 14,
                        fontFamily: "Verdana"
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

 @override
    void initState() {
      _emailController.text = "serkan.erkan@ekol.com.tr";
      _passwordController.text = "4442322";
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    dialogcontext = context;
    return WillPopScope(
      onWillPop: (){
        exit(1);
        return null;
      },
      child: _isLoading?
      LoadingWidget():
      Scaffold(
        appBar: PreferredSize(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 150.0),
                child: Image.asset(
                  "assets/images/logo-tagline-skyblue.png",
                  width: 275.0,
                ),
            ),
          ],
        ), 
          preferredSize: Size.fromHeight(1000)
        ),
          body: SingleChildScrollView(
            child: Container(
              child: Container(
                child:  Container(
                    child: Form(
                      key: _formKey,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 25,),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Text("Giriş", style: TextStyle(
                                //     color: Colors.grey[600],
                                //     fontFamily: "Verdana",
                                //     fontSize: 24,
                                //     fontWeight: FontWeight.w500
                                // ),),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFE496),
                                      border: Border.all(color: Color(0xFFEF9000), width: 0.5),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: <Widget>[
                                      // Text("Hoşgeldiniz", style: TextStyle(
                                      //       color: Colors.blue[900],
                                      //       fontFamily: "Verdana",
                                      //       fontSize: 20,
                                      //       fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      Text("Giriş", style: TextStyle(
                                      color: Color(0xFF0E1D3A),
                                      fontFamily: "Verdana Bold",
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500
                                      ),),
                                      _EmailField(),
                                      _PasswordField(),
                                      _ButtonsField()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),
            ),
          )
      ),
    );
  }

  void _login()async{
    FocusScope.of(context).requestFocus(new FocusNode());
//    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      Map<String, String> _params = {
        "username": _emailController.text,
        "password": _passwordController.text
      };
      String _endPoint = "login";
      var response = await ApiHelper().doBodyPostRequest(_endPoint, _params);
      print(response);

      if(response['status'] != "failed"){
        UserRepository().user = User.fromJson(response);
        print("sessionId");
        String _sessionId = response["session_id"];
        SharedPreferencesUtils.getInstance().then((pref){
          pref.saveLoginInfo(_sessionId);
        });
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => DeclerationsPage()
        ), ModalRoute.withName('/'),);
        return;
      }else{
        Toast.show("Hatalı Kullanıcı", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }
}