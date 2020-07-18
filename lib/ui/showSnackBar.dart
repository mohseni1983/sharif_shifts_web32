import 'package:flutter/material.dart';
class showSnackBarWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String Message;

  const showSnackBarWidget({Key key, this.scaffoldKey, this.Message,}) : super(key: key);
  @override
  _showSnackBarWidgetState createState() => _showSnackBarWidgetState();
}

class _showSnackBarWidgetState extends State<showSnackBarWidget> {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    widget.scaffoldKey.currentState?.removeCurrentSnackBar();
    widget.scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        widget.Message,
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
}
