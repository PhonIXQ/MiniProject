import 'dart:convert';
import 'package:Model/screens/range_temp_humi.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // CustomAppBar(),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Weather",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            _buildContainer(),
            Container(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 10, top: 10),
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  _buildWeather("assets/images/icon_temp.png", "Temp", "$temp"),
                  _buildWeather(
                      "assets/images/icon_humi.png", "Humi", "$humidity"),
                  _buildWeather(
                      "assets/images/icon_light.png", "Light", "$light"),
                  _buildOtherBtn(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      // leading: FaIcon(FontAwesomeIcons.windowClose),
                      title: Text(
                        "PM 1",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        pm1 != null ? pm1.toString() : "..",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      // leading: FaIcon(FontAwesomeIcons.windowClose),
                      title: Text(
                        "PM 2.5",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        pm25 != null ? pm25.toString() : "..",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      // leading: FaIcon(FontAwesomeIcons.windowClose),
                      title: Text(
                        "PM 10",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        pm10 != null ? pm10.toString() : "..",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
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
            temp != null ? temp.toString() + "\u00B0" : "...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              currently != null ? currently.toString() : "",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWeather(String iconWeath, String resultName, String resultNum) {
    return Column(
      children: <Widget>[
        Container(
          width: 70,
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
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Text(
                "$resultName",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Image.asset(iconWeath, width: 33.0),
              SizedBox(height: 8),
              Text(
                "$resultNum",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          margin: EdgeInsets.only(right: 20),
        ),
        SizedBox(height: 7),
      ],
    );
  }

  Widget _buildOtherBtn() {
    return Container(
      alignment: Alignment.center,
      width: 40.0,
      padding: EdgeInsets.only(bottom: 10),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RangeTempHumi(),
            ),
          );
        },
        // padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          '>>',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
