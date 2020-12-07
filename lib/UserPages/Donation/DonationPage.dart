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
int final_total=0;
PersianDate persianDate=new PersianDate();
  @override
  Widget build(BuildContext context) {

    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('لیست واریزها'),
            centerTitle: true,

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
            child:
              Stack(
                children: [
                  FutureBuilder<List<donation>>(
                    future: getDonations(),
                    builder: (context, snapshot) {
                      switch(snapshot.connectionState){
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Center(
                              child: Container(
                                height: 40,
                                width: 40,
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
                                            mainAxisSize: MainAxisSize.max ,

                                            children: [
                                              Expanded(
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Icon(Icons.calendar_today_outlined,color: Colors.green,),
                                                    Text('${persianDate.gregorianToJalali(DateTime.fromMillisecondsSinceEpoch(int.parse(data[index].datetime)*1000,isUtc: false).toString()).substring(0,10)}'),

                                                  ],
                                                ),

                                              ),
                                              Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,

                                                    children: [
                                                      Icon(Icons.watch_later_outlined,color: Colors.green,),
                                                      Text('${DateTime.fromMillisecondsSinceEpoch(int.parse(data[index].datetime)*1000,isUtc: false).toString().substring(10)}'),

                                                    ],
                                                  )

                                              )

                                            ],
                                          ),
                                          Divider(thickness: 0.8,color: Colors.black38,indent: 3,endIndent: 3,),
                                          Row(
                                            mainAxisSize: MainAxisSize.max ,

                                            children: [
                                              Expanded(
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Icon(Icons.monetization_on,color: Colors.green,),
                                                    Text('${data[index].amount} ریال'),

                                                  ],
                                                ),

                                              ),
                                              Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,

                                                    children: [
                                                      Icon(Icons.credit_card,color: Colors.green,),
                                                      Text('${data[index].lfdPan}'),

                                                    ],
                                                  )

                                              )

                                            ],
                                          ),
                                          Divider(thickness: 0.8,color: Colors.black38,indent: 3,endIndent: 3,),
                                          Row(
                                            mainAxisSize: MainAxisSize.max ,

                                            children: [
                                              Expanded(
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Icon(Icons.qr_code,color: Colors.green,),
                                                    Text('${data[index].settle}'),

                                                  ],
                                                ),

                                              ),
                                              Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.max,

                                                    children: [
                                                      Icon(Icons.comment_bank_rounded,color: Colors.green,),
                                                      Text('${data[index].rrn}'),

                                                    ],
                                                  )

                                              )

                                            ],
                                          ),


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
                  ),

                ],
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
