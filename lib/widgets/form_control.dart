import 'package:flutter/material.dart';
import 'package:borrow_mii/core/validators/item_input_validator.dart';

class FormControl extends StatefulWidget {
  final String label;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  const FormControl(
      {super.key,
      required this.label,
      this.onChanged,
      this.validator,
      this.controller,
      this.keyboardType,
      this.initialValue = ""
      });

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
            initialValue: widget.initialValue,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: widget.label),
            validator: widget.validator,
            onChanged: widget.onChanged,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
          ),
        )
      ],
    );
  }
}
