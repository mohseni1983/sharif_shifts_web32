import 'dart:convert';

List<donation> donationFromJson(String str)=>List<donation>.from(json.decode(str).map((x)=>donation.fromJson(x)));


class donation {
  String id;
  String datetime;
  String referrer;
  String amount;
  String campaign;
  String insertIp;
  String refId;
  String resCode;
  String resMessage;
  String pgtId;
  String rrn;
  String lfdPan;
  String verify;
  String settle;

  donation({this.id,
    this.datetime,
    this.referrer,
    this.amount,
    this.campaign,
    this.insertIp,
    this.refId,

    this.resCode,
    this.resMessage,
    this.pgtId,
    this.rrn,
    this.lfdPan,
    this.verify,
    this.settle});

  donation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    datetime = json['datetime'];
    referrer = json['referrer'];
    amount = json['amount'];
    campaign = json['campaign'];
    insertIp = json['insert_ip'];
    refId = json['ref_id'];

    resCode = json['res_code'];
    resMessage = json['res_message'];
    pgtId = json['pgt_id'];
    rrn = json['rrn'];
    lfdPan = json['lfd_pan'];
    verify = json['verify'];
    settle = json['settle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['datetime'] = this.datetime;
    data['referrer'] = this.referrer;
    data['amount'] = this.amount;
    data['campaign'] = this.campaign;
    data['insert_ip'] = this.insertIp;
    data['ref_id'] = this.refId;

    data['res_code'] = this.resCode;
    data['res_message'] = this.resMessage;
    data['pgt_id'] = this.pgtId;
    data['rrn'] = this.rrn;
    data['lfd_pan'] = this.lfdPan;
    data['verify'] = this.verify;
    data['settle'] = this.settle;
    return data;
  }
}