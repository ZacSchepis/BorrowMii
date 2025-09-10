import 'package:flutter/material.dart';
import 'package:borrow_mii/core/validators/item_input_validator.dart';

class FormControl extends StatefulWidget {
  final String label;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?> onChanged;
  const FormControl(
      {super.key,
      required this.label,
      required this.onChanged,
      required this.validator});

  @override
  _FormControlState createState() => _FormControlState();
}

class _FormControlState extends State<FormControl> {
  _FormControlState();

  @override
  Widget build(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(label, textAlign: TextAlign.left),
        SizedBox(
          width: 250,
          child: TextFormField(
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: widget.label),
            validator: widget.validator,
            onChanged: widget.onChanged,
          ),
        )
      ],
    );
  }
}
