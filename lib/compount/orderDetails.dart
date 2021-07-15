import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobil_shop/compount/MyDrawer.dart';
import 'package:mobil_shop/compount/mobilelist.dart';
import 'package:mobil_shop/compount/mobilelistCart.dart';
import 'package:mobil_shop/compount/order.dart';
import 'package:mobil_shop/pages/provider.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  final id;
  final qty;
  final country;
  final address;
  final postalCode;
  final city;
  final shippingPrice;
  final name;
  final image;
  final price;
  final  battery;
  final memory;
  final countInStock;
List data;


OrderDetails({this.qty,this.data,this.id, this.country, this.address, this.postalCode, this.city, this.shippingPrice, this.name, this.image, this.price, this.battery, this.memory, this.countInStock});
  @override


  _OrderDetailsState createState() => _OrderDetailsState();

}



class _OrderDetailsState extends State<OrderDetails> {
  var data;
  @override
 void initState(){

    // TODO: implement initState
    super.initState();
    setState(() {
      data= Provider.of<Price>(context,listen: false).getDetails(widget.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("الطلب"),
        ),
        drawer: MyDrawer(),
        body:

              FutureBuilder(
                  future: data,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                           children: <Widget>[
                            Column(
                               children: [
                                 Container(
                                   decoration: BoxDecoration(
                                     color: Colors.blue.shade50,
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   width: MediaQuery.of(context).size.width,
                                   height: MediaQuery.of(context).size.height/3.5,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.all(3.0),
                                         child: Padding(
                                           padding: const EdgeInsets.only(right:5.0),
                                           child: Text("عنوان الشحن",
                                             style: TextStyle(
                                                 color: Colors.deepOrangeAccent,
                                                 fontSize: 18, fontWeight: FontWeight.w700),
                                           ),
                                         ),
                                       ),
                                       Card(
                                           child: Column(
                                             children: [
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Row(
                                                   children: [
                                                     Text("الدولة : ",
                                                       style: TextStyle(
                                                           color: Colors.black,
                                                           fontSize: 18, fontWeight: FontWeight.w700),),
                                                     Text("${snapshot.data['shippingAddress']['country']}",
                                                       style: TextStyle(
                                                           color: Colors.red,
                                                           fontSize: 18, fontWeight: FontWeight.w700),),
                                                   ],
                                                 ),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Row(
                                                   children: [
                                                     Text("المدينة : ",
                                                       style: TextStyle(
                                                           color: Colors.black,
                                                           fontSize: 18, fontWeight: FontWeight.w700),),
                                                     Text("${snapshot.data['shippingAddress']['city']}",
                                                       style: TextStyle(
                                                           color: Colors.red,
                                                           fontSize: 18, fontWeight: FontWeight.w700),),
                                                   ],
                                                 ),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Row(
                                                   children: [
                                                     Text("العنوان : ",
                                                       style: TextStyle(
                                                           color: Colors.black,
                                                           fontSize: 18, fontWeight: FontWeight.w700),),
                                                     Text("${snapshot.data['shippingAddress']['address']}",
                                                       style: TextStyle(
                                                           color: Colors.red,
                                                           fontSize: 18, fontWeight: FontWeight.w700),),
                                                   ],
                                                 ),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Row(
                                                   children: [
                                                     Text("رمز بريدي: ",
                                                       style: TextStyle(
                                                           color: Colors.black,
                                                           fontSize: 18, fontWeight: FontWeight.w700),),
                                                     Text("${snapshot.data['shippingAddress']['postalCode']}",
                                                       style: TextStyle(
                                                           color: Colors.red,
                                                           fontSize: 18, fontWeight: FontWeight.w700),),
                                                   ],
                                                 ),
                                               ),
                                             ],
                                           )
                                       ),
                                       SizedBox(
                                         height: 5,
                                       ),

                                     ],
                                   ),
                                 ),
                                 SizedBox(height: 10,),
                                 Order(
                                   id: snapshot.data['_id'],
                                   totalPrice: snapshot.data['totalPrice'],
                                   status:  snapshot.data['status'],
                                 ),
                                 SingleChildScrollView(
                                   child: Container(
                                     decoration: BoxDecoration(
                                       color: Colors.blue.shade50,
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.all(3.0),
                                           child: Padding(
                                             padding: const EdgeInsets.only(right: 7),
                                             child: Text("المنتجات",style: TextStyle(color: Colors.deepOrange,fontSize: 18,fontWeight: FontWeight.w700),),
                                           ),
                                         ),
                                         ListView.builder(
                                           scrollDirection: Axis.vertical,
                                           shrinkWrap: true,
                                           itemCount: snapshot.data['products'].length,
                                           itemBuilder: (context,i){
                                             return Container(
                                               width: MediaQuery.of(context).size.width,
                                               child:MobileList(
                                                 qty: snapshot.data['products'][i]['qty'],
                                                 id: snapshot.data['products'][i]['_id']??"",
                                                 price: snapshot.data['products'][i]['price']??"",
                                                 screen: snapshot.data['products'][i]['product']['description']['screen']??"",
                                                 screen_protect: snapshot.data['products'][i]['product']['description']['screenProtect']??"",
                                                 system: snapshot.data['products'][i]['product']['description']['system']??"",
                                                 screen_res: snapshot.data['products'][i]['product']['description']['screenRes']??"",
                                                 cpu: snapshot.data['products'][i]['product']['description']['cpu']??"",
                                                 camera_main: snapshot.data['products'][i]['product']['description']['cameraMain']??"",
                                                 battery: snapshot.data['products'][i]['product']['description']['battery']??"",
                                                 name: snapshot.data['products'][i]['product']['name']??"",
                                                 ram: snapshot.data['products'][i]['product']['description']['ram']??"",
                                                 memory: snapshot.data['products'][i]['product']['description']['memory']??"",
                                                 image : snapshot.data['products'][i]['product']['image']??"",
                                               ),
                                             );
                                           },

                                         ),
                                       ],
                                     ),
                                   ),
                                 ),


                               ],
                             ),
                           ],
                          ),
                        ),
                      );
                    }
                    else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
              ),



        ),

    );
  }
}

