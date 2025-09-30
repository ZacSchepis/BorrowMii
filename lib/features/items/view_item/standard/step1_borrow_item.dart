import 'dart:math';

import 'package:borrow_mii/core/styles/styles.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_info.dart';
import 'package:borrow_mii/widgets/button.dart';
import 'package:borrow_mii/widgets/form_control.dart';
import 'package:borrow_mii/widgets/skeletons/item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Step1BorrowItem extends StatefulWidget {
  final VoidCallback next;
  final DateTime returnDate;
  final DateTime borrowDate;
  final ValueChanged<DateTime> setReturnDate;
  final AsyncCallback borrow;
  final ValueChanged<DateTime> setBorrowDate;
  final bool picked;
  final ValueChanged<bool> setPicked;
  final ItemModel item;
  const Step1BorrowItem(
      {super.key,
      required this.next,
      required this.returnDate,
      required this.borrowDate,
      required this.setReturnDate,
      required this.setBorrowDate,
      required this.setPicked,
      required this.picked,
      required this.item,
      required this.borrow});

  @override
  State<Step1BorrowItem> createState() => _Step1BorrowItemWidgetState();
}

class _Step1BorrowItemWidgetState extends State<Step1BorrowItem> {
  final titleText = TextStyle(
    color: Colors.black,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              // showDateRangePicker(context: context, firstDate: firstDate, lastDate: lastDate)
              Row(children: [
                Button(
                    text: "Open Date Ranger Picker",
                    onPressed: () async {
                      final picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 30)),
                          initialDateRange: DateTimeRange(
                              start: widget.borrowDate,
                              end: widget.returnDate));
                      if (picked != null) {
                        widget.setBorrowDate(picked.start);
                        widget.setReturnDate(picked.end);
                        widget.setPicked(true);
                      }
                    })
              ]),
              Row(
                children: [
                  ItemInfo(
                    item: widget.item,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ],
              ),

              widget.picked
                  ? Row(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Borrow Date:", style: AppText.title),
                            Text(widget.borrowDate.toString(),
                                style: AppText.body),
                            SizedBox(height: 8),
                            Text("Promise to return by:", style: AppText.title),
                            Text(widget.returnDate.toString(),
                                style: AppText.body),
                          ],
                        )
                      ],
                    )
                  : SizedBox(),
              const Spacer(),
              widget.picked
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                              Button(text: "Borrow", onPressed: widget.borrow),
                                             ],
                    )
                  : SizedBox(),
            ],
          ),
        ));
  }
}
