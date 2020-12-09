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
  bool _getHamiListState=false;
  bool _showEdited=true;
  bool _showNotEdited=true;
  List<Madadjous> _MadadjouList;
  List<Hami> s;

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
      _getHamiListState=true;
    });
    getMadadjous().then((value) {
      if(value!=null){
        setState(() {
          _MadadjouList=value;
          _getingMadadjoulist=false;
        });

      }

    });

    GetHamisForEdit().then((value) => {
      if(value!=null){
        setState((){
          s=value;
          _getHamiListState=false;
    })
      }
    });


    super.initState();

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

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('لیست حامیان'),
        ),
        body:
        Container(
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
          _getHamiListState?
          Center(child:
          Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text('درحال دریافت لیست حامیان')
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
                  child:
                  ListView.builder(
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
                                .contains(_filter)||
                            '${s[index].newHamiFname}'
                                .contains(_filter)||
                            '${s[index].newHamiLname}'
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
                                        '${s[index].newHamiFname==null? s[index].hamiFname:s[index].newHamiFname} ${s[index].newHamiLname==null? s[index].hamiLname:s[index].newHamiLname}',textScaleFactor: 1.2,),

                                    ),


                                  ],
                                ),
                                Divider(height: 1,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    FlatButton(

                                      child: Text('ویرایش اطلاعات تماس',textScaleFactor: 0.7,),
                                      onPressed: (){                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HamiEditPage(hamiId: s[index],)))
                                          .then((value) {
                                        setState(() {
                                          _getHamiListState=true;
                                          GetHamisForEdit().then((value) {
                                            setState(() {
                                              s=value;
                                              _getHamiListState=false;
                                            });
                                          });
                                        });
                                      });
                                      },
                                      color: Colors.amber,
                                      minWidth: 120,

                                    ),
                                    FlatButton(onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MadadjousEdit(hami: s[index],madadjous: _MadadjouList,),))
                                          .then((value) {
                                        setState(() {
                                          _getHamiListState=true;
                                          GetHamisForEdit().then((value) {
                                            setState(() {
                                              s=value;
                                              _getHamiListState=false;
                                            });
                                          });
                                        });
                                      });
                                    },
                                      child: Text('ویرایش مددجویان',textScaleFactor: 0.7,),
                                      color: Colors.blueAccent.shade100,
                                      highlightColor: Colors.white ,
                                      minWidth: 120,
                                    ),
                                    IconButton(icon: Icon(Icons.delete_forever,color: Colors.redAccent,), onPressed: () async{
                                      deleteClass res=await _deleteHamiDialog(context);
                                      if(res.isDelete){
                                        DeleteHami delHami=new DeleteHami(hamiId: s[index].hamiId,deleteCuase: res.deleteCuase);
                                        deleteHami(delHami).then((value) {
                                          if(value){

                                            setState(() {
                                              _getHamiListState=true;
                                              GetHamisForEdit().then((value) {
                                                setState(() {
                                                  s=value;
                                                  _getHamiListState=false;
                                                });
                                              });
                                            });
                                            showInSnackBar('حامی مورد نظر حذف شد');



                                          }
                                          else
                                            showInSnackBar('خطایی در حذف رخ داده است');



                                        });
                                      }



                                    })
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
                  )

              ),
/*
                  Container(
                    height: 50,
                    child:
                    Row(
                      children: [
                        Expanded(
                            child: Row(
                              children: [
                                Checkbox(value: _showEdited, onChanged: (v){
                                  setState(() {
                                    _showEdited=v;
                                  });
                                },
                                  activeColor: Colors.green,

                                ),
                                Text('نمایش ویرایش شده ها',textScaleFactor: 0.8,style: TextStyle(color: Colors.white))

                              ],
                            )),
                        Expanded(
                            child: Row(
                              children: [
                                Checkbox(value: _showNotEdited, onChanged: (v){
                                  setState(() {
                                    _showNotEdited=v;
                                  });
                                },
                                  activeColor: Colors.green,

                                ),
                                Text('نمایش ویرایش نشده ها',textScaleFactor: 0.8,style: TextStyle(color: Colors.white),)

                              ],
                            ))

                      ],
                    ),
                  )
*/
            ],
          ),
        )

      ),

    );

  }

  Future<deleteClass> _deleteHamiDialog(context) async {
    deleteClass del=new deleteClass();
    TextEditingController delCuase=new TextEditingController();
    FocusNode delCuaseFocus=FocusNode();
    return showDialog(context: context,
    builder: (context) {
      return Directionality(textDirection: TextDirection.rtl, child: AlertDialog(

        title: Text('آیا از حذف مطمئنید؟'),
        content: TextField(
          focusNode: delCuaseFocus,
          controller: delCuase,
          maxLines: 3,
          //expands: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              gapPadding: 2
            ),
            hintText: 'دلیل حذف حامی (اجباری)',
            contentPadding: EdgeInsets.all(3),
            isCollapsed: false,

          ),
          style: TextStyle(fontSize: 12),

        ),
        actions: [
          RaisedButton(
              child: Row(children: [
                Icon(Icons.delete_forever,color: Colors.white,),
                Text('بلی مطمئنم',style: TextStyle(color:Colors.white),)
              ],),
              color: Colors.red,
              onPressed: (){
                if(delCuase.text.isEmpty)
                  delCuaseFocus.requestFocus();
                else{
                  setState(() {
                    del.isDelete=true;
                    del.deleteCuase=delCuase.text;

                  });
                  Navigator.pop(context,del);
                }

              }),
          RaisedButton(
              child: Row(children: [
                Icon(Icons.assignment_return_outlined,color: Colors.white,),
                Text('خیر نمی خواهم',style: TextStyle(color:Colors.white),)
              ],),
              color: Colors.blue.shade900,
              onPressed: (){
                Navigator.pop(context);
              })

        ],
      ));
    },
    );

  }
  
  Future<bool> deleteHami(DeleteHami Hami) async{
    var x=deleteHamiToJson(Hami);
    var result=await http.post(globalVars.s_url+'api/Madadkar/DeleteHamiById',
    headers: {
      'content-type':'application/json'
    },
    body: x,
    );
    if(result.statusCode==200)
      return true;
    return false;
  }
}

class deleteClass{
  bool isDelete;
  String deleteCuase;
}



DeleteHami deleteHamiFromJson(String str) => DeleteHami.fromJson(json.decode(str));

String deleteHamiToJson(DeleteHami data) => json.encode(data.toJson());

class DeleteHami {
  DeleteHami({
    this.hamiId,
    this.deleteCuase,
  });

  int hamiId;
  String deleteCuase;

  factory DeleteHami.fromJson(Map<String, dynamic> json) => DeleteHami(
    hamiId: json["HamiId"],
    deleteCuase: json["deleteCuase"],
  );

  Map<String, dynamic> toJson() => {
    "HamiId": hamiId,
    "deleteCuase": deleteCuase,
  };
}
