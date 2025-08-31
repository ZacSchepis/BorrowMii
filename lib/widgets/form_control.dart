import 'package:flutter/material.dart';

class FormControl extends StatefulWidget {
  final String label;
  final ValueChanged<String?> onChanged;
  const FormControl({super.key, required this.label, required this.onChanged});

  @override
  _FormControlState createState() =>
      _FormControlState(onChanged: onChanged, label: label);
}

class _FormControlState extends State<FormControl> {
  final ValueChanged<String?> onChanged;
  final String label;
  _FormControlState({required this.onChanged, required this.label});

  @override
  Widget build(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(label, textAlign: TextAlign.left),
        SizedBox(
          width: 250,
          child: TextField(
            textInputAction:  TextInputAction.go,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "$label"),
            onSubmitted: onChanged,
            
          ),
        )
      ],
    );
  }
}
