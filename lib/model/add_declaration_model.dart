class AddDeclarationModel {
  int sirketId;
  String gumruk;
  String ihracatci;
  String ithalatci;
  String cikisUlkesi;
  String varisUlkesi;
  String beyanSahibi;
  String giris;
  String rejimKodu;
  String tRVarisGumruk;
  String yuklemeYer;
  String bosaltmaYer;
  String ilKREF;
  //String ref;
  String esyaYeri;

  AddDeclarationModel(
      {this.sirketId,
        this.gumruk,
        this.ihracatci,
        this.ithalatci,
        this.cikisUlkesi,
        this.varisUlkesi,
        this.beyanSahibi,
        this.giris,
        this.rejimKodu,
        this.tRVarisGumruk,
        this.yuklemeYer,
        this.bosaltmaYer,
        this.ilKREF,
        //this.ref,
        this.esyaYeri});

  AddDeclarationModel.fromJson(Map<String, dynamic> json) {
    sirketId = json['sirket_Id'];
    gumruk = json['gumruk'];
    ihracatci = json['ihracatci'];
    ithalatci = json['ithalatci'];
    cikisUlkesi = json['cikisUlkesi'];
    varisUlkesi = json['varisUlkesi'];
    beyanSahibi = json['beyanSahibi'];
    giris = json['giris'];
    rejimKodu = json['rejimKodu'];
    tRVarisGumruk = json['tR_VarisGumruk'];
    yuklemeYer = json['yuklemeYer'];
    bosaltmaYer = json['bosaltmaYer'];
    ilKREF = json['ilK_REF'];
    //ref = json['REF'];
    esyaYeri = json['esyaYeri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sirket_Id'] = this.sirketId;
    data['gumruk'] = this.gumruk;
    data['ihracatci'] = this.ihracatci;
    data['ithalatci'] = this.ithalatci;
    data['cikisUlkesi'] = this.cikisUlkesi;
    data['varisUlkesi'] = this.varisUlkesi;
    data['beyanSahibi'] = this.beyanSahibi;
    data['giris'] = this.giris;
    data['rejimKodu'] = this.rejimKodu;
    data['tR_VarisGumruk'] = this.tRVarisGumruk;
    data['yuklemeYer'] = this.yuklemeYer;
    data['bosaltmaYer'] = this.bosaltmaYer;
    data['ilK_REF'] = this.ilKREF;
    //data['ref'] = this.ref;
    data['esyaYeri'] = this.esyaYeri;
    return data;
  }
}