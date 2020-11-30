import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sharif_shifts/UserPages/HamiEdit/HamiEditPage.dart';
import 'package:sharif_shifts/UserPages/HamiEdit/MadadjousEditPage.dart';
import 'package:sharif_shifts/classes/HamiInfo.dart';
import 'package:sharif_shifts/classes/Madadjous.dart';
import 'package:sharif_shifts/classes/hami.dart';
import 'package:http/http.dart' as http;
import 'package:sharif_shifts/classes/globalVars.dart';

import '../../classes/globalVars.dart';

class hamiList extends StatefulWidget {

  @override
  _hamiListState createState() => _hamiListState();
}

class _hamiListState extends State<hamiList> {

  String _filter = '';
  bool _getingMadadjoulist=false;
  List<Madadjous> _MadadjouList;

  Future<List<HamisInfo>> GetHamis() async {
    List<HamisInfo> res = new List<HamisInfo>();
    var result = await http.post(globalVars.s_url + 'api/Madadkar/GetHamis',
        headers: {'Authorization': 'Bearer ' + globalVars.token});
    debugPrint(result.statusCode.toString());
    if (result.statusCode == 200) {
      Iterable jResults = json.decode(result.body);

      res = jResults.map((model) => HamisInfo.fromJson(model)).toList();
      return res;
    }
    return null;
  }
  
  Future<List<Madadjous>> getMadadjous() async{
    var result=await http.post(globalVars.s_url+'api/Madadkar/GetMadadjouList');
      if(result.statusCode==200){
        var rs=madadjousFromJson(result.body);
        return rs;

      }
      return null;


  }

  Future<List<Hami>> GetHamisForEdit() async {
    List<Hami> res=new List<Hami>();
    var result = await http.post(globalVars.s_url + 'api/Madadkar/GetHamisForEdit',
        headers: {'Authorization': 'Bearer ' + globalVars.token});
    if(result.statusCode==200){
      Iterable jResult=json.decode(result.body);
      res= jResult.map((e) => Hami.fromJson(e)).toList();
      return res;
    }
    return null;
  }

Future<Hami> getHamiById(int id) async{
    var result= await http.post(globalVars.s_url+'/api/Madadkar/GetHamiInfo?HamiId='+id.toString());
    if(result.statusCode==200){
      return hamiFromJson(result.body);
    }
    return null;

}

@override
  void initState() {
    // TODO: implement initState
    setState(() {
      _getingMadadjoulist=true;
    });
    getMadadjous().then((value) {
      if(value!=null){
        setState(() {
          _MadadjouList=value;
          _getingMadadjoulist=false;
        });

      }

    });
    super.initState();

}

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('لیست حامیان'),
        ),
        body:
        new Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Colors.white,
                  Colors.red
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),

          padding: EdgeInsets.fromLTRB(8, 0, 8, 6),
          child:
          _getingMadadjoulist?
              Center(child:
                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('درحال دریافت لیست مددجوها')
                    ],
                  ),
                ),):
          new Column(
            children: <Widget>[
              new Container(
                //height: 50,
                  color: Colors.black26,
                  child: new TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white,),
                      hintText: 'جستجوی حامی',


                    ),

                    //controller: _searchController,
                    onChanged: (String value) {
                      debugPrint(_filter);
                      setState(() {
                        _filter = value;
                      });
                    },
                  )),
              Expanded(
                child: FutureBuilder<List<Hami>>(
                  future: GetHamisForEdit(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var s = snapshot.data;

                      return ListView.builder(
                        itemCount: s.length,
                        itemBuilder: (context, index) {
                          if (_filter != null) {
                            return '${s[index].hamiLname}'
                                .contains(_filter) ||
                                '${s[index].hamiFname}'
                                    .contains(_filter) ||
                                '${s[index].oldMobile1}'
                                    .contains(_filter) ||
                                '${s[index].oldMobile2}'
                                    .contains(_filter)
                                ?
                            new Container(
                                decoration: new BoxDecoration(
                                  color: Colors.grey.shade200.withOpacity(
                                      0.3),
                                  borderRadius: new BorderRadius.circular(
                                      5.0),
                                ),
                                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                margin: EdgeInsets.all(4),
                                child:
                                new
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        new Container(

                                          child: new Text(
                                              '${s[index].hamiFname} ${s[index]
                                                  .hamiLname}',textScaleFactor: 1.2,),

                                        ),


                                      ],
                                    ),
                                    Divider(height: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        FlatButton(

                                            child: Text('ویرایش اطلاعات تماس',textScaleFactor: 0.7,),
                                            onPressed: (){                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HamiEditPage(hamiId: s[index],)));
                                            },
                                            color: Colors.amber,
                                          minWidth: 120,

                                            ),
                                        FlatButton(onPressed: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MadadjousEdit(hami: s[index],madadjous: _MadadjouList,),)).then((value) {
                                            setState(() {

                                            });
                                          });
                                        },
                                            child: Text('ویرایش مددجویان',textScaleFactor: 0.7,),
                                        color: Colors.blueAccent,
                                          highlightColor: Colors.white ,
                                          minWidth: 120,
                                        )
                                      ],
                                    ),
                                    Divider(height: 1,),
                                    Row(
                                      children: [
                                        Text('وضعیت ویرایش اطلاعات تماس:'),
                                        s[index].finalSave!=true && s[index].tempSave!=true?Text('ویرایش نشده',style: TextStyle(color: Colors.red),textScaleFactor: 0.8,):
                                            s[index].finalSave!=true && s[index].tempSave==true?Text('ویرایش موقت',style: TextStyle(color: Colors.yellow),textScaleFactor: 0.8,):
                                                Text('ویرایش شده',style: TextStyle(color: Colors.green),textScaleFactor: 0.8,)
                                      ],
                                    )

                                  ],
                                )
                            )

                                : Container(
                              width: 0,
                              height: 0,
                            );
                          }
                          return
                            new Container(
                                decoration: new BoxDecoration(
                                  color: Colors.grey.shade200.withOpacity(
                                      0.3),
                                  borderRadius: new BorderRadius.circular(
                                      5.0),
                                ),
                                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                margin: EdgeInsets.all(4),
                                child:
                                new
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        new Container(

                                          child: new Text(
                                              '${s[index]
                                                  .hamiFname} ${s[index]
                                                  .hamiLname}'),

                                        ),


                                      ],
                                    ),


                                  ],
                                )
                            );
                        },
                      );
                    }
                    return new Center(
                      child: Container(
                        height: 150,
                       // width: 150,
                        child: new Column(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            new Text('در حال دریافت لیست حامیان')
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )),

    );

  }
}
