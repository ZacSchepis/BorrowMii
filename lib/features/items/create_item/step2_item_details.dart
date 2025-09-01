import 'package:flutter/material.dart';
import 'package:team_d_project/core/validators/item_input_validator.dart';
import 'package:team_d_project/data/models/item_model.dart';
import 'package:team_d_project/widgets/button.dart';
import 'package:team_d_project/widgets/form_control.dart';

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
            onChanged: (value) => widget.item.itemName = value!,
            validator: _validator.itemName,
          ),
          // Text(widget.item.itemName),
          FormControl(
              label: "Item description",
              onChanged: (value) => widget.item.itemDesc = value!,
              validator: _validator.itemDesc),
          // Text(widget.item.itemDesc),
          FormControl(
              label: "Serial number",
              validator: (String? val) => null,
              onChanged: (value) => widget.item.itemSerial = value!),
          // Text(widget.item.itemSerial),
          FormControl(
            label: "Item link",
            onChanged: (value) => widget.item.itemLink = value!,
            validator: _validator.itemLink,
          ),
          // Text(widget.item.itemLink),
          FormControl(
            label: "Retail value",
            onChanged: (value) =>
                widget.item.itemValue = int.tryParse(value!) ?? 0,
            validator: (v) => null,
          ),
          // Text(widget.item.itemRetail.toString()),
          FormControl(
            label: "Current value",
            onChanged: (value) =>
                widget.item.itemValue = int.tryParse(value!) ?? 0,
            validator: (v) => null,
          ),
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
                value: widget.item.itemCondition,
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
          )
        ],
      ),
    ));
  }
}
