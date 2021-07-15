import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:mobil_shop/compount/MyDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:mobil_shop/compount/mobilelist.dart';
import 'package:mobil_shop/pages/categories.dart';
import 'package:mobil_shop/pages/myCart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  static var country;
  var listSearch = [];
  int currentIndex=0;
  bool ScreenHome=true;
  CheckScreen(){
    if(currentIndex==0){
      return true;
    }else{
      return false;
    }

  }
  List <Widget>screen=[
    InternalHome(),
    Cart(),
    Categories(),

  ];
  Future getData() async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.get("token");
      var url = "https://jawali-api.herokuapp.com/api/products";
      var response = await http.get(url,headers: {"Content-Type":"application/json",
        "Authorization": "Bearer ${token}",});
      var res = jsonDecode(response.body);
      for (int i = 0; i < res.length; i++) {
        listSearch.add(res[i]['name']);

      }
    } catch (e) {
      print(e);
    }
  }
  static Future Lastdata() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("token");
    String url = "https://jawali-api.herokuapp.com/api/products";
    var response = await http.get(url,headers: {"Content-Type":"application/json",
      "Authorization": "Bearer ${token}",});
    var res = jsonDecode(response.body);
    return res;
  }

  getPref() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    country = preferences.get("Country");

  }
  @override
  void initState() {
    getData();
    setState(() {
      getPref();
      getData();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(

      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:CheckScreen()? AppBar(
          title: Text('الرئيسية'),
          centerTitle: true,
          actions: [
            Center(
              child: Stack(children: [

        IconButton(
        icon: Icon(Icons.shopping_cart_rounded),
          onPressed: () {
          setState(() {
             Navigator.pushNamed(context, "myCart");
          });
          }
      ),

              ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch(list: listSearch));
              },
            ),

          ],
        ):null,
        drawer: MyDrawer(),
        body:screen[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index){
            setState(() {
              currentIndex=index;
            });
          },
          items: [
            BottomNavigationBarItem(
                label: "الرئيسية",
                icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "السلة",
                icon: Icon(Icons.shopping_cart_sharp)),
            BottomNavigationBarItem(
                label: "الاقسام",
                icon: Icon(Icons.category)),
          ],
        ),
      ),
    );
  }
}

class InternalHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: [
        SizedBox(
          height: 260,
          width: MediaQuery.of(context).size.width,
          child: Carousel(
            images: [
              Image.asset(
                'images/mobiles2.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/mobiles1.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/mobiles3.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/mobiles.jpg',
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "الاقسام",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
        ),
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 100,
                height: 100,
                child: ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, 'Apple');
                  },
                  title: Image.asset(
                    'images/logo-apple.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "apple",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                width: 120,
                height: 120,
                child: ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, 'samsung');
                  },
                  title: Image.asset(
                    'images/logo-samsung.jpg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Samsung",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                child: ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, 'huawei');
                  },
                  title: Image.asset(
                    'images/logo-huawei.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "huawei",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                child: ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, 'xiaomi');
                  },
                  title: Image.asset(
                    'images/redmi-logo.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "redmi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "اخر المنتجات",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
        ),
        Container(
          height: 420,
          child: FutureBuilder(
            future:  _HomeState.Lastdata(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        children: [

          InkWell(
            onTap: () {},
            child: GridTile(
              child: Image.network(
                snapshot.data[0]['image'],
                fit: BoxFit.contain,
              ),
              footer: Container(
                height: 30,
                color: Colors.black.withOpacity(.5),
                child: Center(
                  child: Text(
                    "${snapshot.data[0]['name']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: GridTile(
              child:Image.network(
                snapshot.data[1]['image'],
                fit: BoxFit.contain,
              ),
              footer: Container(
                height: 30,
                color: Colors.black.withOpacity(.5),
                child: Center(
                  child: Text(
                "${snapshot.data[1]['name']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: GridTile(
              child:Image.network(
                snapshot.data[2]['image'],
                fit: BoxFit.contain,
              ),
              footer: Container(
                height: 30,
                color: Colors.black.withOpacity(.5),
                child: Center(
                  child: Text(
                "${snapshot.data[2]['name']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: GridTile(
              child: Image.network(
        snapshot.data[3]['image'],
        fit: BoxFit.contain,
        ),
              footer: Container(
                width: 45,
                height: 30,
                color: Colors.black.withOpacity(.5),
                child: Center(
                  child: Text(
        "${snapshot.data[3]['name']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    else{
  return  Center(child: CircularProgressIndicator());
    }
    }

          ),
        ),
      ],
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  var country = _HomeState.country;
  List <dynamic>list = [];
  DataSearch({this.list});
  Future getSearchData()async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.get("token");
      var url = "https://jawali-api.herokuapp.com/api/products?q=${query}";
      var response = await http.get(url,headers: {"Content-Type":"application/json",
        "Authorization": "Bearer ${token}",});
      var res = jsonDecode(response.body);
      return res;
    } catch (e) {
      print(e);
    }
  }



  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: getSearchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
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
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
List empty=[];
var searchlist  = query.isEmpty ?empty : list.where((element) => element.contains(query)).toList();

    return ListView.builder(
        itemCount: searchlist.length,
        itemBuilder: (context, i) {
          return ListTile(
            onTap: () {
              query =searchlist[i];
              showResults(context);

            },
            leading: Icon(Icons.mobile_screen_share),
            title: InkWell(
              onTap: (){
                query =searchlist[i];
       showResults(context);
              },
              child: Text(
               " ${searchlist[i]}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        });
  }
}
