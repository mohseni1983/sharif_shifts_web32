import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharif_shifts/classes/HamiInfo.dart';
import 'package:http/http.dart' as http;
import 'package:sharif_shifts/classes/globalVars.dart';
class HamiEditPage extends StatefulWidget {
  final Hami hamiId;

  const HamiEditPage({Key key, this.hamiId}) : super(key: key);

  @override
  _HamiEditPageState createState() => _HamiEditPageState();
}

class _HamiEditPageState extends State<HamiEditPage> {
  Hami cHami = new Hami();
  final ContactPicker _contactPicker = new ContactPicker();

  final GlobalKey<ScaffoldState> _scaffoldKey=new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value,Color _color) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style:
        TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "Samim"),
      ),
      backgroundColor: _color,
      duration: Duration(seconds: 3),
    ));
  }

  Future<String> getContact() async{
    String _phoneNumber;
    Contact contact = await _contactPicker.selectContact();
    if(contact.phoneNumber!=null){
        _phoneNumber=contact.phoneNumber.number;
        _phoneNumber=_phoneNumber.replaceAll('+98', '0');
        _phoneNumber=_phoneNumber.replaceAll(' ', '');
        _phoneNumber=_phoneNumber.replaceAll('-', '');
        //debugPrint('***'+_phoneNumber);

    }



    return _phoneNumber;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      cHami = widget.hamiId;
    });
  }

  final _formKey = new GlobalKey<FormState>();
  bool _editFirstName=false;
  bool _editLastName=false;
  TextEditingController _firstName= new TextEditingController();
  TextEditingController _lastName=new TextEditingController();
  TextEditingController _newMobile1=new TextEditingController();
  TextEditingController _newMobile2=new TextEditingController();
  TextEditingController _newPhone1=new TextEditingController();
  TextEditingController _newPhone2=new TextEditingController();
  TextEditingController _nationalCode=new TextEditingController();
  TextEditingController _hamiEmail=new TextEditingController();

  Future<bool> saveHamiInfo() async{
  bool result=false;
    Hami _editingHami=cHami;
    if (_firstName.text!='' && _firstName.text!=_editingHami.hamiFname)
      _editingHami.newHamiFname=_firstName.text;
    if (_lastName.text!='' && _lastName.text!=_editingHami.hamiLname)
      _editingHami.newHamiLname=_lastName.text;
    if (_newMobile1.text!='' && _newMobile1.text !=_editingHami.oldMobile1)
      _editingHami.newMobile1=_newMobile1.text;
    if(_newMobile2.text!='' && _newMobile2.text!=_editingHami.oldMobile2)
      _editingHami.newMobile2=_newMobile2.text;
    if (_newPhone1.text!='')
      _editingHami.newPhone1=_newPhone1.text;
    if (_newPhone2.text!='')
      _editingHami.newPhone2=_newPhone2.text;
    if (_nationalCode.text!='')
      _editingHami.nationalCode=_nationalCode.text;
    if(_hamiEmail.text!='')
      _editingHami.email=_hamiEmail.text;
    _editingHami.editDate=DateTime.now().toString();
    _editingHami.finalSave=true;
    _editingHami.tempSave=true;
    var _body=hamiToJson(_editingHami);
    try{
      result=await http.post(globalVars.s_url+'/api/Madadkar/SaveHamiEditInfo',
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

  Future<void> _showDialog(String title,String message){
    showDialog(context: context,
    builder: (context) => new Directionality(textDirection: TextDirection.rtl,

        child: AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            MaterialButton(onPressed: (){
              Navigator.of(context).pop();
            },
            color: Colors.green,
              child: Text('قبول'),
            )
          ],
        )),
    );
  }
bool _isSaving=false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('ویرایش اطلاعات حامی'),
          centerTitle: true,
        ),
        body:
            _isSaving?
                Center(
                  child: Container(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('درحال ذخیره سازی')
                      ],
                    ),
                  ),
                ):


        Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Card(
                          color: Colors.red.shade50,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration:
                                  BoxDecoration(color: Colors.red),
                                  //height: 80,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'مشخصات فردی',
                                        style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _editFirstName?
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              fit: FlexFit.loose,
                                              child: TextFormField(
                                                //maxLength: 25,
                                                decoration: InputDecoration(
                                                    hintText: 'نام',
                                                  suffixIcon: IconButton(icon: Icon(Icons.save,color: Colors.brown,),onPressed: (){
                                                    setState(() {
                                                      cHami.newHamiFname=_firstName.text;

                                                      _editFirstName=false;
                                                    });
                                                  },)

                                      ),
                                                keyboardType:
                                                TextInputType.text,
                                                controller: _firstName,
                                                validator: (value) {
                                                  if (value.isEmpty)
                                                    return 'نام صحیح نیست';
                                                  return null;
                                                },
                                              ))
                                        ],
                                      ),
                                    ):
                                        Row(
                                          children: [
                                            Text('نام:'),
                                            cHami.newHamiFname==null?
                                            Text(cHami.hamiFname,textScaleFactor: 1.2,):
                                            Text(cHami.newHamiFname,textScaleFactor: 1.2,),
                                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                                              setState(() {
                                                cHami.newHamiFname==null?
                                                _firstName.text=cHami.hamiFname:
                                                _firstName.text=cHami.newHamiFname;
                                                _editFirstName=true;
                                              });
                                            })
                                          ],
                                        ),

                                    Divider(
                                      height: 1,
                                    ),
                                    _editLastName?
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              fit: FlexFit.loose,
                                              child: TextFormField(
                                                //maxLength: 25,
                                                decoration: InputDecoration(
                                                    hintText: 'نام خانوادگی',
                                                    suffixIcon: IconButton(icon: Icon(Icons.save,color: Colors.brown,),onPressed: (){
                                                      setState(() {
                                                        cHami.newHamiLname=_lastName.text;

                                                        _editLastName=false;
                                                      });
                                                    },)

                                                ),
                                                keyboardType:
                                                TextInputType.text,
                                                controller: _lastName,
                                                validator: (value) {
                                                  if (value.isEmpty)
                                                    return 'نام خانوادگی صحیح نیست';
                                                  return null;
                                                },
                                              ))
                                        ],
                                      ),
                                    ):
                                    Row(
                                      children: [
                                        Text('نام خانوادگی:'),
                                        cHami.newHamiLname==null?
                                        Text(cHami.hamiLname,textScaleFactor: 1.2,):
                                        Text(cHami.newHamiLname,textScaleFactor: 1.2,),
                                        IconButton(icon: Icon(Icons.edit), onPressed: (){
                                          setState(() {
                                             cHami.newHamiLname==null?
                                            _lastName.text=cHami.hamiLname:
                                            _lastName.text=cHami.newHamiLname;
                                            _editLastName=true;
                                          });
                                        })
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),

                      Card(
                          color: Colors.green.shade50,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.green),
                                  //height: 80,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone_android,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'موبایل 1',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('قبلی:'),
                                        Text(
                                          cHami.oldMobile1,
                                          textScaleFactor: 1.2,
                                        ),
                                        Checkbox(
                                          value: cHami.deleteOldMobile1 != null
                                              ? cHami.deleteOldMobile1
                                              : false,
                                          onChanged: (v) {
                                            setState(() {
                                              cHami.deleteOldMobile1 = v;
                                            });
                                          },
                                        ),
                                        Text('حذف')
                                      ],
                                    ),
                                    Divider(
                                      height: 1,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              fit: FlexFit.loose,
                                              child: TextFormField(
                                                controller: _newMobile1,
                                                maxLength: 11,
                                                decoration: InputDecoration(
                                                    hintText: 'شماره جدید'),
                                                keyboardType:
                                                    TextInputType.phone,
                                                validator: (value) {
                                                  if (value.length > 0 &&
                                                          value.length < 11 ||
                                                      value.length > 0 &&
                                                          !value
                                                              .startsWith('09'))
                                                    return 'شماره صحیح نیست';
                                                  return null;
                                                },
                                              )),
                                          IconButton(icon: Icon(Icons.contacts,size: 35,color: Colors.brown,),
                                              onPressed: () {
                                                  getContact().then((value) {
                                                    setState(() {
                                                      _newMobile1.text=value;
                                                    });
                                                  });


                                            }),


                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      Card(
                          color: Colors.blue.shade50,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.blueAccent),
                                  //height: 80,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone_android,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'موبایل 2',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    cHami.oldMobile2 != ''
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text('قبلی:'),
                                              Text(
                                                cHami.oldMobile2,
                                                textScaleFactor: 1.2,
                                              ),
                                              Checkbox(
                                                value: cHami.deleteOldMobile2 !=
                                                        null
                                                    ? cHami.deleteOldMobile2
                                                    : false,
                                                onChanged: (v) {
                                                  setState(() {
                                                    cHami.deleteOldMobile2 = v;
                                                  });
                                                },
                                              ),
                                              Text('حذف')
                                            ],
                                          )
                                        : Container(
                                            height: 0,
                                          ),
                                    cHami.oldMobile2 != ''
                                        ? Divider(
                                            height: 1,
                                          )
                                        : Container(
                                            height: 0,
                                          ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              fit: FlexFit.loose,
                                              child: TextFormField(
                                                controller: _newMobile2,
                                                  maxLength: 11,
                                                  decoration: InputDecoration(
                                                      hintText: 'شماره جدید'),
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  validator: (value) {
                                                    if (value.length > 0 &&
                                                            value.length < 11 ||
                                                        value.length > 0 &&
                                                            !value.startsWith(
                                                                '09'))
                                                      return 'شماره صحیح نیست';
                                                    return null;
                                                  })),
                                          IconButton(icon: Icon(Icons.contacts,size: 35,color: Colors.brown,),
                                              onPressed: () {
                                                getContact().then((value) {
                                                  setState(() {
                                                    _newMobile2.text=value;
                                                  });
                                                });


                                              }),

                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      Card(
                          color: Colors.orange.shade50,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.orange),
                                  //height: 80,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.contact_phone_rounded,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'تلفن 1',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              fit: FlexFit.loose,
                                              child: TextFormField(
                                                controller: _newPhone1,
                                                  maxLength: 11,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'مثال:02198765432'),
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  validator: (value) {
                                                    if (value.length > 0 &&
                                                            value.length < 11 ||
                                                        value.length > 0 &&
                                                            !value.startsWith(
                                                                '0'))
                                                      return 'شماره صحیح نیست';
                                                    return null;
                                                  })),
                                          IconButton(icon: Icon(Icons.contacts,size: 35,color: Colors.brown,),
                                              onPressed: () {
                                                getContact().then((value) {
                                                  setState(() {
                                                    _newPhone1.text=value;
                                                  });
                                                });


                                              }),

                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      Card(
                          color: Colors.deepPurple.shade50,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.deepPurple),
                                  //height: 80,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.contact_phone_rounded,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'تلفن 2',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              fit: FlexFit.loose,
                                              child: TextFormField(
                                                controller: _newPhone2,
                                                  maxLength: 11,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'مثال:02198765432'),
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  validator: (value) {
                                                    if (value.length > 0 &&
                                                            value.length < 11 ||
                                                        value.length > 0 &&
                                                            !value.startsWith(
                                                                '0'))
                                                      return 'شماره صحیح نیست';
                                                    return null;
                                                  })),
                                          IconButton(icon: Icon(Icons.contacts,size: 35,color: Colors.brown,),
                                              onPressed: () {
                                                getContact().then((value) {
                                                  setState(() {
                                                    _newPhone2.text=value;
                                                  });
                                                });


                                              }),

                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      Card(
                          color: Colors.brown.shade50,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.brown),
                                  //height: 80,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.card_membership,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'کدملی ',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              fit: FlexFit.loose,
                                              child: TextFormField(
                                                controller: _nationalCode,
                                                  maxLength: 10,
                                                  decoration: InputDecoration(
                                                      hintText: 'کد ملی حامی'),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (value) {
                                                    if (value.length > 0 &&
                                                        value.length < 10)
                                                      return 'کدملی صحیح نیست';
                                                    return null;
                                                  }))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      Card(
                          color: Colors.pink.shade50,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Colors.pink),
                                  //height: 80,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.mail_outline_rounded,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'ایمیل ',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(2, 5, 0, 5),
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              fit: FlexFit.loose,
                                              child: TextField(
                                                controller: _hamiEmail,
                                                //maxLength: 10,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'پست الکترونیک حامی'),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                              )),


                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isSaving=true;
                            });
                           // Scaffold.of(context).showSnackBar(SnackBar(content: Text('ذخیره سازی صحیح است')));
                            saveHamiInfo().then((value) {
                              setState(() {
                                _isSaving=false;
                              });
                              if(value)
                                _showDialog('عملیات موفق', 'اطلاعات با موفقیت ذخیره شد').then((value) => Navigator.of(context).pop());
                              else{
                                debugPrint('TEST TEST');
                                _showDialog('خطا در عملیات', 'در ذخیره سازی خطایی رخ داده است\r\nاتصال اینترنت را بررسی کنید');
                              }

                            });
                           // debugPrint('OK OK OK ================');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save,
                              color: Colors.white,
                              size: 35,
                            ),
                            Text(
                              'ذخیره اطلاعات',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                        color: Colors.green,
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
