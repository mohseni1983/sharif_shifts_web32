import 'package:flutter/material.dart';
import 'package:sharif_shifts/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context,child)=>MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),child: child,),
      debugShowCheckedModeBanner: false,
      title: 'نرم افزار بنیاد خیریه نیکوکاران شریف',
      theme: ThemeData(

        primarySwatch: Colors.red,
        fontFamily: 'Samim',

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

