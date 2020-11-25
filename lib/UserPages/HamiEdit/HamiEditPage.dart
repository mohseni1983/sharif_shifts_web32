import 'package:flutter/material.dart';
import 'package:sharif_shifts/classes/HamiInfo.dart';

class HamiEditPage extends StatefulWidget {
  final Hami hamiId;

  const HamiEditPage({Key key, this.hamiId}) : super(key: key);
  @override
  _HamiEditPageState createState() => _HamiEditPageState();
}

class _HamiEditPageState extends State<HamiEditPage> {
  Hami cHami = new Hami();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      cHami=widget.hamiId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${cHami.hamiFname } ${cHami.hamiLname}'),
          centerTitle: true,

        ),
        body: Stack(
          children: [
           Container(
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             padding: EdgeInsets.fromLTRB(5, 20, 5, 2),
             child: ListView(
               children: [
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                   Container(width: 150,child: Text('شماره موبایل 1 قبلی:'),),
                   Text(cHami.oldMobile1,textScaleFactor: 1.2,)
                 ],),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Container(width: 150,child: Text('شماره موبایل 1 جدید:'),),

                   ],)

               ],
             ),
           )
          ],
        ),
      ),
    );
  }
}
