import 'package:flutter/material.dart';
import 'package:tobbund/repository/UserRepository.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _companyController = new TextEditingController();
  final _nameSurnameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _authorityLevelController = new TextEditingController();

  @override
  void initState() {
    _companyController.text = UserRepository().user.ticaretUnvani;
    _nameSurnameController.text = UserRepository().user.adiSoyadi;
    _emailController.text = UserRepository().user.email;
    if (UserRepository().user.yetkiDuzeyi == 1 &&
        UserRepository().user.superUser == false) {
      _authorityLevelController.text = "Standart Kullanıcı";
    } else if (UserRepository().user.yetkiDuzeyi == 2 &&
        UserRepository().user.superUser == false) {
      _authorityLevelController.text = "Yetkili Kullanıcı";
    } else if (UserRepository().user.yetkiDuzeyi == 3 &&
        UserRepository().user.superUser == false) {
      _authorityLevelController.text = "Üst Düzey Kullanıcı";
    } else {
      _authorityLevelController.text = "Admin Kullanıcı";
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF187EA0),
        title: Text("Hesabım", style: TextStyle(fontFamily: "Verdana"),),
        
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
            TextField(
              controller: _companyController,
              enabled: false,
              style: TextStyle(fontFamily: "Verdana"),
              decoration: InputDecoration(
                icon: Icon(Icons.business),
                labelText: "Firma",
              ),
            ),

            TextField(
              controller: _nameSurnameController,
              enabled: false,
              style: TextStyle(fontFamily: "Verdana"),
              decoration: InputDecoration(
                icon: Icon(Icons.account_box),
                labelText: 'İsim - Soyisim',
              ),
            ),
            TextField(
              controller: _emailController,
              enabled: false,
              style: TextStyle(fontFamily: "Verdana"),
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email),
                labelText: 'E - Posta',
              ),
            ),
            TextField(
              controller: _authorityLevelController,
              enabled: false,
              style: TextStyle(fontFamily: "Verdana"),
              decoration: InputDecoration(
                icon: Icon(Icons.grade),
                labelText: 'Yetki Düzeyi',
              ),
          )]),
      ),
    );
  }
}
