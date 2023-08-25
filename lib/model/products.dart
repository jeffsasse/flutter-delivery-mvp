class Products {
  int id;
  String gtip;
  String tanim;
  String kapTipi;
  int kapAdet;
  double brut;
  double net;
  double tutar;
  String doviz;
  String parcali;
  String gtipNokta;

  Products(
      {this.id,
      this.gtip,
      this.tanim,
      this.kapTipi,
      this.kapAdet,
      this.brut,
      this.net,
      this.tutar,
      this.doviz,
      this.gtipNokta,
      this.parcali});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gtip = json['gtip'];
    tanim = json['tanim'];
    kapTipi = json['kapTipi'];
    kapAdet = json['kapAdet'];
    brut = json['brut'] * 1.0;
    net = json['net'] * 1.0;
    tutar = json['tutar'] * 1.0;
    doviz = json['doviz'];
    parcali = json['parcali'];
    gtipNokta = json['gtipNokta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gtip'] = this.gtip;
    data['tanim'] = this.tanim;
    data['kapTipi'] = this.kapTipi;
    data['kapAdet'] = this.kapAdet;
    data['brut'] = this.brut;
    data['net'] = this.net;
    data['tutar'] = this.tutar;
    data['doviz'] = this.doviz;
    data['parcali'] = this.parcali;
    data['gtipNokta'] = this.gtipNokta;
    return data;
  }
}
