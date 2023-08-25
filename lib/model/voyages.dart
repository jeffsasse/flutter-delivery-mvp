class Voyages {
  String voyageCode;
  String vesselName;
  String departureDate;
  String arrivalDate;
  String departurePort;
  String arrivalPort;
  String imoNumber;
  String departureCountry;
  String arrivalCountry;
  String flagCountry;

  Voyages(
      {this.voyageCode,
        this.vesselName,
        this.departureDate,
        this.arrivalDate,
        this.departurePort,
        this.arrivalPort,
        this.imoNumber,
        this.departureCountry,
        this.arrivalCountry,
        this.flagCountry});

  Voyages.fromJson(Map<String, dynamic> json) {
    voyageCode = json['voyageCode'];
    vesselName = json['vesselName'];
    departureDate = json['departureDate'].toString().replaceAll(" 00:00:00", "");
    arrivalDate = json['arrivalDate'].toString().replaceAll(" 00:00:00", "");
    departurePort = json['departurePort'];
    arrivalPort = json['arrivalPort'];
    imoNumber = json['imoNumber'];
    departureCountry = json['departureCountry'];
    arrivalCountry = json['arrivalCountry'];
    flagCountry = json['flagCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voyageCode'] = this.voyageCode;
    data['vesselName'] = this.vesselName;
    data['departureDate'] = this.departureDate;
    data['arrivalDate'] = this.arrivalDate;
    data['departurePort'] = this.departurePort;
    data['arrivalPort'] = this.arrivalPort;
    data['imoNumber'] = this.imoNumber;
    data['departureCountry'] = this.departureCountry;
    data['arrivalCountry'] = this.arrivalCountry;
    data['flagCountry'] = this.flagCountry;
    return data;
  }
}