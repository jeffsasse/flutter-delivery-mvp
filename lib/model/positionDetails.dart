class PositionDetails {
  int id;
  String hareketGumrugu;
  String transitinSonGumrugu;
  String hareketUlkesi;
  String gidecegiUlke;
  String gonderici;
  String gondericiAdres;
  String alici;
  String aliciAdres;
  String rotalar;
  String trnGumrukler;

  PositionDetails(
      {this.id,
        this.hareketGumrugu,
        this.transitinSonGumrugu,
        this.hareketUlkesi,
        this.gidecegiUlke,
        this.gonderici,
        this.gondericiAdres,
        this.alici,
        this.aliciAdres,
        this.rotalar,
        this.trnGumrukler});

  PositionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hareketGumrugu = json['hareketGumrugu'];
    transitinSonGumrugu = json['transitinSonGumrugu'];
    hareketUlkesi = json['hareketUlkesi'];
    gidecegiUlke = json['gidecegiUlke'];
    gonderici = json['gonderici'];
    gondericiAdres = json['gonderici_Adres'];
    alici = json['alici'];
    aliciAdres = json['alici_Adres'];
    rotalar = json['rotalar'];
    trnGumrukler = json['trn_Gumrukler'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hareketGumrugu'] = this.hareketGumrugu;
    data['transitinSonGumrugu'] = this.transitinSonGumrugu;
    data['hareketUlkesi'] = this.hareketUlkesi;
    data['gidecegiUlke'] = this.gidecegiUlke;
    data['gonderici'] = this.gonderici;
    data['gonderici_Adres'] = this.gondericiAdres;
    data['alici'] = this.alici;
    data['alici_Adres'] = this.aliciAdres;
    data['rotalar'] = this.rotalar;
    data['trn_Gumrukler'] = this.trnGumrukler;
    return data;
  }
}