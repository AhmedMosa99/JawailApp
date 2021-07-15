import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
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

class _AddressState extends State<Address> {
  TextEditingController address = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  GlobalKey<FormState> formstateaddress = GlobalKey<FormState>();
  String token="";
  String validglobal(String val) {
    if (val.isEmpty) {
      return "يجب الا يكون الحقل فارغ ";
    }
  }
  postAddress() async {
    var formdata = formstateaddress.currentState;
    if (formdata.validate()) {
      formdata.save();
      var data={"shippingAddress": {
        "address": address.text,
        "postalCode": postalCode.text,
        "city": city.text
      }
      };
      String Data=json.encode(data);
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.get("token");
      var url = "https://jawali-api.herokuapp.com/api/orders";
      var response = await http.post(url,body: Data,headers: {"Content-Type":"application/json",
        "Authorization": "Bearer ${token}",});
      print(response.body);
      var responsebody = jsonDecode(response.body);
      if (response.statusCode == 201) {
        _showDialogall(context, "تم   ", "تم تسجيل بياناتك ");
        print("yes success");
        print(responsebody);
        final channel = IOWebSocketChannel.connect('wss://jawali-api.herokuapp.com');
        channel.sink.add(responsebody['_id']);
        Navigator.of(context).pushNamed('home');
      } else {
        print("notValid");
        _showDialogall(context, "خطا", " إدخال خاطئ ");
      }
    }
  }

  @override
  void initState() {
        setState(() {
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height:MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
              ),

              Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20)),
                      buildContainerAvatar(mdw),
                          buildFormBoxSingUp(mdw),
                      Container(
                        margin: EdgeInsets.only(top:10),
                        child: Column(
                          children: [
                            RaisedButton(
                              color: Colors.blue,
                              onPressed:(){
                                postAddress();

                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width:150,
                                        child: Center(
                                          child: Text(
                                           "إرسال",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
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


  Center buildFormBoxSingUp(double mdw) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutExpo,
        margin: EdgeInsets.only(top: 0),
        height: MediaQuery.of(context).size.height/1.9,
        width: mdw / 1.1,
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
          key: formstateaddress,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " العنوان",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextFormFieldAll(
                      false, "ادخل العنوان ", address, validglobal),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "رمز البريد ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextFormFieldAll(
                      false, "ادخل رمز البريد  ", postalCode, validglobal),
                  Text(
                    " المدينة",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTextFormFieldAll(
                      false, "ادخل المدينة ", city, validglobal),
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
        color: Colors.grey[800] ,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 4, spreadRadius: 0.1),
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
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

}

