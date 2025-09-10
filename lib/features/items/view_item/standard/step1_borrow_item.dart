import 'package:borrow_mii/widgets/button.dart';
import 'package:borrow_mii/widgets/form_control.dart';
import 'package:borrow_mii/widgets/skeletons/item.dart';
import 'package:flutter/material.dart';

class Step1BorrowItem extends StatefulWidget {
  final VoidCallback next;
  const Step1BorrowItem({super.key, required this.next});

  @override
  State<Step1BorrowItem> createState() => _Step1BorrowItemWidgetState();
}

class _Step1BorrowItemWidgetState extends State<Step1BorrowItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(child: 
      Column(
      spacing: 5,
      children: [
        FormControl(
            label: "Date borrowed",
            onChanged: (value) => {},
            validator: (val) => null
            ),
        FormControl(
            label: "Promise to return by",
            onChanged: (value) => {},
            validator: (val) => null
            ),
            Spacer(),
            Align(
              child: Button(onPressed: widget.next, text: "Submit"),
              alignment: Alignment.bottomRight,
              
            )
      ],
    )),
    );
  }
}
