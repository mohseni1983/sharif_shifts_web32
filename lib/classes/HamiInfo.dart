import 'dart:convert';

Hami hamiFromJson(String str) => Hami.fromJson(json.decode(str));

String hamiToJson(Hami data) => json.encode(data.toJson());
String hamiMadadjouSetToJson(HamiMadadjouSet data)=>json.encode(data.toJson());

class Hami {
  Hami({
    this.id,
    this.hamiId,
    this.hamiFname,
    this.newHamiFname,
    this.hamiLname,
    this.newHamiLname,
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
    this.deleteOldMobile1,
    this.deleteOldMobile2,
    this.deleteOldPhone1,
    this.deleteOldPhone2,
    this.tempSave,
    this.finalSave,
    this.hamiMadadjouSet,
  });

  int id;
  int hamiId;
  String hamiFname;
  String newHamiFname;
  String hamiLname;
  String newHamiLname;
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
  String editDate;
  bool deleteOldMobile1;
  bool deleteOldMobile2;
  bool deleteOldPhone1;
  bool deleteOldPhone2;
  bool tempSave;
  bool finalSave;
  List<HamiMadadjouSet> hamiMadadjouSet;

  factory Hami.fromJson(Map<String, dynamic> json) => Hami(
    id: json["Id"],
    hamiId: json["HamiId"],
    hamiFname: json["HamiFname"],
    newHamiFname: json["NewHamiFname"],
    hamiLname: json["HamiLname"],
    newHamiLname: json["NewHamiLname"],
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
    deleteOldMobile1: json["DeleteOldMobile1"],
    deleteOldMobile2: json["DeleteOldMobile2"],
    deleteOldPhone1: json["DeleteOldPhone1"],
    deleteOldPhone2: json["DeleteOldPhone2"],
    tempSave: json["TempSave"],
    finalSave: json["FinalSave"],
    hamiMadadjouSet: List<HamiMadadjouSet>.from(json["HamiMadadjouSet"].map((x) => HamiMadadjouSet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "HamiId": hamiId,
    "HamiFname": hamiFname,
    "NewHamiFname": newHamiFname,
    "HamiLname": hamiLname,
    "NewHamiLname": newHamiLname,
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
    "DeleteOldMobile1": deleteOldMobile1,
    "DeleteOldMobile2": deleteOldMobile2,
    "DeleteOldPhone1": deleteOldPhone1,
    "DeleteOldPhone2": deleteOldPhone2,
    "TempSave": tempSave,
    "FinalSave": finalSave,
    "HamiMadadjouSet": List<dynamic>.from(hamiMadadjouSet.map((x) => x.toJson())),
  };
}

class HamiMadadjouSet {
  HamiMadadjouSet({
    this.id,
    this.hamiId,
    this.madadjouId,
    this.madadjouFname,
    this.madadjouLname,
    this.amount,
    this.addDate,
  });

  int id;
  int hamiId;
  int madadjouId;
  String madadjouFname;
  String madadjouLname;
  int amount;
  String addDate;

  factory HamiMadadjouSet.fromJson(Map<String, dynamic> json) => HamiMadadjouSet(
    id: json["Id"],
    hamiId: json["HamiId"],
    madadjouId: json["MadadjouId"],
    madadjouFname: json["MadadjouFname"],
    madadjouLname: json["MadadjouLname"],
    amount: json["Amount"],
    addDate: json["AddDate"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "HamiId": hamiId,
    "MadadjouId": madadjouId,
    "MadadjouFname": madadjouFname,
    "MadadjouLname": madadjouLname,
    "Amount": amount,
    "AddDate": addDate,
  };
}