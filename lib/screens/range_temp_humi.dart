import 'package:Model/screens/login_screen.dart';
import 'package:Model/utilities/temp_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RangeTempHumi extends StatefulWidget {
  @override
  _RangeTempHumiState createState() => _RangeTempHumiState();
}

class _RangeTempHumiState extends State<RangeTempHumi> {
  double _tempOver;
  double _tempLower;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF398AE5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Range Temperature-Humity",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Image.asset('assets/images/range_temp.jpg'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 40,
              right: 40,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Lower Temp',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Over Temp',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TempDropdown(
                      tempLabel: [21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
                      temps: _tempLower,
                      onChanged: (value) => setState(() => _tempLower = value),
                    ),
                    Text(
                      "<",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TempDropdown(
                      tempLabel: [29, 30, 31, 32, 33, 34, 35, 36, 37, 38],
                      temps: _tempOver,
                      onChanged: (value) => setState(() => _tempOver = value),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildSendResult(),
        ],
      ),
    );
  }

  Widget _buildSendResult() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: 100.0,
      height: 70,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          sendResult();
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Push',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future sendResult() async {
    await http.post(
        "https://api.thingspeak.com/update?api_key=NEJEEQQGJKEUSOC3&field7=$_tempLower" +
            "&field8=$_tempOver");
    print('Push results');
  }
}
