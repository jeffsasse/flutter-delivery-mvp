class Firms {
  int id;
  String unvan;
  String gunvan;
  String adres;

  Firms({this.id, this.unvan, this.gunvan, this.adres});

  Firms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unvan = json['unvan'];
    gunvan = json['gunvan'];
    adres = json['adres'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unvan'] = this.unvan;
    data['gunvan'] = this.gunvan;
    data['adres'] = this.adres;
    return data;
  }
}