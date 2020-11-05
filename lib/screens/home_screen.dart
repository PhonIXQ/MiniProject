import 'dart:convert';
import 'package:Model/screens/range_temp_humi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var temp;
  var description;
  var currently;
  var humidity;
  var pm1;
  var pm25;
  var pm10;
  var light;

  Future getWeather() async {
    http.Response response = await http.get(
        "https://api.thingspeak.com/channels/1150911/feeds.json?results=1");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['feeds'][0]['field1'];
      this.humidity = results['feeds'][0]['field2'];
      this.pm1 = results['feeds'][0]['field3'];
      this.pm25 = results['feeds'][0]['field4'];
      this.pm10 = results['feeds'][0]['field5'];
      this.light = results['feeds'][0]['field6'];
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
      backgroundColor: Color(0xFF398AE5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.home,
            size: 30,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RangeTempHumi(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                "RPC Weather",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            _buildContainer(),
            Container(
              height: MediaQuery.of(context).size.width / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildWeather("assets/images/icon_temp.png", "Temp", "$temp"),
                  _buildWeather(
                      "assets/images/icon_humi.png", "Humi", "$humidity"),
                  _buildWeather(
                      "assets/images/icon_light.png", "Light", "$light"),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Dust PM in RPC",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                children: <Widget>[
                  _buildDustPM("PM 1", "$pm1"),
                  _buildDustPM("PM 2.5", "$pm25"),
                  _buildDustPM("PM 10", "$pm10"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 4.7,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              temp != null ? temp.toString() + "\u00B0" : "...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWeather(String iconWeath, String title, String result) {
    return Row(
      children: <Widget>[
        Container(
          width: 80,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "$title",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(iconWeath, width: 38.0),
              Text(
                "$result",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDustPM(String title, String result) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 1),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                // leading: FaIcon(FontAwesomeIcons.windowClose),
                title: Text(
                  "$title",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  '$result' != null ? '$result'.toString() : "..",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
