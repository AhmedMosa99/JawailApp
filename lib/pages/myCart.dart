import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobil_shop/compount/MyDrawer.dart';
import 'package:mobil_shop/compount/mobilelistCart.dart';
import 'package:mobil_shop/pages/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();

}

class _CartState extends State<Cart> {
  var price=[];

 Future getCart() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    String url = "https://jawali-api.herokuapp.com/api/cart";
    var response = await http.get(url,headers: {"Content-Type":"application/json",
      "Authorization": "Bearer ${token}",});
    var res = jsonDecode(response.body);
    return res;
  }



 Future postProduct()async {
   try {
     final SharedPreferences preferences = await SharedPreferences.getInstance();
     String token = preferences.get("token");
     var url = "https://jawali-api.herokuapp.com/api/orders";
     var response = await http.get(url,headers: {"Content-Type":"application/json",
       "Authorization": "Bearer ${token}",});
     var res = jsonDecode(response.body);
     print(res);
     return res;
   } catch (e) {
     print(e);
   }
 }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Provider.of<Price>(context,listen: false).getCart();
    });

  }
  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:Text("سلتي"),
        ),
        drawer: MyDrawer(),
        body: FutureBuilder(
          future: Provider.of<Price>(context,listen: false).getCart(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return  ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,i){
                    return Dismissible(
                      key: UniqueKey(),
                        onDismissed: (direction)async{
                              final SharedPreferences preferences = await SharedPreferences.getInstance();
                              String token = preferences.get("token");
                              String url = "https://jawali-api.herokuapp.com/api/cart/${snapshot.data[i]['_id']}";
                              var response = await http.delete(url,headers: {"Content-Type":"application/json",
                                "Authorization": "Bearer ${token}",});
                        },
                        direction: DismissDirection.endToStart,

                        background: IconButton(
                          onPressed: (){},
                          alignment: Alignment.centerLeft,
                          icon: Icon(Icons.delete,size: 50, color: Colors.red,),
                          color: Colors.red,

                        ),
                        child:
                         MobileListCart(
                           qty: snapshot.data[i]['qty'],
                           totalPrice: snapshot.data[i]['price'],
                           id: snapshot.data[i]['_id'],
                           price: snapshot.data[i]['product']['price'],
                           screen: snapshot.data[i]['product']['description']['screen'],
                          screen_protect: snapshot.data[i]['product']['description']['screenProtect'],
                           system: snapshot.data[i]['product']['description']['system'],
                           screen_res: snapshot.data[i]['product']['description']['screenRes'],
                           cpu: snapshot.data[i]['product']['description']['cpu'],
                           camera_main: snapshot.data[i]['product']['description']['cameraMain'],
                           battery: snapshot.data[i]['product']['description']['battery'],
                           name: snapshot.data[i]['product']['name'],
                           ram: snapshot.data[i]['product']['description']['ram'],
                           memory: snapshot.data[i]['product']['description']['memory'],
                           image : snapshot.data[i]['product']['image'],
                         ),
                    );
                  });

            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            margin: const EdgeInsets.only(right: 20),


            child: FloatingActionButton(
                child: Container(
                    child: Text("شراء",style: TextStyle(color: Colors.red),)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                onPressed: () {
                getCart();
                 // print( Provider.of<Price>(context,listen: false).listPrice);
                 Navigator.pushNamed(context, 'address');
       Provider.of<Price>(context,listen: false).postProduct();
                }),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Text("شراء"),onPressed: (){},),

    ),
    );
  }
}
