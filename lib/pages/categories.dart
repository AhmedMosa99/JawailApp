import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobil_shop/compount/MyDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categories extends StatefulWidget {
  String token="";
  @override
  _CategoriesState createState() => _CategoriesState();

}

Future getProduct() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.get("token");
  String url = "https://jawali-api.herokuapp.com/api/brands";
  var response = await http.get(url,headers: {"Content-Type":"application/json",
  "Authorization": "Bearer ${token}",
  });
  var res = jsonDecode(response.body);
  return res;
}


class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("الاقسام"),
        ),
        drawer: MyDrawer(),
        body:Grid(),
      ),
    );
  }

}
class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future:  getProduct(),
      builder:  (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData){
          return   GridView(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              InkWell(
                onTap: () {
                   Navigator.pushNamed(context, 'Apple');
                },
                //card
                child: Container(
                  child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              "${ snapshot.data[0]['image']}",
                            ),
                          ),
                          Container(
                            child: Text(
                              snapshot.data[0]['name'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'xiaomi');
                },
                //card
                child: Container(
                  child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              "${snapshot.data[1]['image']}",
                            ),
                          ),
                          Container(
                            child: Text(
                              snapshot.data[1]['name'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'huawei');
                },
                //card
                child: Container(
                  child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              "${snapshot.data[2]['image']}",
                            ),
                          ),
                          Container(
                            child: Text(
                              snapshot.data[2]['name'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'samsung');
                },
                //card
                child: Container(
                  child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              "${snapshot.data[3]['image']}",
                            ),
                          ),
                          Container(
                            child: Text(
                              snapshot.data[3]['name'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
              ),


            ],
          );
        }
        else if(!snapshot.hasData){
          return Container(

            child: Center(
              child: CircularProgressIndicator(
              ),
            ),
          );
        }
        else{
           return Center(child:CircularProgressIndicator());

        }


    }

    );
  }
}

