class Wrecker {
  int id;
  bool firmayaAit;
  String plakaNo;
  String plaka;
  String ulke;

  Wrecker(
      {this.id,
        this.firmayaAit,
        this.plakaNo,
        this.plaka,
        this.ulke});

  Wrecker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firmayaAit = json['firmayaAit'];
    plakaNo = json['plakaNo'];
    plaka = json['plaka'];
    ulke = json['ulke'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firmayaAit'] = this.firmayaAit;
    data['plakaNo'] = this.plakaNo;
    data['plaka'] = this.plaka;
    data['ulke'] = this.ulke;
    return data;
  }
}