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
      DropdownMenuItem(value: 1, child: Text("1 day")),
      DropdownMenuItem(value: 3, child: Text("3 days")),
      DropdownMenuItem(value: 7, child: Text("1 week")),
    ];
    return menuItems;
  }
  List<DropdownMenuItem<int>> get dailyFees {
    List<DropdownMenuItem<int>> items = [
      DropdownMenuItem(value: 1, child: Text("\$1"),),
      DropdownMenuItem(value: 2, child: Text("\$2"),),
      DropdownMenuItem(value: 3, child: Text("\$3"),),
    ];
    return items;
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
                        DropdownButton(items: dailyFees, value: 1, onChanged: (int? v) {
                          if(v != null) {
                            
                          }
                        },),
                        Text("Late fees applied after "),
                        DropdownButton(
                          items: dropdownItems,
                          value: widget.daysThreshold,
                          onChanged: (int? v) {
                            if(v != null) {
                              widget.onDaysChanged(v);
                            }
                          },
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