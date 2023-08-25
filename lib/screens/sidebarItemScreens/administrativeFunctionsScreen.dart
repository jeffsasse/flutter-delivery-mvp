import 'package:flutter/material.dart';

class AdministrativeFunctionsScreen extends StatefulWidget {
  @override
  _AdministrativeFunctionsScreenState createState() => _AdministrativeFunctionsScreenState();
}

class _AdministrativeFunctionsScreenState extends State<AdministrativeFunctionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF187EA0),
        title: Text("Yönetsel İşlevler"),
      ),
  );

  }
}