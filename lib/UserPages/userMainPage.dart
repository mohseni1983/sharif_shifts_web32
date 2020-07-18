import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sharif_shifts/UserPages/reserveShift.dart';
import 'package:sharif_shifts/login/login.dart';
import 'package:sharif_shifts/ui/CustomWidgets.dart';
import 'package:sharif_shifts/ui/theme.dart' as Theme;

//import 'addJobSchedule.dart';

class userMainPage extends StatefulWidget {
  @override
  _userMainPageState createState() => _userMainPageState();
}

class _userMainPageState extends State<userMainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Directionality(
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
                            label: 'رزرو شیفت',
                            onPress: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => reserveShift(),));
                            },
                          ),

                        ],
                      )),
                ))));
  }
}
