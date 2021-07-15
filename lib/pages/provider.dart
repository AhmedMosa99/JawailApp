import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Price with ChangeNotifier{
  var listPrice;
  Future getCart() async {
    listPrice=[];
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    String url = "https://jawali-api.herokuapp.com/api/cart";
    var response = await http.get(url,headers: {"Content-Type":"application/json",
      "Authorization": "Bearer ${token}",});
    var res = jsonDecode(response.body);
    for (int i = 0; i < res.length; i++) {
        listPrice.add(res[i]['price']);
    }
     return res;
  }
  Future getDetails(var id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    String url = "https://jawali-api.herokuapp.com/api/orders/${id}";
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
    var response = await http.post(url,headers: {"Content-Type":"application/json",
      "Authorization": "Bearer ${token}",});
    var res = jsonDecode(response.body);
    notifyListeners();
    return res;

  } catch (e) {
    print(e);
  }
}
}