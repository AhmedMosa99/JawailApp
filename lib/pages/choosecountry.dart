import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseCountry extends StatefulWidget {
  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  savePref(String country) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Country", country);
    print(preferences.getString("Country"));
  }

  getPref() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var country = preferences.get("Country");
    if (country != null) {
      Navigator.of(context).pushNamed('login');
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("اختر البلد الموجود فيها"),
        ),
        body: ListView(
          children: [
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'images/palestine1.png',
                ),
              ),
              title: Text("فلسطين"),
              onTap: () {
                setState(() {
                  savePref("pl");
                  Navigator.pushNamed(context,'login');
                });

              },
            ),
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'images/eg-circle-01.png',
                ),
              ),
              title: Text("مصر"),
              onTap: () {
                savePref("eg");
              },
            ),
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'images/syria.png',
                ),
              ),
              title: Text("سوريا"),
              onTap: () {
                savePref("sy");
              },
            ),
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'images/green.png',
                ),
              ),
              title: Text("الجزائر"),
              onTap: () {
                savePref("alg");
              },
            ),
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'images/jorden.png',
                ),
              ),
              title: Text("الاردن"),
              onTap: () {
                savePref("jo");
              },
            ),
            ListTile(
              trailing: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'images/saudi.png',
                ),
              ),
              title: Text("السعودية "),
              onTap: () {
                savePref("sa");
              },
            ),
          ],
        ),
      ),
    );
  }
}
