import 'dart:convert';
import 'package:package_info/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sharif_shifts/AdminPages/adminMainPage.dart';
import 'package:sharif_shifts/UserPages/userMainPage.dart';
import 'package:sharif_shifts/classes/globalVars.dart';
import 'package:sharif_shifts/ui/theme.dart' as Theme;
import 'package:sharif_shifts/login/bubble.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PackageInfo packageInfo=new PackageInfo();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  bool isLogin = false;

  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController adminUserController = new TextEditingController();
  TextEditingController adminNameController = new TextEditingController();
  TextEditingController adminPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

  Color left = Colors.white;
  Color right = Colors.red;

  bool _isSave=false;


  //Function for login Madadkars
  Future<void> loginToSystem() async {
    setState(() {
      isLogin = true;
    });
    final SharedPreferences prefs=await _prefs;

    String username = loginEmailController.text;
    String password = loginPasswordController.text;
    var result = await http.post('${globalVars.s_url}' + 'token', body: {
      'grant_type': 'password',
      'username': username,
      'password': password
    });
    if (result.statusCode == 200) {
      //debugPrint('${result.body}');

      var jResult = json.decode(result.body);

      //debugPrint(jResult['access_token']);
      setState(() {
        //token=jResult;
        var x = 'aa';
        globalVars.token = jResult['access_token'];
        isLogin = false;
      });

      getMadadkarInfo().then((value) {
        if (_isSave){
          prefs.setString('username', username);
          prefs.setString('password', password);
          prefs.setBool('isSave', _isSave);

        }else{
          prefs.clear();
        }
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return new userMainPage();
          },
        ));
      });
      //showInSnackBar('ورود به سیستم اوکی هست');
      // sharedPreferences = await SharedPreferences.getInstance();
      //debugPrint(jResult['access_token']);
      //  sharedPreferences.setString('token', jResult['access_token']);
      //debugPrint(prefs.get('token'));
      //http.post(ServerUrl+'')
      /*madadkarInfo info = await getMadadkarInfo();
      setState(() {
        globalmadadkar=info;
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => mainPage(madadkar: info,),));*/
      /* getMadadkarInfo().then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => mainPage(madadkar: value,),));
      });*/
    } else {
      setState(() {
        isLogin = false;
      });
      showInSnackBar('نام کاربری یا رمز عبور اشتباه است');
    }
  }

  Future<void> adminsLogin() {
    if (adminUserController.text == 'modir' &&
        adminPasswordController.text == 'iran1399')
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => adminMainPage(),
          ));
    else
      showInSnackBar('نام کاربری و رمز عبور اشتباه است');
  }

  Future<void> getMadadkarInfo() async {
    var response = await http
        .post('${globalVars.s_url}api/Madadkar/GetMadadkarInfo', headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${globalVars.token}"
    });
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      globalVars.MadadkarName = result['MadadkarName'];
      globalVars.MadadkarId = result['MadadkarId'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: new Directionality(
          textDirection: TextDirection.rtl,
          child: new Scaffold(
            key: _scaffoldKey,
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              },
              child: isLogin
                  ? Center(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new CircularProgressIndicator(
                            backgroundColor: Color(0xFFB4B4B4),
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.yellow),
                          ),
                          new Text(
                            'در حال ورود به سیستم',
                            style: TextStyle(color: Colors.white),
                            textScaleFactor: 1.3,
                          )
                        ],
                      ),
                    ))
                  : SingleChildScrollView(
                      child: Container(
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
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: new Image(
                                  width: 250.0,
                                  height: 250.0,
                                  fit: BoxFit.fill,
                                  image: new AssetImage(
                                      'assets/images/Mini-Logo.png')),
                            ),
                            Text('نسخه:${packageInfo.version}.${packageInfo.buildNumber}',textScaleFactor: 0.8,),
                            //Text('${DateTime.now().toUtc().add(new Duration(hours: 4,minutes: 30))}'),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: _buildMenuBar(context),
                            ),
                            Expanded(
                              flex: 2,
                              child: PageView(
                                controller: _pageController,
                                onPageChanged: (i) {
                                  if (i == 0) {
                                    setState(() {
                                      right = Colors.red;
                                      left = Colors.white;
                                    });
                                  } else if (i == 1) {
                                    setState(() {
                                      right = Colors.white;
                                      left = Colors.red;
                                    });
                                  }
                                },
                                children: <Widget>[
                                  new ConstrainedBox(
                                    constraints: const BoxConstraints.expand(),
                                    child: _buildSignIn(context),
                                  ),
                                  new ConstrainedBox(
                                    constraints: const BoxConstraints.expand(),
                                    child: _buildSignUp(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    /*  setState(() {
      loginEmailController.text='09378170204';
      loginPasswordController.text='48067';
    });*/
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        packageInfo=value;
      });
    });
    _prefs.then((SharedPreferences prefs) {
      if (prefs.getBool('isSave')){
        setState(() {
          loginEmailController.text=prefs.getString('username');
          loginPasswordController.text=prefs.getString('password');
          _isSave=prefs.getBool('isSave');
        });
      }
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

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

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "مدیران",
                  style: TextStyle(
                      color: left, fontSize: 16.0, fontFamily: "Samim"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "مددکاران",
                  style: TextStyle(
                      color: right, fontSize: 16.0, fontFamily: "Samim"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            // overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 200.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "Samim",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.userCircle,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "نام کاربری",
                            hintStyle:
                                TextStyle(fontFamily: "Samim", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "Samim",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "رمز عبور",
                            hintStyle:
                                TextStyle(fontFamily: "Samim", fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 170.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Theme.Colors.loginGradientStart,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                      BoxShadow(
                        color: Theme.Colors.loginGradientEnd,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    gradient: new LinearGradient(
                        colors: [
                          Theme.Colors.loginGradientEnd2,
                          Theme.Colors.loginGradientStart2
                        ],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Theme.Colors.loginGradientEnd2,
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "ورود",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: "Samim"),
                        ),
                      ),
                      onPressed: () =>
                          //  showInSnackBar("Login button pressed")),
                          loginToSystem()
                  )
              ),
            ],
          ),
/*
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "رمز عبور را فراموش کرده ام?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "Samim"),
                )),
          ),
*/
/*
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white10,
                          Colors.white,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white10,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),
*/
          Divider(
            color: Colors.black.withAlpha(50),
            thickness: 2,
            indent: 55,
            endIndent: 55,

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(value: _isSave, onChanged: (value){
                setState(() {
                  _isSave=value;
                });
              }),
              Text('ذخیره اطلاعات ورود')
            ],
          )

        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            //overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 200.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmail,
                          controller: adminUserController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "Samim",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            hintText: "ایمیل",
                            hintStyle:
                                TextStyle(fontFamily: "Samim", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePassword,
                          controller: adminPasswordController,
                          obscureText: _obscureTextSignup,
                          style: TextStyle(
                              fontFamily: "Samim",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "رمز عبور",
                            hintStyle:
                                TextStyle(fontFamily: "Samim", fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                _obscureTextSignup
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 170.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Theme.Colors.loginGradientStart,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                      BoxShadow(
                        color: Theme.Colors.loginGradientEnd,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    gradient: new LinearGradient(
                        colors: [
                          Theme.Colors.loginGradientEnd2,
                          Theme.Colors.loginGradientStart2
                        ],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Theme.Colors.loginGradientEnd,
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "ورود مدیران",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: "Samim"),
                        ),
                      ),
                      onPressed: () =>
                          // showInSnackBar("SignUp button pressed")),
                          adminsLogin())),
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
}
