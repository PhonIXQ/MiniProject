import 'package:flutter/material.dart';

class TempDropdown extends StatelessWidget {
  final List<String> countries;
  final String temp;
  final Function(String) onChanged;

  const TempDropdown({
    @required this.countries,
    @required this.temp,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: temp,
          items: countries
              .map((e) => DropdownMenuItem(
                    child: Row(
                      children: <Widget>[
                        // CircleAvatar(
                        //   radius: 12.0,
                        //   child: Image.asset(
                        //     'assets/images/${e.toLowerCase()}_flag.png',
                        //   ),
                        // ),
                        // const SizedBox(width: 8.0),
                        Text(
                          e,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    value: e,
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
