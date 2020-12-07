import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:sharif_shifts/UserPages/Donation/DonationPage.dart';
import 'package:sharif_shifts/classes/campaign.dart';
import 'package:http/http.dart' as http;
import 'package:sharif_shifts/classes/globalVars.dart';
import 'package:share/share.dart';

class CampaignPage extends StatefulWidget {
  @override
  _CampaignPageState createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {

  Future<List<campaign>> getCampaigns() async{
    var result=await http.get('https://sharifngo.com/wp-json/wp/v2/campaign?_fields=id,slug,status,link,title,featured_media');
    if(result.statusCode==200)
      return camapignsFromJson(result.body);
    return null;

  }

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
        child:Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('کمپین ها'),
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.white,
                  Colors.red
                ]
              )
            ),
            child: FutureBuilder<List<campaign>>(
              future: getCampaigns(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                    break;
                  case ConnectionState.done:
                    if(snapshot.hasData)
                      {
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(

                                            padding: EdgeInsets.only(left: 5),
                                            decoration: BoxDecoration(
                                              border: Border(left: BorderSide(width: 0.8,color: Colors.black12))
                                            ),
                                            child: CircleAvatar(

                                              child: Icon(Icons.campaign,color: Colors.red,size: 75,),
                                              maxRadius: 50,
                                              backgroundColor: Colors.black12,
                                            )
                                            ,
                                          ),
                                       Container(
                                         padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
                                         child:
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisSize: MainAxisSize.max,
                                           children: [
                                             RaisedButton(onPressed: (){
                                               FlutterClipboard.copy('https://sharifngo.com/cg/${data[index].slug}/${globalVars.MadadkarId}').then((value) {
                                                 showInSnackBar('لینک در حافظه کپی شد');
                                               });
                      },
                                             child: Row(
                                               mainAxisSize: MainAxisSize.max,

                                               children: [
                                                 Icon(Icons.copy,color: Colors.white,),
                                                 Text('کپی لینک اختصاصی',style: TextStyle(color: Colors.white),)

                                               ],
                                             ),
                                               color: Colors.green.shade900,
                                             ),
                                             RaisedButton(onPressed: (){
                                               Share.share('کمپین ${data[index].title.rendered.replaceAll(new RegExp(r'(\d+)'), '').replaceAll('&', '').replaceAll('#', '').replaceAll(';', '')}  https://sharifngo.com/cg/${data[index].slug}/${globalVars.MadadkarId}',subject:data[index].title.rendered.replaceAll(new RegExp(r'(\d+)'), '').replaceAll('&', '').replaceAll('#', '').replaceAll(';', '') );
                                             },

                                               child: Row(
                                                 mainAxisSize: MainAxisSize.max,

                                                 children: [
                                                   Icon(Icons.share,color: Colors.white,),
                                                   Text('اشتراک گذاری لینک',style: TextStyle(color: Colors.white),)

                                                 ],
                                               ),
                                               color: Colors.green.shade900,
                                             ),

                                             RaisedButton(onPressed: (){
                                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => DonationPage(campaign_id: data[index].id,),));
                                             },

                                               child: Row(
                                                 mainAxisSize: MainAxisSize.max,

                                                 children: [
                                                   Icon(Icons.payment,color: Colors.white,),
                                                   Text('لیست واریزها',style: TextStyle(color: Colors.white),)

                                                 ],
                                               ),
                                               color: Colors.green.shade900,
                                             ),

                                           ],
                                         ),
                                       )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black12,
                                        thickness: 0.8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          data[index].title.rendered.length<50?
                                          Text('${data[index].title.rendered.replaceAll(new RegExp(r'(\d+)'), '').replaceAll('&', '').replaceAll('#', '').replaceAll(';', '')}',softWrap: false,maxLines: 1,overflow: TextOverflow.ellipsis,)
                                          :  Text('${data[index].title.rendered.replaceAll(new RegExp(r'(\d+)'), '').replaceAll('&', '').replaceAll('#', '').replaceAll(';', '')}',softWrap: false,maxLines: 1,overflow: TextOverflow.ellipsis,textScaleFactor: 0.9,)

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },);
                      }
                    break;

                  case ConnectionState.none:
                    // TODO: Handle this case.
                    break;
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ) );
  }
}
