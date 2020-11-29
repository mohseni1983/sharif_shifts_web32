import 'dart:convert';

MadadjouSingle madadjouSingleFromJson(String str) => MadadjouSingle.fromJson(json.decode(str));

String madadjouSingleToJson(MadadjouSingle data) => json.encode(data.toJson());

class MadadjouSingle {
  MadadjouSingle({
    this.Id,
    this.hamiId,
    this.madadjouId,
    this.madadjouFname,
    this.madadjouLname,
    this.amount,
    this.addDate,
  });

  int Id;
  int hamiId;
  int madadjouId;
  String madadjouFname;
  String madadjouLname;
  int amount;
  String addDate;

  factory MadadjouSingle.fromJson(Map<String, dynamic> json) => MadadjouSingle(
    Id: json["id"],
    hamiId: json["HamiId"],
    madadjouId: json["MadadjouId"],
    madadjouFname: json["MadadjouFname"],
    madadjouLname: json["MadadjouLname"],
    amount: json["Amount"],
    addDate: json["AddDate"],
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "HamiId": hamiId,
    "MadadjouId": madadjouId,
    "MadadjouFname": madadjouFname,
    "MadadjouLname": madadjouLname,
    "Amount": amount,
    "AddDate": addDate,
  };
}
