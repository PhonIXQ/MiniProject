import 'package:Model/utilities/constants.dart';
import 'package:Model/utilities/temp_dropdown.dart';
import 'package:flutter/material.dart';

class RangeTempHumi extends StatefulWidget {
  @override
  _RangeTempHumiState createState() => _RangeTempHumiState();
}

class _RangeTempHumiState extends State<RangeTempHumi> {
  String temp = '30';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF398AE5),
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Image.asset('assets/images/range_temp_humi.jpg'),
          ),
          // Row(
          //   children: [
          //     _buildResultTemp("Lower Temp"),
          //     _buildResultTemp("Over Temp"),
          //   ],
          // ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Lower Temp',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TempDropdown(
                countries: ['CN', 'FR', 'IN', 'IT', 'UK', 'USA'],
                temp: temp,
                onChanged: (val) => setState(() => temp = val),
              ),
              TempDropdown(
                countries: ['CN', 'FR', 'IN', 'IT', 'UK', 'USA'],
                temp: temp,
                onChanged: (val) => setState(() => temp = val),
              ),
              Text(
                'Lower Temp',
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
    );
  }

  Widget _buildResultTemp(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "$title",
          style: kLabelStyle,
        ),
        SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
