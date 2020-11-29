import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharif_shifts/classes/HamiInfo.dart';
import 'package:sharif_shifts/classes/MadadjouSingle.dart';
import 'package:sharif_shifts/classes/Madadjous.dart';
import 'package:http/http.dart' as http;
import 'package:sharif_shifts/classes/globalVars.dart';

class MadadjousEdit extends StatefulWidget {
  final List<Madadjous> madadjous;
  final Hami hami;

  const MadadjousEdit({Key key, this.madadjous, this.hami}) : super(key: key);
  @override
  _MadadjousEditState createState() => _MadadjousEditState();
}

class _MadadjousEditState extends State<MadadjousEdit> {
  String _filter = '';
 List<Madadjous> s ;
 List<MadadjouSingle> addedMadadjous=new List<MadadjouSingle>();

  Future<bool> saveHamiInfo(MadadjouSingle madadjou) async{
    bool result=false;
    var _body=madadjouSingleToJson(madadjou);
    try{
      result=await http.post(globalVars.s_url+'api/Madadkar/AddMadadjouToHami',
          headers: {"Content-Type": "application/json"},
          body:   _body
      ).timeout(Duration(seconds: 15)).then((value) {

        if (value.statusCode==200)
          return true;
        else return false;
      });

    }catch(er){
      result=false;
      // debugPrint('Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'+er.toString());
    }

    // if(result.statusCode==200)
    //   return true;
    //  return false;
    //debugPrint('redssdsdsdsdsd');
    return result;



  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      s=widget.madadjous;
      widget.hami.hamiMadadjouSet.forEach((element) {
        MadadjouSingle single=new MadadjouSingle(hamiId: element.hamiId,madadjouId: element.madadjouId,madadjouLname: element.madadjouLname,madadjouFname: element.madadjouFname);
        addedMadadjous.add(single);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ویرایش مددجویان'),
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.red
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp

                )
            ),
            child:          Stack(
              children: [
                new Column(
                  children: <Widget>[
                    new Container(
                      //height: 50,
                        color: Colors.black26,
                        child: new TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.white,),
                            hintText: 'جستجوی مددجو',


                          ),

                          //controller: _searchController,
                          onChanged: (String value) {
                            debugPrint(_filter);
                            setState(() {
                              _filter = value;
                            });
                          },
                        )),
                    Expanded(
                      child:   ListView.builder(
                      itemCount: s.length,
                      itemBuilder: (context, index) {
                        if (_filter != null) {
                          return '${s[index].madadjuLName}'
                              .contains(_filter) ||
                              '${s[index].madadjuFName}'
                                  .contains(_filter)
                              ?
                          new Container(
                              decoration: new BoxDecoration(
                                color: Colors.grey.shade200.withOpacity(
                                    0.3),
                                borderRadius: new BorderRadius.circular(
                                    5.0),
                              ),
                              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                              margin: EdgeInsets.all(4),
                              child:
                              new
                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        new Container(

                                          child: new Text(
                                            '${s[index].madadjuFName} ${s[index]
                                                .madadjuLName}',textScaleFactor: 1.2,),

                                        ),
                                        IconButton(icon: Icon(Icons.add_circle,size: 35,),color: Colors.green, onPressed: (){_addToHamiMadadjous(s[index]);})


                                      ],
                                    ),

                                  )

                                ],
                              )
                          )

                              : Container(
                            width: 0,
                            height: 0,
                          );
                        }
                        return
                          new Container(
                              decoration: new BoxDecoration(
                                color: Colors.grey.shade200.withOpacity(
                                    0.3),
                                borderRadius: new BorderRadius.circular(
                                    5.0),
                              ),
                              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                              margin: EdgeInsets.all(4),
                              child:
                              new
                              Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      new Container(

                                        child: new Text(
                                            '${s[index]
                                                .madadjuFName} ${s[index]
                                                .madadjuLName}'),

                                      ),


                                    ],
                                  ),


                                ],
                              )
                          );
                      },
                    )
            ,
                    )
                  ],
                ),
                Positioned(
                  bottom: -2,
                  child:
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/3,
                    decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        border: Border.all(
                            color: Colors.white,
                            width: 2,
                            style: BorderStyle.solid

                        ),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(0,-4)

                          )
                        ]
                    ),
                    child: Column(
                      children: [
                        Text('لیست کودکان حامی',style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
                        Divider(thickness: 0.7,color: Colors.white70,indent: 15,endIndent: 15,),
                        Expanded(
                            flex: 1,
                            child:
                                addedMadadjous!=null?
                            ListView.builder(
                                itemCount: addedMadadjous.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                    padding: EdgeInsets.fromLTRB(6, 0, 6, 0),

                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      border: Border.all(color: Colors.white,style: BorderStyle.solid,width: 0.3,),
                                        borderRadius: BorderRadius.all(Radius.circular(15))

                                    ),
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('${addedMadadjous[index].madadjouFname} ${addedMadadjous[index].madadjouLname}'),
                                        IconButton(icon: Icon(Icons.remove_circle,color: Colors.red,size: 35,), onPressed: (){
                                          setState(() {
                                            addedMadadjous.removeAt(index);
                                          });
                                        })
                                      ],
                                    )
                                    ,
                                  );
                                },):
                                    Container(height: 1,)
                        ),
                        FlatButton(onPressed: (){
                          addedMadadjous.forEach((element) {
                            bool _found=false;
                            widget.hami.hamiMadadjouSet.forEach((x) {
                              if(x.madadjouId==element.madadjouId)
                                _found=true;
                            });

                            if(_found==false)
                            saveHamiInfo(element).then((value) {
                              if(value)
                                debugPrint('Saved');
                              else
                                debugPrint('Error');
                            });

                          });
                          //remove
                          widget.hami.hamiMadadjouSet.forEach((element) {
                            bool _found=false;
                            addedMadadjous.forEach((x) {
                              if(x.madadjouId==element.madadjouId)
                                _found=true;
                            });
                            if(_found=false)
                              debugPrint(element.madadjouFname+' '+element.madadjouLname);
                          });
                        },
                            color: Colors.lightBlue,
                            minWidth: MediaQuery.of(context).size.width,
                            height: 60,
                            textColor: Colors.black87,
                            child: Text('ذخیره سازی'))
                      ],
                    ),
                  )
                  ,
                ),

              ],


            ),

          )

        ));
  }

  void _addToHamiMadadjous(Madadjous madadjous) {
   bool _exist=false;
   addedMadadjous.forEach((element) {
      if(element.madadjouId==madadjous.madadjuId)
        _exist=true;
    });
   if(_exist==false){
     MadadjouSingle _set= new MadadjouSingle();
     _set.madadjouId=madadjous.madadjuId;
     _set.madadjouFname=madadjous.madadjuFName;
     _set.madadjouLname=madadjous.madadjuLName;
     _set.hamiId=widget.hami.hamiId;

     _set.addDate=DateTime.now().toString();


     setState(() {
       //debugPrint(_set.madadjouFname);
       addedMadadjous.add(_set);


     });

   }else{
     debugPrint('Vojood darad');
   }

  }
}
