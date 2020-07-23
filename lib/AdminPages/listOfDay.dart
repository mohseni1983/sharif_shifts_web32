import 'dart:convert';
import 'package:persian_date/persian_date.dart' as psdate;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharif_shifts/classes/JobShifts.dart';
import 'package:sharif_shifts/ui/theme.dart' as Theme;
import 'package:http/http.dart' as http;
class ListOfDay extends StatefulWidget {
  @override
  _ListOfDayState createState() => _ListOfDayState();
}

class _ListOfDayState extends State<ListOfDay> {

  String Today='';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "Yekan"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Future<JobShifts> getTodayShift() async{
    var response=await http.get('http://188.0.240.6:8021/api/Job/GetTodyJobSchedule');
    debugPrint(response.body.length.toString());
    if(response.statusCode==200 && response.body.length>4){
      var res=json.decode(response.body);
      var result=JobShifts.fromJson(res);
      if(result!=null)
        return result;
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return
        Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('لیست امروز $Today'),

            ),
            body:
            Container(
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
                child:
                FutureBuilder<JobShifts>(
                  future: getTodayShift(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState){
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return Center(
                            child: Container(
                              height: 30,
                             // width: 30,
                              child: Text('Get Data'),
                            ));
                        break;
                      case ConnectionState.done:
                        if(snapshot.hasData){

                        if(snapshot.data.jobShift!=null)
                          return ListView.builder(
                            itemCount: snapshot.data.jobShift.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onDoubleTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShiftDetails(
                                      shift: snapshot.data.jobShift[index],
                                      jobDate: snapshot.data.jobDate,
                                    ),));
                                  },
                                  child:new
                                  Card(
                                    child:
                                      Container(
                                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                        child:
                                        Column(
                                          children: [
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                new Text('شیفت:  ${snapshot.data.jobShift[index].shiftStartTime} - ${snapshot.data.jobShift[index].shiftEndTime} ** ${dateshow(snapshot.data.jobDate)} '),
                                                new Icon(Icons.arrow_forward)
                                              ],
                                            )
                                          ],
                                        ),

                                      )
                                  ) ,
                                );
                              },);
                        else
                          return Center(
                            child: Container(
                              height: 30,
                              //width: 30,
                              child:Text('No Shift'),
                            ),
                          );


                        }else{
                         return Center(
                            child: Container(
                              height: 30,
                              //width: 30,
                              child: Text('No Data'),
                            ),
                          );
                        }

                    }
                    return Center(
                      child: Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                )
            )
            ,
          ),
        );

  }
  String dateshow(String date) {
    String dt;
    psdate.PersianDate p = new psdate.PersianDate();
    dt='شیفت تعریف نشده';

    dt = p.gregorianToJalali(date);
    dt = dt.replaceAll('-', '/').substring(0, 10);

    return dt;
  }
}

class ShiftDetails extends StatefulWidget {
  final JobShift shift;
  final String jobDate;

  const ShiftDetails({Key key, this.shift, this.jobDate}) : super(key: key);
  @override
  _ShiftDetailsState createState() => _ShiftDetailsState();
}

class _ShiftDetailsState extends State<ShiftDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "Yekan"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Future<JobShift> getShift() async{
    var response=await http.post('http://188.0.240.6:8021/api/Job/GetShiftById?ShiftId=${widget.shift.id}');
    debugPrint(response.body.length.toString());
    if(response.statusCode==200 ){
      var res=json.decode(response.body);
      var result=JobShift.fromJson(res);
      if(result!=null)
        return result;
    }
    return null;
  }

  Future<bool> _agreeDialog() {
    return showDialog(
        context: context,
        builder: (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('آیا اطمینان دارید؟'),
            content: Text('آیا می خواهید این ساعت ثبت شود'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('خیر'),
              ),
              FlatButton(
                onPressed: () =>Navigator.of(context).pop(true),
                /*Navigator.of(context).pop(true)*/
                child: Text('بلی'),
              ),
            ],
          ),
        )) ??
        false;
  }


  @override
  Widget build(BuildContext context) {
    return
      Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('لیست حضور و غیاب'),

          ),
          body:
          Container(
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
              //${widget.jobDate} - ${widget.shift.shiftStartTime} تا ${widget.shift.shiftEndTime}
              child:new Column(
                children: [
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    color:Colors.black,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: new Column(
                      children: [
                        new Text('تاریخ شیفت ${dateshow(widget.jobDate)}',style: TextStyle(color: Colors.white),),
                        new Text('${widget.shift.shiftStartTime} تا ${widget.shift.shiftEndTime}',style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                    FutureBuilder<JobShift>(
                      future: getShift(),
                      builder: (context, snapshot) {
                        switch(snapshot.connectionState){
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                          return Center(
                            child: new Text('در حال دریافت اطلاعات'),
                          );
                          break;
                          case ConnectionState.done:
                            if(snapshot.hasData && snapshot.data.shiftPersons!=null)
                              {
                                return
                                  ListView.builder(
                                  itemCount: snapshot.data.shiftPersons.length,
                                  itemBuilder: (context, index) {
                                    var s=snapshot.data.shiftPersons;
                                    return Card(
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${s[index].madadkarName}'),
                                            Container(
                                              child: Row(
                                                children: [
                                                  s[index].enterTime==null?
                                                  MaterialButton(
                                                    color: Colors.green,

                                                    onPressed:  (){
                                                      _agreeDialog().then((value) {
                                                        if(value)
                                                          _registerEnterTime(s[index].id,s[index].shiftId).then((value) {
                                                            if(value)
                                                              {
                                                                setState(() {

                                                                });
                                                              }
                                                          });
                                                      }
                                                      );
                                                    },
                                                    child: Text('ثبت حضور'),
                                                  ):
                                                  MaterialButton(
                                                    color: Colors.green,
                                                    disabledColor: Colors.grey,

                                                    //onPressed:  (){},
                                                    child: Text('${s[index].enterTime.substring(0,8)}'),
                                                  )
                                                  ,
                                                  Padding(padding: EdgeInsets.only(left: 15),),
                                                  s[index].enterTime==null?
                                                  MaterialButton(
                                                    color: Colors.red,

                                                    child: Text('ثبت خروج'),
                                                  ):
                                                   s[index].exitTime==null?
                                                  MaterialButton(
                                                    color: Colors.red,
                                                    onPressed: (){
                                                     _agreeDialog().then((value) {
                                                       if(value)
                                                         _registerExitTime(s[index].id,s[index].shiftId).then((value) {
                                                           if(value)
                                                             setState(() {

                                                             });
                                                         }
                                                         );
                                                     });
                                                    },
                                                    child: Text('ثبت خروج'),
                                                  ):

                                                  MaterialButton(
                                                    disabledColor: Colors.grey,
                                                    color: Colors.red,
                                                    //onPressed: (){},
                                                    child: Text('${s[index].exitTime.substring(0,8)}'),
                                                  )
                                                  ,
                                                ],
                                              ),
                                            )

                                          ],
                                        ),

                                      ),
                                    );
                                  },);

                              }
                        }
                        return Center(
                          child: new Text('در حال دریافت اطلاعات'),
                        );
                      },
                    )
                    ,
                  )
                ],
              )
          )
          ,
        ),
      );
    
    

  }
  String dateshow(String date) {
    String dt;
    psdate.PersianDate p = new psdate.PersianDate();
    dt='شیفت تعریف نشده';
    
      dt = p.gregorianToJalali(date);
      dt = dt.replaceAll('-', '/').substring(0, 10);
    
    return dt;
  }

  Future<bool> _registerEnterTime(int ShiftPersonId,int JobShiftId ) async{
    var response=await http.post('http://188.0.240.6:8021/api/Job/AddEntranceTime?ShiftPersonId=$ShiftPersonId&JobShiftId=$JobShiftId');
    if(response.statusCode==200)
      return true;
    return false;


  }

  Future<bool> _registerExitTime(int ShiftPersonId,int JobShiftId ) async{
    var response=await http.post('http://188.0.240.6:8021/api/Job/AddExitTime?ShiftPersonId=$ShiftPersonId&JobShiftId=$JobShiftId');
    if(response.statusCode==200)
      return true;
    return false;


  }

}

