class TRNItem {
  int id;
  String ref;
  String durum;
  String hareketGumruk;
  String varisGumruk;
  String mrn;
  String lrn;
  String tescilTarihi;
  String gonderici;
  String gondericiAdres;
  String alici;
  String aliciAdres;
  double teminatBedeli;
  double malDegeri;

  TRNItem(
      {this.id,
        this.ref,
        this.durum,
        this.hareketGumruk,
        this.varisGumruk,
        this.mrn,
        this.lrn,
        this.tescilTarihi,
        this.gonderici,
        this.gondericiAdres,
        this.alici,
        this.aliciAdres,
        this.teminatBedeli,
        this.malDegeri});

  TRNItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ref = json['ref'];
    durum = json['durum'];
    hareketGumruk = json['hareketGumruk'];
    varisGumruk = json['varisGumruk'];
    mrn = json['mrn'];
    lrn = json['lrn'];
    tescilTarihi = json['tescilTarihi'];
    gonderici = json['gonderici'];
    gondericiAdres = json['gonderi_Adres'];
    alici = json['alici'];
    aliciAdres = json['alici_Adres'];
    teminatBedeli = json['teminatBedeli'];
    malDegeri = json['malDegeri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref'] = this.ref;
    data['durum'] = this.durum;
    data['hareketGumruk'] = this.hareketGumruk;
    data['varisGumruk'] = this.varisGumruk;
    data['mrn'] = this.mrn;
    data['lrn'] = this.lrn;
    data['tescilTarihi'] = this.tescilTarihi;
    data['gonderici'] = this.gonderici;
    data['gonderici_Adres'] = this.gondericiAdres;
    data['alici'] = this.alici;
    data['alici_Adres'] = this.aliciAdres;
    data['teminatBedeli'] = this.teminatBedeli;
    data['malDegeri'] = this.malDegeri;
    return data;
  }
}