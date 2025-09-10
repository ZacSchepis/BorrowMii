import 'package:flutter/material.dart';
import 'package:borrow_mii/widgets/form_control.dart';

class DailyLateFeeFormSection extends StatefulWidget {
  final bool enabled;
  final int daysThreshold;
  final ValueChanged<bool> onToggle;
  final ValueChanged<int> onDaysChanged;
  final ValueChanged<int> onDayFeeChanged;
  const DailyLateFeeFormSection({
    super.key,
    required this.enabled,
    required this.daysThreshold,
    required this.onDaysChanged,
    required this.onToggle,
    required this.onDayFeeChanged
  });

  @override
  _DailyLateFeeFormSectionWidgetState createState() => _DailyLateFeeFormSectionWidgetState();

}

class _DailyLateFeeFormSectionWidgetState extends State<DailyLateFeeFormSection> {
  List<DropdownMenuItem<int>> get dropdownItems {
    List<DropdownMenuItem<int>> menuItems = [
      DropdownMenuItem(child: Text("1 day"), value: 1),
      DropdownMenuItem(child: Text("3 days"), value: 3),
      DropdownMenuItem(child: Text("1 week"), value: 7),
    ];
    return menuItems;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            // FormControl(
            //   label: "Daily late fee", 
            //   onChanged: (v) => {}, 
            //   validator: (v) => null
            //   ),
            Row(
              children: [
                const Text("Daily late fees: Yes"),
                Switch(value: widget.enabled, onChanged: widget.onToggle),
                const Text("None")
              ],
            ),
            Builder(builder: (ctx) {
              if(widget.enabled) {
                return Row(
                      children: [
                        Text("Late fees applied after "),
                        DropdownButton(
                          items: dropdownItems,
                          value: 1,
                          onChanged: (v) => {},
                        ),
                        Text(" overdue.")
                      ],
                    );
              } return Row();
            })

      ],
    );

  }
}