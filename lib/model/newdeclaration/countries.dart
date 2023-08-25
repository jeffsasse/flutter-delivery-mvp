class Counties {
  String id;
  String tanim;
  String ulkeTamTanim;

  Counties({this.id, this.tanim, this.ulkeTamTanim});

  Counties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tanim = json['tanim'];
    ulkeTamTanim = json['ulkeTamTanim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tanim'] = this.tanim;
    data['ulkeTamTanim'] = this.ulkeTamTanim;
    return data;
  }
}