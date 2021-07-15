import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobil_shop/compount/MyDrawer.dart';
import 'package:mobil_shop/compount/mobilelist.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Xiaomi extends StatefulWidget {
  @override
  _XiaomigState createState() => _XiaomigState();
}

class _XiaomigState extends State<Xiaomi> {
  String country_Pref;


  Future getData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    String url = "https://jawali-api.herokuapp.com/api/products?brand=شاومي";
    var response = await http.get(url,headers: {"Content-Type":"application/json",
      "Authorization": "Bearer ${token}",});
    var res = jsonDecode(response.body);
    return res;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('شاومي'),
          ),
          drawer: MyDrawer(),
          body: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return  ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,i){
                    return Container(
                      child:MobileList(
                        id: snapshot.data[i]['_id'],
                        price: snapshot.data[i]['price'],
                        screen: snapshot.data[i]['description']['screen'],
                        screen_protect: snapshot.data[i]['description']['screenProtect'],
                        system: snapshot.data[i]['description']['system'],
                        screen_res: snapshot.data[i]['description']['screen_res'],
                        cpu: snapshot.data[i]['description']['cpu'],
                        camera_main: snapshot.data[i]['description']['cameraMain'],
                        battery: snapshot.data[i]['description']['battery'],
                        name: snapshot.data[i]['name'],
                        ram: snapshot.data[i]['description']['ram'],
                        memory: snapshot.data[i]['description']['memory'],
                        image : snapshot.data[i]['image'],
                      ),
                    );
                  },

                );


              } else {
                return Center(child: CircularProgressIndicator(backgroundColor: Colors.red,strokeWidth: 2,),);
              }
            },
          ),
        ));
  }
}
