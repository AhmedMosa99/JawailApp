import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

showDalog(context, String mytitle, String mycontent) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(mytitle),
        content: Text(mycontent),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.close,
              size: 50,
            ),
          ),
        ],
      );
    },
  );
}

_showDialogall(context, String mytitle, String mycontent) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(mytitle),
        content: Text(mycontent),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.close,
              size: 50,
            ),
          ),
        ],
      );
    },
  );
}

class _LoginState extends State<Login> {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  GlobalKey<FormState> formstatesignin = GlobalKey<FormState>();
  GlobalKey<FormState> formstatesignup = GlobalKey<FormState>();
  String token="";

  savePref(String username, String email,String token,String id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("username", username);
    preferences.setString("email", email);
    preferences.setString("token", token);
    preferences.setString("id", id);
  }

  singup() async {
    var formdata = formstatesignup.currentState;
    if (formdata.validate()) {
      formdata.save();
      var data = {
        "email": email.text,
        "password": password.text,
        "name": username.text,
      };
      String Data=json.encode(data);
      var url ="https://jawali-api.herokuapp.com/api/users/register";
      var response = await http.post(url, body: Data,headers: {"Content-Type":"application/json"},);
     // print(response.body);
      var responsebody = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        print("yes success");
        _showDialogall(context, "تم   ", "تم تسجيل حسابك بنجاح");
        Navigator.of(context).pushNamed('home');
        savePref(responsebody['name'], responsebody['email'],responsebody['token'],responsebody['_id']);

      } else {
        print("notValid");
        _showDialogall(context, "خطا", " البريد الالكتروني موجود سابق ");
      }
    }
  }

  singin() async {
    var formdata = formstatesignin.currentState;
    if (formdata.validate()) {
      formdata.save();
      var data = {"email": email.text, "password": password.text};
      var url = "https://jawali-api.herokuapp.com/api/users/login";
      String Data=jsonEncode(data);
      var response = await http.post(url, body: Data,headers: {"Content-Type":"application/json"});
      var responsebody = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {


        _showDialogall(context, "العملية ناجحة", "تم");
        Navigator.of(context).pushNamed('home');
        savePref(responsebody['name'], responsebody['email'],responsebody['token'],responsebody['_id']);
        print(responsebody['_id']);
      } else {
        print("login falid");
        _showDialogall(context, "خطا", "البريد الالكتروني خاطئ");
        showDalog(context, "", "");
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      }
    } else {
      print("notValid");
    }
  }

  String validglobal(String val) {
    if (val.isEmpty) {
      return "feild cant empty";
    }
  }

  String validuser(String val) {
    if (val.trim().isEmpty) {
      return "لا يمكن ان يكون اسم المستخدم فارغ";
    } else if (val.trim().length > 20) {
      return "لا يمكن ان يكون اسم المستخدم اكتر من 20حرف";
    }
  }

  String validPassword(String val) {
    if (val.trim().isEmpty) {
      return "لا يمكن ان يكون كلمة المرور فارغ";
    }
    if (val.trim().length > 20) {
      return "لا يمكن ان يكون كلمة المرور  اكتر من 20حرف";
    }
    if (val.trim().length < 4) {
      return "لا يمكن ان يكون كلمة المرور  افل من 4حرف";
    }
  }

  String validconfirmPassword(String val) {
    if (val != password.text) {
      return "كلمة المرور غير متطابقة";
    }
  }

  String validEmail(String val) {
    if (val.trim().isEmpty) {
      return "لا يمكن ان يكون البريد الالكتروني  فارغ";
    }
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(val)) {
      return "عنوان البريد غير صحيح  ";
    }
  }

  TapGestureRecognizer _changesign;
  bool showsignin = false;
  @override
  void initState() {
    _changesign = new TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showsignin = !showsignin;
        });
      };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
              ),
              buildPositionedtop(mdw),
              buildPositionedBottom(mdw),
              Container(
                height: 1000,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: showsignin ? 20 : 30),
                          child: Text(
                            showsignin ? "انشاء حساب" : "تسجيل دخول",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      buildContainerAvatar(mdw),
                      showsignin
                          ? buildFormBoxSingUp(mdw)
                          : buildFormBoxSingIn(mdw),
                      Container(
                        margin: EdgeInsets.only(top: showsignin ? 0 : 20),
                        child: Column(
                          children: [
                            showsignin
                                ? SizedBox(
                                    height: 2,
                                    width: 0,
                                  )
                                : InkWell(
                                    onTap: () {},
                                    child: Text(
                                      "هل نسيت كلمة المرور ؟",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                            SizedBox(
                              height: showsignin ? 0 : 14,
                            ),
                            RaisedButton(
                              color: Colors.blue,
                              onPressed: showsignin ? singup : singin,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    showsignin ? "انشاء حساب" : "تسجيل دخول",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 4),
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: showsignin ? 0 : 10),
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w700),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: showsignin
                                              ? "اذا كان لديك حساب يمكنك"
                                              : "في حال ليس لديك حساب يمكنك"),
                                      TextSpan(
                                        recognizer: _changesign,
                                        text: showsignin
                                            ? " تسجيل دخول من هنا"
                                            : " انشاء حساب",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center buildFormBoxSingIn(double mdw) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeOutBack,
        margin: EdgeInsets.only(top: 20),
        height: 265,
        width: mdw / 1.2,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: .1,
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Form(
          autovalidate: true,
          key: formstatesignin,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " البريد الالكتروني",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextFormFieldAll(
                      false, "ادخل البريد الالكتروني  هنا", email, validEmail),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "كلمة المرور",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextFormFieldAll(
                      true, "ادخل كلمة المرور هنا", password, validPassword),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center buildFormBoxSingUp(double mdw) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutExpo,
        margin: EdgeInsets.only(top: 0),
        height: 428,
        width: mdw / 1.2,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: .1,
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Form(
          autovalidate: true,
          key: formstatesignup,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "اسم المستخدم",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextFormFieldAll(
                      false, "ادخل اسم المستحدم هنا", username, validuser),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "البريد الالكتروني",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextFormFieldAll(
                      false, "ادخل البريد الالكتروني", email, validEmail),
                  Text(
                    "كلمة المرور",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextFormFieldAll(
                      true, "ادخل كلمة المرور هنا", password, validPassword),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "تاكيد كلمة المرور",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextFormFieldAll(true, "ادخل كلمة المرور هنا مرة اخرى",
                      confirmPass, validPassword),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldAll(bool pass, String myhintText,
      TextEditingController myController, myvalid) {
    return TextFormField(
      validator: myvalid,
      controller: myController,
      obscureText: pass,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(4),
        hintText: myhintText,
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey[500], style: BorderStyle.solid, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.blue[500], style: BorderStyle.solid, width: 1),
        ),
      ),
    );
  }

  AnimatedContainer buildContainerAvatar(double mdw) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: showsignin ? Colors.grey[800] : Colors.yellow,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 4, spreadRadius: 0.1),
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            showsignin = !showsignin;
          });
        },
        child: Stack(
          children: [
            Positioned(
              top: 25,
              right: 25,
              child: Icon(
                Icons.person_outline,
                size: 50,
                color: Color(0xffeeeeeee),
              ),
            ),
            Positioned(
              top: 35,
              left: 60,
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: Color(0xffeeeeeee),
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned buildPositionedtop(double mdw) {
    return Positioned(
      child: Transform.scale(
        scale: 1.3,
        child: Transform.translate(
          offset: Offset(0, -mdw / 1.7),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: mdw,
            width: mdw,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(mdw),
                color: showsignin ? Colors.blue : Colors.grey[800]),
          ),
        ),
      ),
    );
  }

  Positioned buildPositionedBottom(double mdw) {
    return Positioned(
      top: 250,
      right: mdw / 1.5,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: mdw,
        width: mdw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mdw),
            color: showsignin
                ? Colors.grey[800].withOpacity(.2)
                : Colors.blue[800].withOpacity(.4)),
      ),
    );
  }
}
