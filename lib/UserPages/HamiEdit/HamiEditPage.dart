import 'package:flutter/material.dart';

class HamiEditPage extends StatefulWidget {
  final int hamiId;

  const HamiEditPage({Key key, this.hamiId}) : super(key: key);
  @override
  _HamiEditPageState createState() => _HamiEditPageState();
}

class _HamiEditPageState extends State<HamiEditPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: ,
        ),
      ),
    )
  }
}
