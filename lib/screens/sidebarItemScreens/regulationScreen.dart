import 'package:flutter/material.dart';

class RegulationScreen extends StatefulWidget {
  @override
  _RegulationScreenState createState() => _RegulationScreenState();
}

class _RegulationScreenState extends State<RegulationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarife ve Mevzuat"),
      ),
    );
  }
}
