import 'package:flutter/material.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/features/items/widgets/create_item/daily_late_fee_form_section.dart';
import 'package:borrow_mii/features/items/widgets/create_item/flat_fee_form_section.dart';
import 'package:borrow_mii/widgets/form_control.dart';

class Step3Fees extends StatefulWidget {
  final ItemModel item;
  final VoidCallback onNext;
  const Step3Fees({super.key, required this.item, required this.onNext});

  @override
  _Step3FeesWidgetState createState() => _Step3FeesWidgetState();
}

class _Step3FeesWidgetState extends State<Step3Fees> {
  @override
  Widget build(BuildContext ctx) {
    bool dailyFeeEnabled = widget.item.dailyFeeEnabled ?? false;
    bool flatFeeEnabled = widget.item.flatFeeEnabled ?? false;
    int lateFeeDays = widget.item.lateFeeDays ?? 1;
    int flatFeeMonths = widget.item.flatFeeMonths ?? 1;
    return Material(
      child: Form(
            child: Column(
          children: [
            DailyLateFeeFormSection(
              enabled: dailyFeeEnabled,
              daysThreshold: lateFeeDays,
              onToggle: (v) => setState(() => widget.item.dailyFeeEnabled = v),
              onDayFeeChanged: (v) =>setState(() => widget.item.lateFeeCost = v),
              onDaysChanged: (v) => setState(() => widget.item.lateFeeDays = v),
            ),
            FlatFeeFormSection(
                enabled: flatFeeEnabled,
                monthsThreshold: flatFeeMonths,
                onMonthFeeChange: (v) => setState(() => widget.item.flatFeeCost = v),
                onMonthsChange: (v) => setState(() => widget.item.flatFeeMonths = v),
                onToggle: (v) => setState(() => widget.item.flatFeeEnabled = v))
                  ,Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(onPressed: widget.onNext, child: Text("Submit")),
          
        )
          ],
        )),
    );
  }
}
