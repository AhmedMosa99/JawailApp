
import 'package:flutter/material.dart';
import 'package:mobil_shop/compount/details.dart';
import 'package:mobil_shop/pages/address.dart';
import 'package:mobil_shop/pages/apple.dart';
import 'package:mobil_shop/pages/huawei.dart';
import 'package:mobil_shop/pages/login.dart';
import 'package:mobil_shop/pages/categories.dart';
import 'package:mobil_shop/pages/myCart.dart';
import 'package:mobil_shop/pages/orders.dart';
import 'package:mobil_shop/pages/provider.dart';
import 'package:mobil_shop/pages/samsung.dart';
import 'package:mobil_shop/pages/xiaomi.dart';
import 'package:provider/provider.dart';
import 'compount/orderDetails.dart';
import 'pages/home.dart';



void main() {


  runApp(
      ChangeNotifierProvider(
        create:(_)=>Price() ,
        child:  MobileShop(),
      ),

  );

}

class MobileShop extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
          textDirection: TextDirection.rtl, child: Login()),
      theme: ThemeData(fontFamily: 'Cairo'),
      routes: {
        'home': (context) => Home(),
        'cat': (context) => Categories(),
        'samsung': (context) => Samsung(),
        'Apple': (context) => Apple(),
        'details': (context) => Details(),
        'login': (context) => Login(),
        'myCart':(context)=>Cart(),
        'orders':(context)=>Orders(),
        'address':(context)=>Address(),
        'detailsOrder':(context)=> OrderDetails(),
        'xiaomi':(context)=> Xiaomi(),
        'huawei':(context)=> Huawei(),
      },
    );
  }
}
