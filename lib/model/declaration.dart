class Declaration {
  String id;
  int otoId;
  int sirketId;
  String tarih;
  String firmaAd;
  String mrn;
  String plaka;
  String rotaBilgi;
  String ref;
  int giris;
  String tasiyici;
  String ensStatu;
  String rejimKodu;
  int tasiyiciId;
  int firmaId;
  String tasimaMod;
  String tasimaMod2;
  String tasimaModu;
  String tasimaModu2;
  String duzenliTarih;
  String seferBilgi;
  String plaka2;
  String plaka3;
  String konteynerNo;

  Declaration(
      {this.id,
        this.otoId,
        this.sirketId,
        this.tarih,
        this.firmaAd,
        this.mrn,
        this.plaka,
        this.rotaBilgi,
        this.ref,
        this.giris,
        this.tasiyici,
        this.ensStatu,
        this.rejimKodu,
        this.tasiyiciId,
        this.firmaId,
        this.tasimaMod,
        this.tasimaMod2,
        this.tasimaModu,
        this.tasimaModu2,
        this.duzenliTarih,
        this.seferBilgi,
        this.plaka2,
        this.plaka3,
        this.konteynerNo});

  Declaration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    otoId = json['oto_Id'];
    sirketId = json['sirket_Id'];
    firmaAd = json['firma_Ad'];
    mrn = json['mrn'];
    plaka = json['plaka'];
    rotaBilgi = json['rota_Bilgi'];
    ref = json['ref'];
    giris = json['giris'];
    tasiyici = json['tasiyici'];
    ensStatu = json['ensStatu'];
    rejimKodu = json['rejimKodu'];
    tasiyiciId = json['tasiyiciId'];
    firmaId = json['firmaId'];
    tasimaMod = json['tasima_Mod'];
    tasimaMod2 = json['tasima_Mod2'];
    tasimaModu = json['tasima_Modu'];
    tasimaModu2 = json['tasima_Modu2'];
    duzenliTarih = json['duzenliTarih'];
    seferBilgi = json['sefer_Bilgi'];
    plaka2 = json['plaka2'];
    plaka3 = json['plaka3'];
    konteynerNo = json['konteyner_No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['oto_Id'] = this.otoId;
    data['tarih'] = this.tarih;
    data['firma_Ad'] = this.firmaAd;
    data['mrn'] = this.mrn;
    data['plaka'] = this.plaka;
    data['rota_Bilgi'] = this.rotaBilgi;
    data['ref'] = this.ref;
    data['giris'] = this.giris;
    data['tasiyici'] = this.tasiyici;
    data['ensStatu'] = this.ensStatu;
    data['rejimKodu'] = this.rejimKodu;
    data['tasiyiciId'] = this.tasiyiciId;
    data['firmaId'] = this.firmaId;
    data['tasima_Mod'] = this.tasimaMod;
    data['tasima_Mod2'] = this.tasimaMod2;
    data['tasima_Modu'] = this.tasimaModu;
    data['tasima_Modu2'] = this.tasimaModu2;
    data['duzenliTarih'] = this.duzenliTarih;
    data['sefer_Bilgi'] = this.seferBilgi;
    data['plaka2'] = this.plaka2;
    data['plaka3'] = this.plaka3;
    data['konteyner_No'] = this.konteynerNo;
    return data;
  }
}