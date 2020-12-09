import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sharif_shifts/classes/donation.dart';
import 'package:sharif_shifts/classes/globalVars.dart';
import 'package:persian_date/persian_date.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share/share.dart';



class DonationPage extends StatefulWidget {
  final int campaign_id;

  

  const DonationPage({Key key, this.campaign_id=0}) : super(key: key);
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
int final_total=0;
PersianDate persianDate=new PersianDate();

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  FocusScope.of(context).requestFocus(new FocusNode());
  _scaffoldKey.currentState?.removeCurrentSnackBar();
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      value,
      textAlign: TextAlign.center,
      style:
      TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "Samim"),
    ),
    backgroundColor: Colors.blue,
    duration: Duration(seconds: 3),
  ));
}

  @override
  Widget build(BuildContext context) {

    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          key: _scaffoldKey,
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
                  widget.campaign_id==0?
                  Positioned(
                      bottom: 6,
                      left: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        alignment: Alignment.center,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.7,color: Colors.black38,style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(-4,-1),
                              spreadRadius: 5,
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            RaisedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.copy,color: Colors.white,),
                                  Text('کپی لینک حمایت عمومی',style: TextStyle(color: Colors.white),),


                                ],
                              ),
                              color: Colors.green.shade900,
                              onPressed: (){
                                FlutterClipboard.copy('https://sharifngo.com/p/'+globalVars.MadadkarId.toString()).then((value) => showInSnackBar('لینک در حافظه کپی شد'));
                              },
                            ),
                            RaisedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.share,color: Colors.white,),
                                  Text('اشتراک گذاری لینک حمایت عمومی',style: TextStyle(color: Colors.white),),

                                ],
                              ),
                              color: Colors.blue.shade900,
                              onPressed: (){
                                Share.share('https://sharifngo.com/p/'+globalVars.MadadkarId.toString());
                              },
                            ),

                          ],
                        )

                      )
                  ):
                      Container(
                        height: 0,
                      )

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
