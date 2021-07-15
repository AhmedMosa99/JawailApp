import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobil_shop/compount/MyDrawer.dart';
import 'package:mobil_shop/compount/mobilelistCart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Details extends StatefulWidget {
  final qty;
  final id;
  final price;
  final screen;
  final screen_protect;
  final screen_res;
  final system;
  final ram;
  final name;
  final camera_main;
  final image;
  final cpu;
  final memory;
  final battery;
  Details({ this.qty,this.id,this.price, this.screen, this.screen_protect, this.screen_res, this.system, this.ram, this.name, this.camera_main, this.image, this.cpu, this.memory, this.battery});

  @override
  _DetailsState createState() => _DetailsState();


}

class _DetailsState extends State<Details> {
  Future putData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    String url = "https://jawali-api.herokuapp.com/api/cart/${widget.id}";
    var response = await http.put(url,headers: {"Content-Type":"application/json",
      "Authorization": "Bearer ${token}",});
    var res = jsonDecode(response.body);
    return res;
  }
  var priced;
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    putData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("التفاصيل"),
        ),
        drawer: MyDrawer(),
        body: ListView(
          children: <Widget>[
            Container(
              height: 300,
              child: GridTile(
                child: Image.network("${widget.image}"),
                footer: Container(
                  height: 80,
                  color: Colors.black.withOpacity(.2),
                  alignment: Alignment.center,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                         " ${widget.price}",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                  ),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue.shade200,
                padding: EdgeInsets.all(10),
                child: Text("المواصفات",style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: RichText(text: TextSpan(children: <TextSpan>[
                  TextSpan(text: "الشاشة : ",style: TextStyle(
                    color:Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: "${widget.screen}",style: TextStyle(
                    color:Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ]
                ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.lightBlue,
                child: RichText(text: TextSpan(children: <TextSpan>[
                  TextSpan(text: "دقة الشاشة : ",style: TextStyle(
                      color:Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: "${widget.screen_res}",style: TextStyle(
                      color:Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                ]
                ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: RichText(text: TextSpan(children: <TextSpan>[
                  TextSpan(text: "الذاكرة: ",style: TextStyle(

                      color:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: widget.memory,style: TextStyle(
                      color:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                ]
                ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.lightBlue,
                child: RichText(text: TextSpan(children: <TextSpan>[
                  TextSpan(text: "رام : ",style: TextStyle(

                      color:Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: widget.ram,style: TextStyle(
                      color:Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                ]
                ),
                ),
              ),
            ),
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: RichText(text: TextSpan(children: <TextSpan>[
                  TextSpan(text: "التخزين الداخلي : ",style: TextStyle(
                      color:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: " 128/512 جيجابايت",style: TextStyle(
                      color:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                ]
                ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.lightBlue,
                child: RichText(text: TextSpan(children: <TextSpan>[
                  TextSpan(text: "لمُعالع : ",style: TextStyle(
                      color:Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: widget.cpu,style: TextStyle(
                      color:Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                ]
                ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: RichText(text: TextSpan(children: <TextSpan>[
                  TextSpan(text: " الكاميرا:  ",style: TextStyle(
                      color:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: widget.camera_main,style: TextStyle(
                      color:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                ]
                ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.lightBlue,
                child: RichText(text: TextSpan(children: <TextSpan>[
                  TextSpan(text: " نظام التشغيل : ",style: TextStyle(
                      color:Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: widget.system,style: TextStyle(
                      color:Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                ]
                ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: GestureDetector(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text("أضف إلى السلة".toUpperCase(),style: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.bold,fontSize: 20),),
                  onPressed: (){
                    setState(() {
                      putData();
                      MobileListCart mobileList=MobileListCart(price: widget.price,
                        screen: widget.screen,
                        screen_protect: widget.screen_protect,
                        system: widget.system,
                        screen_res: widget.screen_res,
                        cpu: widget.cpu,
                        camera_main: widget.camera_main,
                        battery: widget.battery,
                        name: widget.name,
                        ram: widget.ram,
                        memory: widget.memory,
                        image : widget.image,);
                      Navigator.pushNamed(context, 'home');
                    });
                  },
                ),
              ),
              ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
