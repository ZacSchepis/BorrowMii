import 'package:flutter/material.dart';
import 'package:team_d_project/data/models/item_model.dart';
import 'package:team_d_project/widgets/button.dart';

class Step2ItemDetails extends StatelessWidget {
  final VoidCallback onNext;
  ItemModel item;
  final ValueChanged<bool> onChanged;
  final ValueChanged<String?> onConditionSet;
  Step2ItemDetails({
    super.key, 
    required this.onNext, 
    required this.item, 
    required this.onChanged,
    required this.onConditionSet
  });
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
      body: Column(
        spacing: 3,
        children: [
          Row(
            children: [
              const Text("Item Name"),
              SizedBox(
                width: 250,
                child: TextField(
                  textInputAction: TextInputAction.go,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'item name'),
                  onSubmitted: (value) {
                    item.itemName = value;
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("Item Description"),
              SizedBox(
                width: 250,
                child: TextField(
                  textInputAction: TextInputAction.go,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'description'),
                  onSubmitted: (value) {
                    item.itemDesc = value;
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("Fees?"),
              Switch(value: false, onChanged: onChanged)
            ],
          ),
          Row(
            children: [
              const Text("Serial Number"),
              SizedBox(
                width: 250,
                child: TextField(
                  textInputAction: TextInputAction.go,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'serial number'),
                  onSubmitted: (value) {
                    item.itemSerial = value;
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("Retail Value"),
              SizedBox(
                width: 250,
                child: TextField(
                  textInputAction: TextInputAction.go,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'retail value'),
                  onSubmitted: (value) {
                    item.itemRetail = int.tryParse(value) ?? 0;
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("Current Value"),
              SizedBox(
                width: 250,
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'current value'),
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) {
                    item.itemValue = int.tryParse(value) ?? 0;
                  },
                ),
              )
            ],
          ),
          DropdownButton(
            items: dropdownItems, 
            value: "good",
            onChanged: onConditionSet,

            
            ),


          Align(
            child: Button(text: "Next", onPressed: onNext),
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
    );
  }
}
