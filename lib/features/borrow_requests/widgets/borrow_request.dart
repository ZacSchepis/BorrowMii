import 'package:borrow_mii/core/constants/dialog_options.dart';
import 'package:borrow_mii/core/styles/styles.dart';
import 'package:borrow_mii/data/datasources/friends_state.dart';
import 'package:borrow_mii/data/models/borrow_order.dart';
import 'package:borrow_mii/data/models/user_model.dart';
import 'package:borrow_mii/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BorrowRequest extends StatefulWidget {
  final Future<void> Function(DialogOptions option) onChooseOption;
  final BorrowOrder borrowOrder;
  const BorrowRequest({
    super.key,
    required this.onChooseOption,
    required this.borrowOrder
  });

  @override
  State<BorrowRequest> createState() => _BorrowRequestWidgetState();
}

class _BorrowRequestWidgetState extends State<BorrowRequest> {

  @override
  Widget build(BuildContext context) {
    final id = widget.borrowOrder.borrowerId;
    if(id == null || id.isEmpty) {return SizedBox();}
    final friend = context.read<FriendsState>().getFriendById(id);
    
    // friend
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Item: ${widget.borrowOrder.name}"),
            Text("From: ${friend!.name}"),
            Text("Status: ${widget.borrowOrder.status.name}", style: AppText.subtitle,),
            Row(
              children: [
                Button(text: "Accept", color: AppColors.success, onPressed: () =>  widget.onChooseOption(DialogOptions.accept)),
                SizedBox(width: 8.0,),
                Button(text: "Reject", color: AppColors.error, onPressed: () =>  widget.onChooseOption(DialogOptions.reject))
              ],
            )
          ],
        ),
      )
    );

  }
}