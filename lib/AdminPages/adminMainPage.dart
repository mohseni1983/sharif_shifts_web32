import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sharif_shifts/AdminPages/listOfDay.dart';
import 'package:sharif_shifts/classes/globalVars.dart';
import 'package:sharif_shifts/login/login.dart';
import 'package:sharif_shifts/ui/CustomWidgets.dart';
import 'package:sharif_shifts/ui/theme.dart' as Theme;

import 'addJobSchedule.dart';

class adminMainPage extends StatefulWidget {
  @override
  _adminMainPageState createState() => _adminMainPageState();
}

class _adminMainPageState extends State<adminMainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> _onWillPop() {
    return
      showDialog(
      context: context,
      builder: (context) =>
          Directionality(
            textDirection: TextDirection.rtl,
            child:           AlertDialog(
              title: Text('آیا اطمینان دارید؟'),
              content: Text('آیا می خواهید از اپ خارج شوید'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('خیر'),
                ),
                FlatButton(
                  onPressed: () {
                    globalVars.token="";
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                  },
                  /*Navigator.of(context).pop(true)*/
                  child: Text('بلی'),
                ),
              ],
            ),

          )
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child:
      new Directionality(
          textDirection: TextDirection.rtl,
          child: new Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: new Text('نیکوکاران شریف'),
                centerTitle: true,
              ),
              body: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowGlow();
                  },
                  child: Center(
                    child: new Container(
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
                        child: GridView.count(
                          crossAxisCount:
                          MediaQuery.of(context).size.width >= 750.0 ? 9 : 3,
                          children: <Widget>[
                            gridIcon(
                              icon: Icon(
                                FontAwesomeIcons.clock,
                                color: Colors.black87,
                                size: 35,
                              ),
                              label: 'ایجاد شیفت',
                              onPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      new addScheduleEvent(),
                                    ));
                              },
                            ),
                            gridIcon(
                              icon: Icon(
                                FontAwesomeIcons.listUl,
                                color: Colors.black87,
                                size: 35,
                              ),
                              label: 'لیست حضور',
                              onPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListOfDay(),
                                    ));
                              },
                            ),
                            gridIcon(
                              icon: Icon(FontAwesomeIcons.list,
                              color: Colors.black,
                                size: 35,
                              ),
                              label: 'گزارش روزانه',
                              
                            )
                          ],
                        )),
                  )))),

    );
  }
}
