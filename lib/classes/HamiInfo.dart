import 'dart:convert';

HamiInfo hamiInfoFromJson(String str) => HamiInfo.fromJson(json.decode(str));

String hamiInfoToJson(HamiInfo data) => json.encode(data.toJson());

class HamiInfo {
  HamiInfo({
    this.id,
    this.hamiId,
    this.hamiFname,
    this.hamiLname,
    this.oldMobile1,
    this.newMobile1,
    this.oldMobile2,
    this.newMobile2,
    this.oldPhone1,
    this.newPhone1,
    this.oldPhone2,
    this.newPhone2,
    this.email,
    this.nationalCode,
    this.madadkarId,
    this.madadkarName,
    this.editDate,
  });

  int id;
  int hamiId;
  String hamiFname;
  String hamiLname;
  String oldMobile1;
  String newMobile1;
  String oldMobile2;
  String newMobile2;
  String oldPhone1;
  String newPhone1;
  String oldPhone2;
  String newPhone2;
  String email;
  String nationalCode;
  int madadkarId;
  String madadkarName;
  DateTime editDate;

  factory HamiInfo.fromJson(Map<String, dynamic> json) => HamiInfo(
    id: json["Id"],
    hamiId: json["HamiId"],
    hamiFname: json["HamiFname"],
    hamiLname: json["HamiLname"],
    oldMobile1: json["OldMobile1"],
    newMobile1: json["NewMobile1"],
    oldMobile2: json["OldMobile2"],
    newMobile2: json["NewMobile2"],
    oldPhone1: json["OldPhone1"],
    newPhone1: json["NewPhone1"],
    oldPhone2: json["OldPhone2"],
    newPhone2: json["NewPhone2"],
    email: json["Email"],
    nationalCode: json["NationalCode"],
    madadkarId: json["MadadkarId"],
    madadkarName: json["MadadkarName"],
    editDate: json["EditDate"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "HamiId": hamiId,
    "HamiFname": hamiFname,
    "HamiLname": hamiLname,
    "OldMobile1": oldMobile1,
    "NewMobile1": newMobile1,
    "OldMobile2": oldMobile2,
    "NewMobile2": newMobile2,
    "OldPhone1": oldPhone1,
    "NewPhone1": newPhone1,
    "OldPhone2": oldPhone2,
    "NewPhone2": newPhone2,
    "Email": email,
    "NationalCode": nationalCode,
    "MadadkarId": madadkarId,
    "MadadkarName": madadkarName,
    "EditDate": editDate,
  };
}