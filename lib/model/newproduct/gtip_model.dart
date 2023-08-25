class GtipNo {
  int id;
  String gtip;
  String fGtip;
  String tanimTr;
  double vergiOrani;

  GtipNo({this.id, this.gtip, this.fGtip, this.tanimTr, this.vergiOrani});

  GtipNo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gtip = json['gtip'];
    fGtip = json['fGtip'];
    tanimTr = json['tanim_Tr'];
    vergiOrani = json['vergi_Orani']*1.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gtip'] = this.gtip;
    data['fGtip'] = this.fGtip;
    data['tanim_Tr'] = this.tanimTr;
    data['vergi_Orani'] = this.vergiOrani;
    return data;
  }
}