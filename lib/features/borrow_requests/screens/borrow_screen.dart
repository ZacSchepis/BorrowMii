import 'package:borrow_mii/features/borrow_requests/screens/non_friendly_borrow.dart';
import 'package:flutter/material.dart';

class BorrowScreen extends StatefulWidget {
  const BorrowScreen({super.key});

  @override
  State<BorrowScreen> createState() => _BorrowScreenWidgetState();
}

class _BorrowScreenWidgetState extends State<BorrowScreen> {

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Text("Manage Borrow Requests"),
        Expanded(child: NonFriendlyBorrow()
        
        )
      ],
    );

  }
}