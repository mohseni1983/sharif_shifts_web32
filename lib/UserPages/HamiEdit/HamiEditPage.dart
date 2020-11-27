import 'package:flutter/cupertino.dart';
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
             padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
             child: ListView(
               children: [
                 Card(
                   color: Colors.green.shade50,
                   child:
                     IntrinsicHeight(
                       child:             Row(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                     Container(
                     decoration: BoxDecoration(
                         color: Colors.green
                     ),
                   //height: 80,
                   width: 80,
                   margin: EdgeInsets.only(left: 5),
                   child:
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Icon(Icons.phone_android,color: Colors.white,),
                       Text('موبایل 1',style: TextStyle(color: Colors.white),)
                     ],
                   ),

                 ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Text('قبلی:'),
                         Text(cHami.oldMobile1,textScaleFactor: 1.2,),

                         Checkbox(value: cHami.deleteOldMobile1!=null?cHami.deleteOldMobile1:false, onChanged: (v){setState(() {
                           cHami.deleteOldMobile1=v;
                         });},


                         ),
                         Text('حذف')
                       ],),
                     Divider(height: 1,),
                     Container(
                       width: MediaQuery.of(context).size.width-120,
                       child:
                       Row(
                         mainAxisSize: MainAxisSize.max,
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [

                           Flexible(
                               fit: FlexFit.loose,
                               child:
                               TextField(
                                 maxLength: 11,
                                 decoration: InputDecoration(
                                     hintText: 'شماره جدید'
                                 ),
                                 keyboardType: TextInputType.phone,



                               )
                           )


                         ],)
                       ,
                     )

                   ],
                 )
               ],
             ),

                     )
                 ),
                 Card(
                   color: Colors.blue.shade50,
                     child:
                     IntrinsicHeight(
                       child:             Row(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Container(
                             decoration: BoxDecoration(
                                 color: Colors.blueAccent
                             ),
                             //height: 80,
                             width: 80,
                             margin: EdgeInsets.only(left: 5),
                             child:
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Icon(Icons.phone_android,color: Colors.white,),
                                 Text('موبایل 2',style: TextStyle(color: Colors.white),)
                               ],
                             ),

                           ),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Text('قبلی:'),
                                   Text(cHami.oldMobile2,textScaleFactor: 1.2,),

                                   Checkbox(value: cHami.deleteOldMobile2!=null?cHami.deleteOldMobile2:false, onChanged: (v){setState(() {
                                     cHami.deleteOldMobile2=v;
                                   });},


                                   ),
                                   Text('حذف')
                                 ],),
                               Divider(height: 1,),
                               Container(
                                 width: MediaQuery.of(context).size.width-120,
                                 child:
                                 Row(
                                   mainAxisSize: MainAxisSize.max,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [

                                     Flexible(
                                         fit: FlexFit.loose,
                                         child:
                                         TextField(
                                           maxLength: 11,
                                           decoration: InputDecoration(
                                               hintText: 'شماره جدید'
                                           ),
                                           keyboardType: TextInputType.phone,



                                         )
                                     )


                                   ],)
                                 ,
                               )

                             ],
                           )
                         ],
                       ),

                     )
                 ),
                 Card(
                     color: Colors.orange.shade50,
                     child:
                     IntrinsicHeight(
                       child:             Row(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Container(
                             decoration: BoxDecoration(
                                 color: Colors.orange
                             ),
                             //height: 80,
                             width: 80,
                             margin: EdgeInsets.only(left: 5),
                             child:
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Icon(Icons.contact_phone_rounded,color: Colors.white,),
                                 Text('تلفن 1',style: TextStyle(color: Colors.white),)
                               ],
                             ),

                           ),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Container(
                                 width: MediaQuery.of(context).size.width-120,
                                 child:
                                 Row(
                                   mainAxisSize: MainAxisSize.max,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [

                                     Flexible(
                                         fit: FlexFit.loose,
                                         child:
                                         TextField(
                                           maxLength: 11,
                                           decoration: InputDecoration(
                                               hintText: 'شماره جدید'
                                           ),
                                           keyboardType: TextInputType.phone,



                                         )
                                     )


                                   ],)
                                 ,
                               )

                             ],
                           )
                         ],
                       ),

                     )
                 ),
                 Card(
                     color: Colors.deepPurple.shade50,
                     child:
                     IntrinsicHeight(
                       child:             Row(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Container(
                             decoration: BoxDecoration(
                                 color: Colors.deepPurple
                             ),
                             //height: 80,
                             width: 80,
                             margin: EdgeInsets.only(left: 5),
                             child:
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Icon(Icons.contact_phone_rounded,color: Colors.white,),
                                 Text('تلفن 2',style: TextStyle(color: Colors.white),)
                               ],
                             ),

                           ),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Container(
                                 width: MediaQuery.of(context).size.width-120,
                                 child:
                                 Row(
                                   mainAxisSize: MainAxisSize.max,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [

                                     Flexible(
                                         fit: FlexFit.loose,
                                         child:
                                         TextField(
                                           maxLength: 11,
                                           decoration: InputDecoration(
                                               hintText: 'شماره جدید'
                                           ),
                                           keyboardType: TextInputType.phone,



                                         )
                                     )


                                   ],)
                                 ,
                               )

                             ],
                           )
                         ],
                       ),

                     )
                 ),
                 Card(
                     color: Colors.brown.shade50,
                     child:
                     IntrinsicHeight(
                       child:             Row(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Container(
                             decoration: BoxDecoration(
                                 color: Colors.brown
                             ),
                             //height: 80,
                             width: 80,
                             margin: EdgeInsets.only(left: 5),
                             child:
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Icon(Icons.card_membership,color: Colors.white,),
                                 Text('کدملی ',style: TextStyle(color: Colors.white),)
                               ],
                             ),

                           ),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Container(
                                 width: MediaQuery.of(context).size.width-120,
                                 child:
                                 Row(
                                   mainAxisSize: MainAxisSize.max,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [

                                     Flexible(
                                         fit: FlexFit.loose,
                                         child:
                                         TextField(
                                           maxLength: 10,
                                           decoration: InputDecoration(
                                               hintText: 'کد ملی حامی'
                                           ),
                                           keyboardType: TextInputType.number,



                                         )
                                     )


                                   ],)
                                 ,
                               )

                             ],
                           )
                         ],
                       ),

                     )
                 ),
                 Card(
                     color: Colors.pink.shade50,
                     child:
                     IntrinsicHeight(
                       child:             Row(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Container(
                             decoration: BoxDecoration(
                                 color: Colors.pink
                             ),
                             //height: 80,
                             width: 80,
                             margin: EdgeInsets.only(left: 5),
                             child:
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Icon(Icons.mail_outline_rounded,color: Colors.white,),
                                 Text('ایمیل ',style: TextStyle(color: Colors.white),)
                               ],
                             ),

                           ),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Container(
                                 padding:EdgeInsets.fromLTRB(2, 5, 0, 5),
                                 width: MediaQuery.of(context).size.width-120,
                                 child:
                                 Row(
                                   mainAxisSize: MainAxisSize.max,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [

                                     Flexible(
                                         fit: FlexFit.loose,
                                         child:
                                         TextField(
                                           //maxLength: 10,
                                           decoration: InputDecoration(
                                               hintText: 'پست الکترونیک حامی'
                                           ),
                                           keyboardType: TextInputType.emailAddress,



                                         )
                                     )


                                   ],)
                                 ,
                               )

                             ],
                           )
                         ],
                       ),

                     )
                 ),
                 Padding(padding: EdgeInsets.only(top: 5)),







               ],
             ),
           )
          ],
        ),
      ),
    );
  }
}
