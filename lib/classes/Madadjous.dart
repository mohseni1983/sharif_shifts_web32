import 'dart:convert';

List<Madadjous> madadjousFromJson(String str) => List<Madadjous>.from(json.decode(str).map((x) => Madadjous.fromJson(x)));

String madadjousToJson(List<Madadjous> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Madadjous {
  Madadjous({
    this.madadjuId,
    this.madadjuFName,
    this.madadjuLName,
  });

  int madadjuId;
  String madadjuFName;
  String madadjuLName;

  factory Madadjous.fromJson(Map<String, dynamic> json) => Madadjous(
    madadjuId: json["MadadjuId"],
    madadjuFName: json["MadadjuFName"],
    madadjuLName: json["MadadjuLName"],
  );

  Map<String, dynamic> toJson() => {
    "MadadjuId": madadjuId,
    "MadadjuFName": madadjuFName,
    "MadadjuLName": madadjuLName,
  };
}