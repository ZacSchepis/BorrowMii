import 'package:flutter/material.dart';
import 'package:team_d_project/data/models/item_model.dart';
import 'package:team_d_project/widgets/button.dart';
import 'package:team_d_project/widgets/form_control.dart';


class Step2ItemDetails extends StatefulWidget {
  final VoidCallback onNext;
  ItemModel item;
  final ValueChanged<bool> onChanged;
  final ValueChanged<String?> onConditionSet;
  Step2ItemDetails(
      {super.key,
      required this.onNext,
      required this.item,
      required this.onChanged,
      required this.onConditionSet});
  
  @override
  State<Step2ItemDetails> createState() => _Step2ItemDetailsWidgetState();
}

class _Step2ItemDetailsWidgetState extends State<Step2ItemDetails> {

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("New"), value: "new"),
      DropdownMenuItem(child: Text("Used"), value: "used"),
      DropdownMenuItem(child: Text("Used - like new"), value: "like-new"),
      DropdownMenuItem(child: Text("Bad"), value: "bad"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      // appBar: Text("Set Item Info"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 3,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormControl(
              label: "Item name",
              onChanged: (value) => widget.item.itemName = value!,
            ),
            Text(widget.item.itemName),
            FormControl(
                label: "Item description",
                onChanged: (value) => widget.item.itemDesc = value!),
            Text(widget.item.itemDesc),
            FormControl(
                label: "Serial number",
                onChanged: (value) => widget.item.itemSerial = value!),
            Text(widget.item.itemSerial),
        
            FormControl(
                label: "Item link", onChanged: (value) => widget.item.itemLink = value!),
            Text(widget.item.itemLink),
            FormControl(
                label: "Retail value",
                onChanged: (value) =>
                    widget.item.itemRetail = int.tryParse(value!) ?? 0),
            Text(widget.item.itemRetail.toString()),
            FormControl(
                label: "Current value",
                onChanged: (value) => widget.item.itemValue = int.tryParse(value!) ?? 0),
            Text(widget.item.itemValue.toString()),
            
            Row(
              children: [
                const Text("No Fees"),
                Switch(value: false, onChanged: widget.onChanged),
                const Text("Fees")
              ],
            ),
            Row(
              children: [
                Text("Item condition: "),
                DropdownButton(
                  items: dropdownItems,
                  value: dropdownItems[0].value,
                  onChanged: widget.onConditionSet,
                ),
              ],
            ),
            Align(
              child: Button(text: "Next", onPressed: widget.onNext),
              alignment: Alignment.bottomRight,
            ),
          ],
        ),
      ),
    );
  }
}
