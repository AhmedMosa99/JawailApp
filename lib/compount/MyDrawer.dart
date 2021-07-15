import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var username;
  var email;
  bool isSingnin = false;
  getPref() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.get("username");
    email = preferences.get("email");

    if (username != null) {
      setState(() {
        username = preferences.get("username");
        email = preferences.get("email");
        isSingnin = true;
      });
    }
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: isSingnin ? Text(username) : Text(""),
            accountEmail: isSingnin ? Text(email) : Text(""),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/bg.jpg'), fit: BoxFit.cover)),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'home');
            },
            title: Text(
              "الصفحة الرئيسية",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            leading: Icon(
              Icons.home,
              size: 25,
              color: Colors.blue,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'cat');
            },
            title: Text("الاقسام",
                style: TextStyle(fontSize: 18, color: Colors.black)),
            leading: Icon(Icons.category, size: 25, color: Colors.blue),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'orders');
            },
            title: Text(
              " طلبات",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            leading: Icon(
              Icons.home,
              size: 25,
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text("حول التطبيق",
                style: TextStyle(fontSize: 18, color: Colors.black)),
            leading: Icon(Icons.apps, size: 25, color: Colors.blue),
          ),
          ListTile(
            title: Text("الإعدادات",
                style: TextStyle(fontSize: 18, color: Colors.black)),
            leading: Icon(Icons.settings, size: 25, color: Colors.blue),
          ),
          isSingnin
              ? ListTile(
                  onTap: () async {
                    final SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.clear();

                    Navigator.of(context).pushNamed('login');
                  },
                  title: Text("تسجيل الخروج ",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  leading:
                      Icon(Icons.lock_outline, size: 25, color: Colors.blue),
                )
              : ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('login');
                  },
                  title: Text("تسجيل الدخول ",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  leading:
                      Icon(Icons.lock_outline, size: 25, color: Colors.blue),
                ),
        ],
      ),
    );
  }
}
