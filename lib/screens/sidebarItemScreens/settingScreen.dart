import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:tobbund/screens/home.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class Languages {
  int id;
  String lang;

    Languages(this.id, this.lang);

  static List<Languages> getLanguages(){
    return <Languages>[
      Languages(0, 'Türkçe'),
      Languages(1, 'İngilizce'),
      Languages(2, 'Almanca'),
      Languages(3, 'Fransızca'),
      Languages(4, 'Bulgarca'),
      Languages(5, 'Rusça'),
      Languages(6, 'İtalyanca'),
      Languages(7, 'Macarca'),
      Languages(8, 'Slovence'),
      Languages(9, 'Sırpça'),
      Languages(10, 'Romence'),
    ];
  }
}

class _SettingScreenState extends State<SettingScreen> {

bool _value = false;

void _onChanged(bool value){
  setState(() {
    _value = value;
  });
}

List<Languages> _languages = Languages.getLanguages();
List<DropdownMenuItem<Languages>> _dropdownMenuItems;
Languages _selectedLanguage;

  @override

  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_languages);
    _selectedLanguage = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Languages>> buildDropdownMenuItems(List langs) {
    List<DropdownMenuItem<Languages>> items = List();
    for (Languages lang in langs) {
      items.add(
        DropdownMenuItem(
          value: lang,
          child: Text(lang.lang),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Languages selectedLanguages) {
  setState(() {
    _selectedLanguage = selectedLanguages;
  });
}

// Widget _ButtonsField() {
//   // End //
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 20),
//       child: Column(
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 height: 40,
//                 width: 120,
//                 child: FlatButton(
//                   color: Colors.green,
//                   onPressed: (){},
//                   child: Text("Kaydet", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Helvetica"),),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF187EA0),
        title: Text("Ayarlar", style: TextStyle(fontFamily: "Verdana"),),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => SecondDetailsDeclerationPage()));
                  },
                  child: Icon(
                    Icons.check,
                    size: 28.0,
                  ),
                )),
          ],
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(5.0),
        child: Center(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
            // Dil seçeneği kodları
            //  Text("Dil Seçiniz"),
            //  SizedBox(height: 30.0,),
            //   DropdownButton(
            //     value: _selectedLanguage,
            //     items: _dropdownMenuItems,
            //     onChanged: onChangeDropdownItem,
            //   ),
              Text(
                'Mail Bildirimleri',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Verdana Bold", color: Color(0xFF187EA0), fontSize: 20.0, height: 3.0),
              ),
              new SwitchListTile(
                title: new Text("Yeni müşteri onaylandığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Yeni yurtdışı beyan girişinde", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Beyan geçici tescil (LRN) aldığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Beyan LRN aldığında TAD dokümanını PDF olarak gönder", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Beyan hata aldığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("@Destek Talebi Açıldı - Bildir", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Beyan iptal edildiğinde", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("ENS hata aldığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("ENS tescil aldığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Araç hareket gümrüğünde serbest bırakıldığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Araç sınır geçişi yaptığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Araç varış yaptığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Beyan ibra edildiğinde (kapandığında)", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Yeni “Açık Beyan” kaydı oluştuğunda", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Açık olan beyan kapandığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("İş ortağı ekleme talebinde", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Araç ekleme talebinde", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Hesaba ödeme girişinde", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Hesaba avans/kredi girişinde", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Bakiye azaldığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Bakiye bittiğinde", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("İş ortağı onaylandığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Araç onaylandığında", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Beyan Düzeltme Takip", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              new SwitchListTile(
                title: new Text("Teminat Değişimi Olduğunda", style: TextStyle(fontFamily: "Verdana"),),
                value: _value, 
                onChanged: (bool value){_onChanged(value);}
              ),
              // new SwitchListTile(
              //   title: new Text("Araç hareket gümrüğünde serbest bırakıldığında"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Araç sınır geçişi yaptığında"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Araç varış yaptığında"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Beyan ibra edildiğinde (kapandığında)"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Yeni “Açık Beyan” kaydı oluştuğunda"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Açık olan beyan kapandığında"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("İş ortağı ekleme talebinde"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Araç ekleme talebinde"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Hesaba ödeme girişinde"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Hesaba avans/kredi girişinde"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Bakiye azaldığında"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Bakiye bittiğinde"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("İş ortağı onaylandığında"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Araç onaylandığında"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Beyan Düzeltme Takip"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
              // new SwitchListTile(
              //   title: new Text("Teminat Değişimi Olduğunda"),
              //   value: _value,
              //   activeColor: Colors.green, 
              //   onChanged: (bool value){_onChanged(value);}
              // ),
            // _ButtonsField(),
           ],
         ),
        ),
      ),
    );
  }
}
