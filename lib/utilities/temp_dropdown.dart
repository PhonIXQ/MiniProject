import 'package:flutter/material.dart';

class TempDropdown extends StatelessWidget {
  final List<int> tempsLabel;
  final int temps;
  final Function(int) onChanged;

  const TempDropdown({
    @required this.tempsLabel,
    @required this.temps,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 30.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: temps,
          items: tempsLabel
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
