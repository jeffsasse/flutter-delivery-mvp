class Company {
  int id;
  int sirketId;
  String vergiNo;
  String unvan;
  String eoriNo;
  String adres;
  String ilIlce;
  String postaKodu;
  String tel1;
  String eMail;
  String ulkeKodu;

  Company(
      {this.id,
        this.sirketId,
        this.vergiNo,
        this.unvan,
        this.eoriNo,
        this.adres,
        this.ilIlce,
        this.postaKodu,
        this.tel1,
        this.eMail,
        this.ulkeKodu});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sirketId = json['sirketId'];
    vergiNo = json['vergiNo'];
    unvan = json['unvan'];
    eoriNo = json['eoriNo'];
    adres = json['adres'];
    ilIlce = json['ilIlce'];
    postaKodu = json['postaKodu'];
    tel1 = json['tel1'];
    eMail = json['eMail'];
    ulkeKodu = json['ulkeKodu'];
  }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sirketId'] = this.sirketId;
    data['vergiNo'] = this.vergiNo;
    data['unvan'] = this.unvan;
    data['eoriNo'] = this.eoriNo;
    data['adres'] = this.adres;
    data['ilIlce'] = this.ilIlce;
    data['postaKodu'] = this.postaKodu;
    data['tel1'] = this.tel1;
    data['eMail'] = this.eMail;
    data['ulkeKodu'] = this.ulkeKodu;
    return data;
  }
}