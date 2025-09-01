import 'package:flutter/material.dart';
import 'package:team_d_project/data/models/item_model.dart';
import 'package:team_d_project/features/items/widgets/create_item/daily_late_fee_form_section.dart';
import 'package:team_d_project/features/items/widgets/create_item/flat_fee_form_section.dart';
import 'package:team_d_project/widgets/form_control.dart';

class Step3Fees extends StatefulWidget {
  final ItemModel item;

  const Step3Fees({super.key, required this.item});

  @override
  _Step3FeesWidgetState createState() => _Step3FeesWidgetState();
}

class _Step3FeesWidgetState extends State<Step3Fees> {
  @override
  Widget build(BuildContext ctx) {
    return Material(
      child: Form(
            child: Column(
          children: [
            DailyLateFeeFormSection(
              enabled: widget.item.dailyFeeEnabled,
              daysThreshold: widget.item.lateFeeDays,
              onToggle: (v) => setState(() => widget.item.dailyFeeEnabled = v),
              onDayFeeChanged: (v) =>
                  setState(() => widget.item.lateFeeCost = v),
              onDaysChanged: (v) => setState(() => widget.item.lateFeeDays = v),
            ),
            FlatFeeFormSection(
                enabled: widget.item.flatFeeEnabled,
                monthsThreshold: widget.item.flatFeeMonths,
                onToggle: (v) => setState(() => widget.item.flatFeeEnabled = v))
          ],
        )),
    );
  }
}
