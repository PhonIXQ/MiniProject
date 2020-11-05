import 'package:flutter/material.dart';

class TempDropdown extends StatelessWidget {
  final List<double> tempLabel;
  final double temps;
  final Function(double) onChanged;

  const TempDropdown({
    @required this.tempLabel,
    @required this.temps,
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
        child: DropdownButton<double>(
          value: temps,
          items: tempLabel
              .map((e) => DropdownMenuItem(
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 8.0),
                        Text(
                          '$e',
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
