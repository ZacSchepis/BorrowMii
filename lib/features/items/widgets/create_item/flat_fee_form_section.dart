import 'package:flutter/material.dart';

class FlatFeeFormSection extends StatefulWidget {
  final bool enabled;
  final int monthsThreshold;
  final ValueChanged<bool> onToggle;
  const FlatFeeFormSection(
      {super.key,
      required this.enabled,
      required this.monthsThreshold,
      required this.onToggle});

  @override
  State<StatefulWidget> createState() => _FlatFeeFormSectionWidgetState();
}

class _FlatFeeFormSectionWidgetState extends State<FlatFeeFormSection> {
  List<DropdownMenuItem<int>> get flatwaitDropDownItems {
    List<DropdownMenuItem<int>> menuItems = [
      DropdownMenuItem(child: Text("1 month"), value: 1),
      DropdownMenuItem(child: Text("2 months"), value: 2),
      DropdownMenuItem(child: Text("3 months"), value: 3),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text("Flat fee: Yes"),
            Switch(value: widget.enabled, onChanged: widget.onToggle),
            const Text("None")
          ],
        ),
        Builder(builder: (ctx) {
          if (widget.enabled) {
            return Row(
              children: [
                const Text("Flat fee after "),
                DropdownButton(
                  items: flatwaitDropDownItems,
                  value: 1,
                  onChanged: (v) => {},
                ),
                const Text(" overdue.")
              ],
            );
          }
          return Row();
        })
      ],
    );
  }
}
