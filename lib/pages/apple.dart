import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobil_shop/compount/MyDrawer.dart';
import 'package:mobil_shop/compount/mobilelist.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Apple extends StatefulWidget {
  @override
  _AppleState createState() => _AppleState();
}

class _AppleState extends State<Apple> {
  String country_Pref;
  getPref() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      country_Pref = preferences.get("Country");
    });
  }

  Future getData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    String url = "https://jawali-api.herokuapp.com/api/products?brand=أبل";
    var response = await http.get(url,headers: {"Content-Type":"application/json",
      "Authorization": "Bearer ${token}",});
    var res = jsonDecode(response.body);
    return res;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ابل'),
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
                            screen_res: snapshot.data[i]['description']['screenRes'],
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
                    // return MobileList(
                    //   country: country_Pref,
                    //   name: snapshot.data[i]['name'],
                    //   battery: snapshot.data[i]['price_sy'],
                    //   cpu: snapshot.data[i]['name'],
                    //   memory: snapshot.data[i]['memory'],
                    //   camera: snapshot.data[i]['camera_main'],
                    //   price_eg: snapshot.data[i]['price_eg'],
                    //   price_alg: snapshot.data[i]['price_alg'],
                    //   price_jo: snapshot.data[i]['price_jo'],
                    //   price_sa: snapshot.data[i]['price_sa'],
                    //   price_sy: snapshot.data[i]['price_sy'],
                    //   price_pl: snapshot.data[i]['price_pl'],
                    // );


              } else {
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ));
  }
}

