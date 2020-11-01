import 'package:Model/utilities/temp_dropdown.dart';
import 'package:flutter/material.dart';

class RangeTempHumi extends StatefulWidget {
  @override
  _RangeTempHumiState createState() => _RangeTempHumiState();
}

class _RangeTempHumiState extends State<RangeTempHumi> {
  int _lowerTemp = 29;
  int _overTemp = 35;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF398AE5),
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Range Temperature-Humity",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Image.asset('assets/images/range_temp.jpg'),
          ),
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
                      tempsLabel: [29, 30, 31, 32, 33, 34, 35, 36],
                      temps: _lowerTemp,
                      onChanged: (val) => setState(() => _lowerTemp = val),
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
                      tempsLabel: [29, 30, 31, 32, 33, 34, 35, 36],
                      temps: _overTemp,
                      onChanged: (val) => setState(() => _overTemp = val),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildSentResult(),
        ],
      ),
    );
  }

  Widget _buildSentResult() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: 100.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {},
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
}
