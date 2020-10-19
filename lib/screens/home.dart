import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Widget showAppName() {
  return Container(
    child: Text(
      'RPC Weather',
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Baloo',
      ),
    ),
  );
}

BoxDecoration showBefore() {
  return BoxDecoration(
    border: Border.all(
      color: Colors.blue,
      width: 5.0,
    ),
  );
}

Widget showToday() {
  return Container(
    child: Text('Today'),
  );
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var pm1;
  var pm25;
  var pm10;

  Future getWeather() async {
    http.Response response = await http.get(
        "https://api.thingspeak.com/channels/1150911/feeds.json?results=2");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['feeds'][1]['field1'];
      this.humidity = results['feeds'][1]['field2'];
      this.pm1 = results['feeds'][1]['field3'];
      this.pm25 = results['feeds'][1]['field4'];
      this.pm10 = results['feeds'][1]['field5'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Weather',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in RPC",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(
                        temp != null ? temp.toString() + "\u00B0" : "Loading"),
                  ),
                  // ListTile(
                  //   leading: FaIcon(FontAwesomeIcons.cloud),
                  //   title: Text("Weather"),
                  //   trailing: Text(description != null
                  //       ? description.toString()
                  //       : "Loading"),
                  // ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.windowClose),
                    title: Text("PM 1"),
                    trailing: Text(pm1 != null ? pm1.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.windowClose),
                    title: Text("PM 2.5"),
                    trailing: Text(pm25 != null ? pm25.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.windowClose),
                    title: Text("PM 10"),
                    trailing: Text(pm10 != null ? pm10.toString() : "Loading"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Weather',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          child: TabBar(
            tabs: [
              Text('Now'),
              Text('Pass'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}
