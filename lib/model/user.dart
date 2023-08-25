class User {
  int id;
  String adiSoyadi;
  String username;
  int yetkiDuzeyi;
  String email;
  bool superUser;
  int sirketId;
  String ticaretUnvani;
  String sessionId;
  String token;
  int firmaId;

  User(
      {this.id,
        this.adiSoyadi,
        this.username,
        this.yetkiDuzeyi,
        this.email,
        this.superUser,
        this.sirketId,
        this.ticaretUnvani,
        this.sessionId,
        this.token,
        this.firmaId
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adiSoyadi = json['adi_soyadi'];
    username = json['username'];
    yetkiDuzeyi = json['yetki_duzeyi'];
    email = json['email'];
    superUser = json['super_user'];
    sirketId = json['sirket_id'];
    ticaretUnvani = json['ticaret_unvani'];
    sessionId = json['session_id'];
    token = json['token'];
    firmaId = json['firma_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adi_soyadi'] = this.adiSoyadi;
    data['username'] = this.username;
    data['yetki_duzeyi'] = this.yetkiDuzeyi;
    data['email'] = this.email;
    data['super_user'] = this.superUser;
    data['sirket_id'] = this.sirketId;
    data['ticaret_unvani'] = this.ticaretUnvani;
    data['session_id'] = this.sessionId;
    data['token'] = this.token;
    data['firma_id'] = this.firmaId;
    return data;
  }
}