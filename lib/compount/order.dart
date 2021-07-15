import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobil_shop/compount/orderDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Order extends StatefulWidget {
  final totalPrice;
  final status;
  final id;



Order({this.totalPrice, this.status, this.id});


  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
      return InkWell(

        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return OrderDetails(
              id: widget.id,
            );
          }));
        }
          ,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/4.5,
            child: Column(
              children: [
                Center(
                  child: Text(
                   "${widget.id}",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text("الحالة",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18, fontWeight: FontWeight.w700),),
                        trailing: Text(widget.status,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18, fontWeight: FontWeight.w700),),

                      ),ListTile(
                        leading: Text("السعر الكلي",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18, fontWeight: FontWeight.w700),),
                        trailing: Text("${widget.totalPrice}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18, fontWeight: FontWeight.w700),),

                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      );

  }
}
