import 'dart:convert';
import 'package:mobil_shop/pages/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobil_shop/compount/details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MobileListCart extends StatefulWidget {
  final qty;
  final id;
  final price;
  var totalPrice;
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


  MobileListCart({this.qty,this.totalPrice,this.id,this.price, this.screen, this.screen_protect, this.screen_res, this.system, this.ram, this.name, this.camera_main, this.image, this.cpu, this.memory, this.battery});

  @override
  _MobileListCartState createState() => _MobileListCartState();
}

class _MobileListCartState extends State<MobileListCart> {
  dynamic quantity=1;
  int choseValue;
  var price;
 Future putQuantity() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    String url = "https://jawali-api.herokuapp.com/api/cart/${widget.id}?qty=${quantity}";
    var response = await http.put(url,headers: {"Content-Type":"application/json",
      "Authorization": "Bearer ${token}",});
    var res = jsonDecode(response.body);
print(res);
    return res;
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      putQuantity();
     // Provider.of<Price>(context,listen: false).getCart();
    });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Details(
          qty:widget.qty,
          id: widget.id,
          price: widget.price,
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
          image : widget.image,
        );
      })),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              children: [
                Center(
                  child: Text(
                    widget.name,
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex:9,
                      child: Container(
                        child: Image.network(
                          '${widget.image}',
                          fit: BoxFit.contain,

                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 12,
                      child: Container(
                        height: MediaQuery.of(context).size.height/4,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "البطارية: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    widget.battery,
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "الذاكرة :",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        widget.memory,
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "السعر:${widget.price}",
                                          style: TextStyle(color: Colors.red),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("الكمية: "),
                                  DropdownButton(

                                    hint: Padding(
                                      padding: const EdgeInsets.only(top: 2,right: 5,bottom: 4),
                                      child: Text("${widget.qty}"),
                                    ),
                                      value: choseValue,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("1"),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("2"),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                            child: Text("3"),
                                            value: 3
                                        ),
                                        DropdownMenuItem(
                                            child: Text("4"),
                                            value: 4
                                        ),
                                        DropdownMenuItem(
                                            child: Text("5"),
                                            value: 5
                                        )
                                      ],
                                      onChanged: (value) {
                                        Widget hint =Text("${choseValue}");
                                        putQuantity();

                                        // Navigator.pushNamed(context, 'home');
                                        choseValue = value;
                                        setState(() {
                                          quantity=value;
                                          putQuantity();
                                       Provider.of<Price>(context,listen: false).getCart();
                                        });
                                      }),
                                ],
                              ),

                              Container(
                                color: Colors.white,
                                child: RichText(text: TextSpan(children: <TextSpan>[
                                  TextSpan(text:   "السعر  الكلي : ${ widget.totalPrice??""}""",style: TextStyle(
                                      color:Colors.red,
                                      fontSize: 20,
                                  ),),

                                ]
                                ),
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
