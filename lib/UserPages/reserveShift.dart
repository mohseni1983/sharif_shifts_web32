import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sharif_shifts/classes/JobShifts.dart';
import 'package:sharif_shifts/ui/theme.dart' as Theme;
import 'package:http/http.dart' as http;
class reserveShift extends StatefulWidget {
  @override
  _reserveShiftState createState() => _reserveShiftState();
}

class _reserveShiftState extends State<reserveShift> {
  bool isSaving =false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  Future<JobShifts> getTodayShift() async{
    var response=await http.get('http://188.0.240.6:8021/api/Job/GetTodyJobSchedule?now=' + '2020-06-18');
    if(response.statusCode==200 && response.body!=null){
      var res=json.decode(response.body);
      var result=JobShifts.fromJson(res);
      return result;
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return isSaving
        ? Scaffold(
      body: new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Theme.Colors.loginGradientStart.withAlpha(90),
                  Theme.Colors.loginGradientEnd.withAlpha(90)
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: new Center(
            child: new Container(
              height: 120,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('در حال ذخیره اطلاعات')
                ],
              ),
            ),
          )),
    )
        : Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('رزرو شیفت مددکاری'),
          centerTitle: true,
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Positioned(
              bottom: 10.0,
              left: 10.0,
              child: FloatingActionButton(
                heroTag: 'ذخیره سازی',
                onPressed: () {
                  reserve();
                },
                elevation: 3.0,
                child: Icon(Icons.save),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.white, width: 2)),
                backgroundColor: Colors.brown,
              ),
            ),
          ],
        ),
        body: new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart.withAlpha(90),
                    Theme.Colors.loginGradientEnd.withAlpha(90)
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                    color: Colors.black,
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'تاریخ شیفت:',
                              style: TextStyle(color: Colors.white),
                              textScaleFactor: 1.5,
                            ),
                            //dateEditing?
                            //      TextField():
                            dateshow(),
                            //dateEditing?

                          ],
                        ),
                      ],
                    )),
                Expanded(
                  child: FutureBuilder<JobShifts>(
                    future: getTodayShift(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: snapshot.data.jobShift.length,
                            itemBuilder: (context, index) {
                              var item=snapshot.data.jobShift[index];
                              if(item.deleted=false)
                              return Row(
                                children: [
                                  Text('${item.shiftStartTime}'),
                                  Padding(padding: EdgeInsets.only(right: 15),),
                                  Text('${item.shiftEndTime}'),

                                ],
                              );
                              return Container(padding: EdgeInsets.all(0),);
                            },);
                      }else if (snapshot.hasError){
                        return Text('Has Error');
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                )

              ]),
    )));
  }

  void reserve() {}

  Widget dateshow() {
    return Text('تست' ,style: TextStyle(color: Colors.yellow),textScaleFactor: 1.3,);
  }
}
