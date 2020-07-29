import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharif_shifts/ui/theme.dart' as Theme;

class gridIcon extends StatelessWidget{
  const gridIcon({this.onPress, this.icon, this.label});

  final Icon icon;
  final String label;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child:
      new Container(
        height: 110,
        width: 110,
        //padding: EdgeInsets.all(125),
        margin: EdgeInsets.all(10),
        child:  Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            border: Border.all(color: Colors.black,width: 2,style: BorderStyle.solid)


          ),
          child:         ClipOval(
            //borderRadius: BorderRadius.all(Radius.circular(50)),
            child:
            Container(

                color: Colors.red,
                child:
                Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child:                       Container(
                          alignment: Alignment.center,
                          //color: Colors.green,
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [
                                  Color(0xFFF0F2F4),
                                  Color(0xFF838383)


                                ],
                                begin: const FractionalOffset(0.2, 0.2),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          //height: 53,
                          child: icon,
                        ),

                      ),
                      Expanded(
                        child: Container(
                          color: Colors.black,
                          //height: 43,
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(label,style: TextStyle(color: Colors.white),textScaleFactor:MediaQuery.of(context).size.height >= 775.0? 1.1:0.8,),
                        ),
                      )
                    ],
                  ),
                )
            )
            ,

          )
          ,
        )
        ,
      )
      ,
      onTap:()=> onPress(),
    );
  }

}