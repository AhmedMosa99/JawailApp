import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobil_shop/compount/MyDrawer.dart';
import 'package:mobil_shop/compount/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}
Future getData() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.get("token");
  String url = "https://jawali-api.herokuapp.com/api/orders";
  var response = await http.get(url,headers: {"Content-Type":"application/json",
    "Authorization": "Bearer ${token}",});
  var res = jsonDecode(response.body);
  return res;
}
class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:Text("الطلبات"),
        ),
        drawer: MyDrawer(),
        body: FutureBuilder(
          future:getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return  ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,i){
                   return Order(
                     id: snapshot.data[i]['_id'],
                     totalPrice:snapshot.data[i]['totalPrice'] ,
                     status: snapshot.data[i]['status'],
                   );
                  });

            } else {
              return Order(
                id: "asffafd",
                status:"ada",
                totalPrice: "10",

              );
                // Center(child: CircularProgressIndicator(),);
            }
          },
        ),


      ),
    );
  }
}
