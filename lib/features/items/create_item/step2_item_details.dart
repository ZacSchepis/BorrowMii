import 'package:flutter/material.dart';
import 'package:borrow_mii/core/validators/item_input_validator.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/widgets/button.dart';
import 'package:borrow_mii/widgets/form_control.dart';

class Step2ItemDetails extends StatefulWidget {
  final VoidCallback onNext;
  ItemModel item;
  final ValueChanged<bool> onChanged;
  final ValueChanged<String?> onConditionSet;
  final bool fees;
  Step2ItemDetails(
      {super.key,
      required this.onNext,
      required this.item,
      required this.onChanged,
      required this.onConditionSet,
      required this.fees});

  @override
  State<Step2ItemDetails> createState() => _Step2ItemDetailsWidgetState();
}

class _Step2ItemDetailsWidgetState extends State<Step2ItemDetails> {
  final _formKey = GlobalKey<FormState>();
  final ItemInputValidator _validator = ItemInputValidator();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("<Select one>"), value: ""),
      DropdownMenuItem(child: Text("New"), value: "new"),
      DropdownMenuItem(child: Text("Used"), value: "used"),
      DropdownMenuItem(child: Text("Used - like new"), value: "like-new"),
      DropdownMenuItem(child: Text("Bad"), value: "bad"),
    ];
    return menuItems;
  }

  ItemInputValidator _validate = ItemInputValidator();
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Form(
      key: _formKey,

      // appBar: Text("Set Item Info"),

      child: Column(
        spacing: 5,
        children: [
          FormControl(
            label: "Item name",
            onChanged: (value) => widget.item.name = value!,
            validator: _validator.itemName,
          ),
          // Text(widget.item.itemName),
          FormControl(
              label: "Item description",
              onChanged: (value) => widget.item.description = value!,
              validator: _validator.itemDesc),
          FormControl(
            label: "Current value",
            onChanged: (value) =>
                widget.item.value = int.tryParse(value!) ?? 0,
            validator: (v) => null,
          ),
          FormControl(
            label: "Retail value",
            onChanged: (value) =>
                widget.item.value = int.tryParse(value!) ?? 0,
            validator: (v) => null,
          ),
          FormControl(
            label: "Item link",
            onChanged: (value) => widget.item.link = value!,
            validator: _validator.itemLink,
          ),
          // Text(widget.item.itemDesc),
          FormControl(
              label: "Serial number",
              validator: (String? val) => null,
              onChanged: (value) => widget.item.serial = value!),
          // Text(widget.item.itemSerial),

          // Text(widget.item.itemLink),

          // Text(widget.item.itemRetail.toString()),

          // Text(widget.item.itemValue.toString()),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("No Fees"),
              Switch(value: widget.fees, onChanged: widget.onChanged),
              const Text("Fees")
            ],
          ),
          Row(
                      mainAxisSize: MainAxisSize.min,

            children: [
              Text("Item condition: "),
              DropdownButton(
                items: dropdownItems,
                value: widget.item.condition,
                onChanged: widget.onConditionSet,
              ),
            ],
          ),
          Spacer(),
          Align(
            child: ElevatedButton(
              onPressed: () => {
                    if (_formKey.currentState!.validate()) {widget.onNext()}
                  },
              child: const Text("Submit")),
              alignment: Alignment.bottomRight,

          )
        ],
      ),
    ));
  }
}
