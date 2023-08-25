class Customs {
  String id;
  String gumruk;
  String ulkeKodu;
  String gumrukTamTanim;

  Customs({this.id, this.gumruk, this.ulkeKodu, this.gumrukTamTanim});

  Customs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gumruk = json['gumruk'];
    ulkeKodu = json['ulkeKodu'];
    gumrukTamTanim = json['gumrukTamTanim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gumruk'] = this.gumruk;
    data['ulkeKodu'] = this.ulkeKodu;
    data['gumrukTamTanim'] = this.gumrukTamTanim;
    return data;
  }
}