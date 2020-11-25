import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sharif_shifts/classes/hami.dart';
import 'package:http/http.dart' as http;
import 'package:sharif_shifts/classes/globalVars.dart';

class hamiList extends StatefulWidget {

  @override
  _hamiListState createState() => _hamiListState();
}

class _hamiListState extends State<hamiList> {

  String _filter = '';

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
          child: new Column(
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
                child: FutureBuilder<List<HamisInfo>>(
                  future: GetHamis(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var s = snapshot.data;

                      return ListView.builder(
                        itemCount: s.length,
                        itemBuilder: (context, index) {
                          if (_filter != null) {
                            return '${s[index].hamiLName}'
                                .contains(_filter) ||
                                '${s[index].hamiFName}'
                                    .contains(_filter) ||
                                '${s[index].hamiMobile1}'
                                    .contains(_filter) ||
                                '${s[index].hamiMobile2}'
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
                                          .spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        new Container(

                                          child: new Text(
                                              '${s[index].hamiFName} ${s[index]
                                                  .hamiLName}'),

                                        ),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          child: IconButton(
                                            icon: Icon(Icons.edit),
                                            color: Colors.blueAccent,
                                            onPressed: (){
                                              debugPrint(s[index].hamiId.toString());
                                            },
                                          ),
                                        )

                                      ],
                                    ),

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
                                                  .hamiFName} ${s[index]
                                                  .hamiLName}'),

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
                        width: 150,
                        child: new Column(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            new Text('در حال دریافت اطلاعات')
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
