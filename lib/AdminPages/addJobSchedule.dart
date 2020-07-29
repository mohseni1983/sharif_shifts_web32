import 'dart:async';
import 'dart:convert';
import 'package:sharif_shifts/classes/globalVars.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:sharif_shifts/classes/JobShifts.dart';
import 'package:sharif_shifts/ui/theme.dart' as Theme;
import 'package:persian_date/persian_date.dart' as psdate;
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class addScheduleEvent extends StatefulWidget {
  @override
  _addScheduleEventState createState() => _addScheduleEventState();
}

class _addScheduleEventState extends State<addScheduleEvent> {
  static List<JobShift> list = new List<JobShift>();
  JobShifts jobShiftsList = new JobShifts();
  bool isSaving = true;
  bool dateEditing = true;
  TextEditingController dateInput = new TextEditingController();
  var shiftDate = DateTime.now().add(new Duration(days: 2));

  String mindate;
  String startdate;


  //دریافت دیتای مربوط به شیفت ها
  Future<JobShifts> GetShiftData(String date) async {
    var result = await http.get(
        '${globalVars.s_url}api/Job/GetTodyJobSchedule?now=' +
            date);
    if (result.statusCode == 200 && json.decode(result.body) != null) {
      var jsonresult = json.decode(result.body);
      var shift = JobShifts.fromJson(jsonresult);
      return shift;
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   // this.dispose();
  }
  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    setState(() {
      isSaving = true;
      //jobShiftsList.jobShift = list;
    });
    setState(() {
      jobShiftsList.jobShift = list;

      jobShiftsList.jobDate = GetDate(shiftDate, '-') + ' 00:00:00';
      var regDate = shiftDate.add(new Duration(days: -1));
      jobShiftsList.registerStart = GetDate(regDate, '-') + ' 07:00:00';
      jobShiftsList.registerEnd = GetDate(regDate, '-') + ' 14:00:00';
      jobShiftsList.description = 'ساعت ثبت شیفت از 7 تا 14 می باشد';

      isSaving = false;
    });
    GetShiftData(GetDate(shiftDate, '-')).then((value) {
      if (value != null)

      {
        setState(() {
          jobShiftsList = value;
          isSaving = false;
          setState(() {});
        });
      }
    });
    //اینجا در داخل شیفت
    setState(() {
      psdate.PersianDate p = new psdate.PersianDate();
      mindate = p.gregorianToJalali(DateTime.parse(jobShiftsList.jobDate)
          .add(Duration(days: -3))
          .toString());
      mindate = mindate.replaceAll('-', '/').substring(0, 10);
      startdate = p.gregorianToJalali(DateTime.parse(jobShiftsList.jobDate)
          .add(Duration(days: -2))
          .toString());
      startdate = startdate.replaceAll('-', '/').substring(0, 10);
    });
  }

  //init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isSaving = true;
      //jobShiftsList.jobShift = list;
    });
    setState(() {
      jobShiftsList.jobShift = list;

      jobShiftsList.jobDate = GetDate(shiftDate, '-') + ' 00:00:00';
      var regDate = shiftDate.add(new Duration(days: -1));
      jobShiftsList.registerStart = GetDate(regDate, '-') + ' 07:00:00';
      jobShiftsList.registerEnd = GetDate(regDate, '-') + ' 14:00:00';
      jobShiftsList.description = 'ساعت ثبت شیفت از 7 تا 14 می باشد';

      isSaving = false;
    });
    GetShiftData(GetDate(shiftDate, '-')).then((value) {
      if (value != null)

      {
        setState(() {
          jobShiftsList = value;
          isSaving = false;
          setState(() {});
        });
      }
    });
    //اینجا در داخل شیفت
    setState(() {
      psdate.PersianDate p = new psdate.PersianDate();
      mindate = p.gregorianToJalali(DateTime.parse(jobShiftsList.jobDate)
          .add(Duration(days: -3))
          .toString());
      mindate = mindate.replaceAll('-', '/').substring(0, 10);
      startdate = p.gregorianToJalali(DateTime.parse(jobShiftsList.jobDate)
          .add(Duration(days: -2))
          .toString());
      startdate = startdate.replaceAll('-', '/').substring(0, 10);
    });
  }

  //افزودن یک شیفت به شیفت ها
  Future AddJobToScheduleDb() async {
    setState(() {
      isSaving = true;
    });
    var body = jobShiftsList.toJson();
    var bodyJson = jsonEncode(body);
    //debugPrint('============================================');
   // debugPrint(bodyJson.toString());
    var result = await http.post('${globalVars.s_url}api/Job/AddSchedule',
        body: bodyJson,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json"
        });
    if (result.statusCode == 200) {
      debugPrint("***********************************************");
      setState(() {
        isSaving = false;
      });

      Navigator.pop(context);
    } else {
      setState(() {
        isSaving = false;
      });
    }
  }

  //نمایش انتخاب کننده تاریخ
  void _showDateTimePicker() {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return PersianDateTimePicker(
          type: 'date', //optional ,default value is date.

          //initial: '1398/03/20 19:50', //optional
          min: mindate,
          // max: '1399/06/01',
          initial: startdate,

          color: Colors.green,
          onSelect: (date) {
            psdate.PersianDate p = new psdate.PersianDate();

            var x = date.replaceAll('/', '-') + ' 00:00';
            var s = p.jalaliToGregorian(x);
            var ss=s.toString().substring(0,10);
            GetShiftData(ss ).then((value) {
              if(value==null)
                setState(() {
                  jobShiftsList.jobDate = s.toString();
                 jobShiftsList.jobShift=list;

                });
              else
               setState(() {
                 jobShiftsList=value;
                 setState(() {

                 });
               });
            });



           // GetShiftData(s.toString());

            //debugPrint(s.toString());
          },
        );
      },
    );
  }

  //ویجت نمایش تاریخ در سربرگ
  Widget dateshow() {
    psdate.PersianDate p = new psdate.PersianDate();
    String dt = p.gregorianToJalali(jobShiftsList.jobDate);
    dt = dt.replaceAll('-', '/').substring(0, 10);
    return Text(
      '$dt',
      style: TextStyle(color: Colors.yellow),
      textScaleFactor: 1.4,
    );
  }

  Future<DateTime> _selectDate() async {
    String picked = await jalaliCalendarPicker(
      context: context,
      convertToGregorian: true,
    ); // نمایش خروجی به صورت میلادی
    if (picked != null) {
      return DateTime.parse(picked);
    }
    return null;
  }

  //دریافت تاریخ بصورت متن استاندارد مورد نیاز
  String GetDate(DateTime date, String SepratorChar) {
    var sp = SepratorChar;
    String Year = date.year.toString();
    String Month = date.month.toString();
    if (Month.length == 1) Month = '0' + Month;
    String Day = date.day.toString();
    if (Day.length == 1) Day = '0' + Day;
    return Year + sp + Month + sp + Day;
  }

  //ویجت اصلی
  @override
  Widget build(BuildContext context) {
    //jobShiftsList.registerStart=
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
                title: Text('تعریف شیفت مددکاری'),
                centerTitle: true,
              ),
              floatingActionButton: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 80.0,
                    left: 10.0,
                    child: FloatingActionButton(
                      heroTag: 'افزودن شیفت',
                      elevation: 3.0,
                      //splashColor: Colors.white,

                      onPressed: _showAddDialog,
                      child: Icon(Icons.add_box),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.white, width: 2)),
                      backgroundColor: Colors.green,
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    child: FloatingActionButton(
                      heroTag: 'ذخیره سازی',
                      onPressed: () {
                        AddJobToScheduleDb();
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

                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    color: Colors.white,
                                    //iconSize: 15,
                                    onPressed: () async {
                                      _showDateTimePicker();
/*
                                      DateTime now=await _selectDate();
                                      if(now!=null)
                                      setState(() {
                                        jobShiftsList.jobDate=now.toString();
                                      });
*/
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                          child: jobShiftsList.jobShift == null
                              ? Center(
                                  child: Text('شیفتی تعریف نشده است'),
                                )
                              : ListView.builder(
                                  itemCount: jobShiftsList.jobShift.length,
                                  itemBuilder: (context, index) {
                                    return  jobShiftsList.jobShift[index].deleted!=true? ShiftWidget(
                                      StartTime: jobShiftsList
                                          .jobShift[index].shiftStartTime,
                                      EndTime: jobShiftsList
                                          .jobShift[index].shiftEndTime,
                                      Quantity: jobShiftsList
                                          .jobShift[index].shiftQuantity,
                                      //deleted: jobShiftsList.jobShift[index].deleted!=null?jobShiftsList.jobShift[index].deleted:false,
                                      onDelete: () {
                                        setState(() {
                                          jobShiftsList.jobShift[index].deleted=true;

                                        });
                                      },
                                      onEdit: () {},
                                    ):Container(width: 0,height: 0,);
                                  },
                                )),
                    ],
                  )),
            ),
          );
  }

  // دیالوگ اضافه کردن شیفت ها
  void _showAddDialog() {
    TextEditingController stTime = new TextEditingController();
    TextEditingController enTime = new TextEditingController();
    bool error = false;
    List<String> errorMessages = new List<String>();
    int qt = 0;
    JobShift shift = new JobShift();

    var _formKey = new GlobalKey<FormState>();
    slideDialog.showSlideDialog(
        context: context,
        child: new Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
                height: 300,
                padding: EdgeInsets.all(8),
                child: Form(
                  key: _formKey = new GlobalKey<FormState>(),
                  child: ListView(
                    children: <Widget>[
                      new TextFormField(
                          controller: stTime,
                          validator: (v) {
                            var x = jobShiftsList.jobShift;
                            bool err = false;
                            if (v.isEmpty) {
                              return 'این فیلد اجباری است';
                            }
                            if (x.length > 0)
                              x.forEach((s) {
                                if (v.compareTo(s.shiftEndTime) == -1 &&
                                    v.compareTo(s.shiftStartTime) == 1 && s.deleted!=true)
                                  err = true;
                              });
                            if (v.compareTo(enTime.text) == 1)
                              return 'ساعت شروع باید کمتر از ساعت پایان باشد';

                            if (err == true)
                              return 'این ساعت با دیگر شیفت ها تلاقی دارد';

                            return null;
                          },
                          focusNode: new AlwaysDisabledFocusNode(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                FontAwesomeIcons.clock,
                                color: Colors.red,
                              ),
                              labelText: 'زمان شروع شیفت'),
                          onTap: () async {
                            var x = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (x != null)
                              setState(() {
                                stTime.text = getFullTimeFormat(x);
                              });
                          }),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                      ),
                      new TextFormField(
                          controller: enTime,
                          validator: (v) {
                            var x = jobShiftsList.jobShift;
                            bool err = false;
                            if (v.isEmpty) {
                              return 'این فیلد اجباری است';
                            }
                            if (x.length > 0)
                              x.forEach((s) {
                                if (v.compareTo(s.shiftEndTime) == -1 &&
                                    v.compareTo(s.shiftStartTime) == 1 && s.deleted!=true)
                                  err = true;
                              });
                            if (v.compareTo(stTime.text) == -1)
                              return 'ساعت پایان باید بیشتر از ساعت شروع باشد';

                            if (err == true)
                              return 'این ساعت با دیگر شیفت ها تلاقی دارد';
                            return null;
                          },
                          focusNode: new AlwaysDisabledFocusNode(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //prefixIcon: Icon(FontAwesomeIcons.clock),
                              prefixIcon: Icon(
                                FontAwesomeIcons.clock,
                                color: Colors.red,
                              ),
                              labelText: 'زمان پایان شیفت'),
                          onTap: () async {
                            var x = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (x != null)

                              setState(() {
                                enTime.text =getFullTimeFormat(x);
                              });
                          }),
                      Padding(
                        child: SpinBox(
                          min: 1,
                          max: 100,
                          value: 1,
                          incrementIcon: Icon(Icons.add_circle),
                          decrementIcon: Icon(Icons.remove_circle),
                          step: 1,
                          acceleration: 5,
                          decoration:
                              InputDecoration(labelText: 'تعداد افراد شیفت'),
                          onChanged: (v) {
                            {
                              setState(() {
                                qt = v.toInt();
                              });
                            }
                          },
                        ),
                        padding: const EdgeInsets.all(16),
                      ),
                      Column(
                        children: <Widget>[
                          new Row(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ButtonBar(
                                mainAxisSize: MainAxisSize.max,
                                buttonMinWidth: 120,
                                children: <Widget>[
                                  FlatButton(
                                    child: new Text('ذخیره'),
                                    color: Colors.green,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        //Set the current inputs
                                        setState(() {
                                          shift.jobId= jobShiftsList.id;
                                          shift.shiftStartTime = stTime.text;
                                          shift.shiftEndTime = enTime.text;
                                          shift.shiftQuantity = qt;
                                          shift.shiftValue = 1;
                                          shift.deleted=false;
                                        });
                                        if (error == false) {
                                          setState(() {
                                            jobShiftsList.jobShift.add(shift);
                                          });
                                          //debugPrint(list.length.toString());

                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                  ),
                                  FlatButton(
                                    child: new Text('انصراف'),
                                    color: Colors.red,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                          FormErrorWidget(
                            errors: errorMessages,
                            hasError: error,
                          )
                        ],
                      )
                    ],
                  ),
                ))));
  }

  //نمایش اسنک بار
  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style:
            TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "Yekan"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String getFullTimeFormat(TimeOfDay x) {
    String Hour=x.hour.toString();
    String Minute=x.minute.toString();
    if(Hour.length==1)
      Hour='0'+Hour;
    if(Minute.length==1)
      Minute='0'+Minute;
    return Hour+':'+Minute;
  }
}

class FormErrorWidget extends StatefulWidget {
  final bool hasError;
  final List<String> errors;

  const FormErrorWidget({Key key, this.hasError, this.errors})
      : super(key: key);

  @override
  _FormErrorWidgetState createState() => _FormErrorWidgetState();
}

class _FormErrorWidgetState extends State<FormErrorWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.hasError == true) {
      debugPrint('has error');
      List<Widget> messages = new List<Widget>();
      widget.errors.forEach((element) {
        messages.add(Text('$element'));
      });
      return Container(
        child: Column(children: messages),
      );
    }
    return Container(
      margin: EdgeInsets.all(0),
      child: Text('test'),
    );
  }
}

class errorAlarm extends StatelessWidget {
  final bool hasError;
  final List<String> errors;

  const errorAlarm({Key key, this.hasError, this.errors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hasError == true) {
      debugPrint('has error');
      List<Widget> messages = new List<Widget>();
      errors.forEach((element) {
        messages.add(Text('$element'));
      });
      return Container(
        child: Column(children: messages),
      );
    }
    return Container(
      margin: EdgeInsets.all(0),
      child: Text('test'),
    );
  }
}

class ShiftWidget extends StatelessWidget {
  final String StartTime;
  final String EndTime;
  final int Quantity;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  //final bool deleted;

  const ShiftWidget(
      {Key key,
      this.StartTime,
      this.EndTime,
      this.Quantity,
      this.onDelete,
      this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(4, 6, 4, 1),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              Theme.Colors.loginGradientEnd2,
              Theme.Colors.loginGradientStart2
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      width: double.infinity,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text(
                'ساعت شروع: $StartTime',
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.2,
              ),
              new Text(
                'ساعت پایان: $EndTime',
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.2,
              ),
              new Text(
                'تعداد: $Quantity',
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.2,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 3),
          ),
          Divider(
            color: Colors.white70,
            height: 3,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                color: Colors.green,
                onPressed: onEdit,
                child: new Row(
                  children: <Widget>[new Text('ویرایش'), new Icon(Icons.edit)],
                ),
              ),
              MaterialButton(
                color: Colors.red,
                onPressed: onDelete,
                child: new Row(
                  children: <Widget>[new Text('حذف'), new Icon(Icons.delete)],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
