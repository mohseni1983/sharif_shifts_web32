import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sharif_shifts/classes/donation.dart';
import 'package:sharif_shifts/classes/globalVars.dart';
import 'package:persian_date/persian_date.dart';


class DonationPage extends StatefulWidget {
  final int campaign_id;

  const DonationPage({Key key, this.campaign_id=0}) : super(key: key);
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {

PersianDate persianDate=new PersianDate();
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('لیست واریزها'),

          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.red
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft
              )
            ),
            child: FutureBuilder<List<donation>>(
              future: getDonations(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                  return Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: CircularProgressIndicator(),
                      ));
                  break;
                  case ConnectionState.done:
                    if(snapshot.hasData && snapshot.data !=null){
                      var data=snapshot.data;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        //Text('مبلغ:${data[index].amount} ریال'),
                                        Text('${DateTime.fromMillisecondsSinceEpoch(1607345576,isUtc: false)}'),
                                        //Text('تاریخ:${persianDate.gregorianToJalali(DateTime.fromMicrosecondsSinceEpoch(int.parse(data[index].datetime)).toString())}'),
                                      ],
                                    )
                                  ],
                                )
                              ),
                            );
                          },);
                    }else{
                      return Center(
                        child: Container(
                          height: 100,
                          child: Text('واریزی ثبت شده ای یافت نشد'),
                        ),
                      );
                    }
                    return Center(
                      child: Container(
                        height: 100,
                        child: Text('خطایی رخ داده است'),
                      ),
                    );
                  case ConnectionState.none:
                    // TODO: Handle this case.
                    break;
                }
                return Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ),
        ));
  }

  Future<List<donation>> getDonations() async{
    String query='http://sharifngo.com/wp-json/wp/v2/get_donates?id='+globalVars.MadadkarId.toString()+'&campaign_id='+widget.campaign_id.toString();
    var result=await http.get(query);
    if(result.statusCode==200){
      return donationFromJson(result.body);
    }
    return null;

  }
}
