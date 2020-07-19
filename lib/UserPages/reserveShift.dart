import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  JobShifts shift=new JobShifts();
  int listState=0;

  int selectedValue=-1;
  void handleSelect(int val){
    setState(() {
      selectedValue=val;
    });
  }
  Future<JobShifts> getTodayShift() async{
    var response=await http.get('http://188.0.240.6:8021/api/Job/GetTodyJobSchedule?now=' + '2020-06-18');
    if(response.statusCode==200 && response.body!=null){
      var res=json.decode(response.body);
      var result=JobShifts.fromJson(res);
      return result;
    }
    return null;
  }

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

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      getTodayShift().then((value) => shift=value);

    });
    if(shift!=null)
     {
       setState(() {
         listState=1;

       });
       shift.jobShift.forEach((e) {
         e.shiftPersons.forEach((a) {
           if(a.madadkarId==)
         });
       });
     }
    else if(shift==null)
      setState(() {
        listState=2;
      });
    super.initState();
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
                  child:
                  listState==1?ListView.builder(
                itemCount: shift.jobShift.length,
                  itemBuilder: (context, index) {
                    var item=shift.jobShift[index];
                    int itempcount=item.shiftPersons!=null?item.shiftPersons.length:0;
                    int itemshiftcount=item.shiftQuantity-itempcount;
                    if(item.deleted==false)
                      return new Card(
                        child:
                        new Container(
                          padding: EdgeInsets.all(5),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Checkbox(
                                value: item.isSelected,
                               onChanged: (v){
                                  if(itemshiftcount>0)
                                  setState(() {
                                    item.isSelected=v;
                                  });
                                  else
                                    showInSnackBar('ظرفیت این شیفت تکمیل است');
                               },
                             ),
                              Container(
                                child: Column(
                                  children: [
                                    new Text('ساعت شروع شیفت'),
                                    Padding(padding: EdgeInsets.only(bottom: 8),),
                                    Text('${item.shiftStartTime}'),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    new Text('ساعت پایان شیفت'),
                                    Padding(padding: EdgeInsets.only(bottom: 8),),

                                    Text('${item.shiftEndTime}'),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    new Text('ظرفیت باقیمانده'),
                                    Padding(padding: EdgeInsets.only(bottom: 8),),

                                    Text('${itemshiftcount}'),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    new Text('ظرفیت باقیمانده'),
                                    Padding(padding: EdgeInsets.only(bottom: 8),),

                                    Text('${itempcount}'),
                                  ],
                                ),
                              )





                            ],
                          )
                          ,
                        ),
                      );
                    return Container(padding: EdgeInsets.all(0),);
                  },):listState==2?
                      Center(
                        child: Container(
                          child: new Text('دیتایی وجود ندارد'),
                        ),
                      ):
                  Center(
                    child: Container(
                      child: new CircularProgressIndicator(),
                    ),
                  )

        )

              ]),
    )));
  }

  void reserve() {
    shift.jobShift.forEach((element) {
      if(element.deleted==false)
      {
        debugPrint('${element.shiftStartTime} ${element.shiftEndTime} ${element.isSelected}');
       // if(element.isSelected)
         // addShift(element.id, madadkarId)
        
      }
    });
  }
  
  void addShift(int shiftId,int madadkarId) async{
    var response=await http.post('http://188.0.240.6:8021/api/Job/AddShiftForMadadkar',
    body: {
      'shiftid':'$shiftId',
      'madadkarId':'$madadkarId'
    }
    );
    if(response.statusCode==200)
      debugPrint(response.body);
  }

  void removeShift(int shiftId,int madadkarId) async{
    var response=await http.post('http://188.0.240.6:8021/api/Job/RemoveShiftForMadadkar',
        body: {
          'shiftid':'$shiftId',
          'madadkarId':'$madadkarId'
        }
    );
    if(response.statusCode==200)
      debugPrint(response.body);
  }

  Widget dateshow() {
    return Text('تست' ,style: TextStyle(color: Colors.yellow),textScaleFactor: 1.3,);
  }
}
